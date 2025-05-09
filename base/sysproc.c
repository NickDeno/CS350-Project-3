#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

extern int ipid;

int
sys_mask(void)
{
  int bit_mask;

  if(argint(0, &bit_mask) < 0)
    return -1;
  return mask(bit_mask);
}

int sys_pstat(void){
  int pid;

  if(argint(0, &pid) < 0){
    return -1;
  }
  return p_stat(pid);
}

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_term(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return term(pid);
}

int sys_stop (void){
  int pid;
  if(argint(0, &pid) < 0)
    return -1;
  return stop(pid);
}

int sys_cont (void){
  int pid;
  if(argint(0, &pid) < 0)
    return -1;
  return cont(pid);
}

int sys_setipid(void){
  int pid;
  if(argint(0, &pid) < 0)
    return -1;
  ipid = pid;
  return 0;
}

int
sys_interrupt(void)
{
  int pid;
  if(argint(0, &pid) < 0)
    return -1;
  return interrupt(pid);  
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int sys_shutdown(void)
{
  /* Either of the following will work. Does not harm to put them together. */
  outw(0xB004, 0x0|0x2000); // working for old qemu
  outw(0x604, 0x0|0x2000); // working for newer qemu
  
  return 0;
}

int
sys_cps(void)
{
  return cps();
}

int
sys_chpr(void)
{
  int pid, pr;
  if(argint(0, &pid) < 0)
    return -1;
  if(argint(1, &pr) < 0)
    return -1;

  return chpr(pid, pr);
}


