#include <linux/module.h>
#include <linux/kprobes.h>
#include <linux/stacktrace.h>

#define MAX_STACK 32

static int handler_pre(struct kprobe *p, struct pt_regs *regs)
{
    unsigned long stack_entries[MAX_STACK];
    int depth, i;

    depth = stack_trace_save(stack_entries, MAX_STACK, 0);

    pr_info("kprobe(%s): kernel stack trace:\n", p->symbol_name);
    for (i = 0; i < depth; i++)
        pr_info("[<%pK>] %pS\n",
                            (void *)stack_entries[i],
                            (void *)stack_entries[i]);
    return 0;
}

static struct kprobe probes[] = {
    { .symbol_name = "default_send_IPI_allbutself",            .pre_handler = handler_pre },
    { .symbol_name = "default_send_IPI_all",                     .pre_handler = handler_pre },
    { .symbol_name = "default_send_IPI_self",      .pre_handler = handler_pre },
    { .symbol_name = "native_apic_icr_write",      .pre_handler = handler_pre },
};


static int __init kprobe_init(void)
{
    // Build pointer array of existing symbols
    for (size_t i = 0; i < ARRAY_SIZE(probes); i++) {
        
        int ret = register_kprobe(&probes[i]);
        if (ret) {
            printk(KERN_INFO "register_kprobe %s failed: %d\n", probes[i].symbol_name, ret);
            return ret;
        }
    }
    pr_info("kprobes registered\n");
    return 0;
}

static void __exit kprobe_exit(void)
{
    for (size_t i = 0; i < ARRAY_SIZE(probes); i++) {
        unregister_kprobe(&probes[i]);
    }
    pr_info("kprobes unregistered\n");
}

module_init(kprobe_init);
module_exit(kprobe_exit);
MODULE_LICENSE("GPL");