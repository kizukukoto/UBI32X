/*
 *	Generic parts
 *	Linux ethernet bridge
 *
 *	Authors:
 *	Lennert Buytenhek		<buytenh@gnu.org>
 *
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License
 *	as published by the Free Software Foundation; either version
 *	2 of the License, or (at your option) any later version.
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/init.h>
#include <linux/llc.h>
#include <net/llc.h>
#include <net/stp.h>

#include "br_private.h"

int (*br_should_route_hook)(struct sk_buff *skb);

static const struct stp_proto br_stp_proto = {
	.rcv	= br_stp_rcv,
};

static struct pernet_operations br_net_ops = {
	.exit	= br_net_exit,
};

/*
 * br_port_dev_get()
 *	Using the given addr identify the port to which it is reachable,
 * 	returing a reference to the net device associated with that port.
 *
 * NOTE: Return NULL if given dev is not a bridge or the mac has no associated port
 */
struct net_device *br_port_dev_get(struct net_device *dev, unsigned char *addr)
{
	struct net_bridge_fdb_entry *fdbe;
	struct net_bridge *br;
	struct net_device *pdev;

	/*
	 * Is this a bridge?
	 */
	if (!(dev->priv_flags & IFF_EBRIDGE)) {
		return NULL;
	}

	/*
	 * Lookup the fdb entry
	 */
	br = netdev_priv(dev);
	rcu_read_lock();
	fdbe = __br_fdb_get(br, addr);
	if (!fdbe) {
		rcu_read_unlock();
		return NULL;
	}

	/*
	 * Get reference to the port dev
	 */
	pdev = fdbe->dst->dev;
	dev_hold(pdev);
	rcu_read_unlock();

	return pdev;
}
EXPORT_SYMBOL(br_port_dev_get);

static int __init br_init(void)
{
	int err;

#if CONFIG_BRIDGE_ALPHA_MULTICAST_SNOOP
	struct proc_dir_entry *alpha_dir=NULL;

	alpha_dir = proc_mkdir("alpha", NULL);
	if (alpha_dir == NULL) {
		return ERR_PTR(-ENOMEM);
	}
#endif

	err = stp_proto_register(&br_stp_proto);
	if (err < 0) {
		pr_err("bridge: can't register sap for STP\n");
		return err;
	}

	err = br_fdb_init();
	if (err)
		goto err_out;

	err = register_pernet_subsys(&br_net_ops);
	if (err)
		goto err_out1;

	err = br_netfilter_init();
	if (err)
		goto err_out2;

	err = register_netdevice_notifier(&br_device_notifier);
	if (err)
		goto err_out3;

	err = br_netlink_init();
	if (err)
		goto err_out4;

	brioctl_set(br_ioctl_deviceless_stub);

#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
	br_fdb_test_addr_hook = br_fdb_test_addr;
#endif

	return 0;
err_out4:
	unregister_netdevice_notifier(&br_device_notifier);
err_out3:
	br_netfilter_fini();
err_out2:
	unregister_pernet_subsys(&br_net_ops);
err_out1:
	br_fdb_fini();
err_out:
	stp_proto_unregister(&br_stp_proto);
	return err;
}

static void __exit br_deinit(void)
{
#if CONFIG_BRIDGE_ALPHA_MULTICAST_SNOOP
	remove_proc_entry("alpha", 0);
#endif

	stp_proto_unregister(&br_stp_proto);

	br_netlink_fini();
	unregister_netdevice_notifier(&br_device_notifier);
	brioctl_set(NULL);

	unregister_pernet_subsys(&br_net_ops);

	rcu_barrier(); /* Wait for completion of call_rcu()'s */

	br_netfilter_fini();
#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
	br_fdb_test_addr_hook = NULL;
#endif

	br_fdb_fini();
}

EXPORT_SYMBOL(br_should_route_hook);

module_init(br_init)
module_exit(br_deinit)
MODULE_LICENSE("GPL");
MODULE_VERSION(BR_VERSION);
