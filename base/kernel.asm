
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 80 10 00       	mov    $0x108000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc b0 00 12 80       	mov    $0x801200b0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 10 30 10 80       	mov    $0x80103010,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 95 10 80       	mov    $0x80109554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 60 76 10 80       	push   $0x80107660
80100051:	68 20 95 10 80       	push   $0x80109520
80100056:	e8 c5 46 00 00       	call   80104720 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c 90 11 80       	mov    $0x8011901c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c 90 11 80 1c 	movl   $0x8011901c,0x8011906c
8010006a:	90 11 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 90 11 80 1c 	movl   $0x8011901c,0x80119070
80100074:	90 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c 90 11 80 	movl   $0x8011901c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 76 10 80       	push   $0x80107667
80100097:	50                   	push   %eax
80100098:	e8 73 45 00 00       	call   80104610 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 90 11 80       	mov    0x80119070,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 08 00 00    	lea    0x85c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 90 11 80    	mov    %ebx,0x80119070
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 87 11 80    	cmp    $0x801187c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 95 10 80       	push   $0x80109520
801000e4:	e8 57 47 00 00       	call   80104840 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 90 11 80    	mov    0x80119070,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c 90 11 80    	cmp    $0x8011901c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c 90 11 80    	cmp    $0x8011901c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c 90 11 80    	mov    0x8011906c,%ebx
80100126:	81 fb 1c 90 11 80    	cmp    $0x8011901c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 90 11 80    	cmp    $0x8011901c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 95 10 80       	push   $0x80109520
80100162:	e8 19 48 00 00       	call   80104980 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 de 44 00 00       	call   80104650 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 df 21 00 00       	call   80102370 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 6e 76 10 80       	push   $0x8010766e
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 2d 45 00 00       	call   801046f0 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
  iderw(b);
801001d4:	e9 97 21 00 00       	jmp    80102370 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 7f 76 10 80       	push   $0x8010767f
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 ec 44 00 00       	call   801046f0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 9c 44 00 00       	call   801046b0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 95 10 80 	movl   $0x80109520,(%esp)
8010021b:	e8 20 46 00 00       	call   80104840 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010023f:	a1 70 90 11 80       	mov    0x80119070,%eax
    b->prev = &bcache.head;
80100244:	c7 43 50 1c 90 11 80 	movl   $0x8011901c,0x50(%ebx)
    b->next = bcache.head.next;
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010024e:	a1 70 90 11 80       	mov    0x80119070,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100256:	89 1d 70 90 11 80    	mov    %ebx,0x80119070
  }
  
  release(&bcache.lock);
8010025c:	c7 45 08 20 95 10 80 	movl   $0x80109520,0x8(%ebp)
}
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
  release(&bcache.lock);
80100269:	e9 12 47 00 00       	jmp    80104980 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 86 76 10 80       	push   $0x80107686
80100276:	e8 05 01 00 00       	call   80100380 <panic>
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 37 16 00 00       	call   801018d0 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 99 11 80 	movl   $0x80119920,(%esp)
801002a0:	e8 9b 45 00 00       	call   80104840 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 99 11 80       	mov    0x80119900,%eax
801002b5:	39 05 04 99 11 80    	cmp    %eax,0x80119904
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 99 11 80       	push   $0x80119920
801002c8:	68 00 99 11 80       	push   $0x80119900
801002cd:	e8 5e 3d 00 00       	call   80104030 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 99 11 80       	mov    0x80119900,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 99 11 80    	cmp    0x80119904,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 79 36 00 00       	call   80103960 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 99 11 80       	push   $0x80119920
801002f6:	e8 85 46 00 00       	call   80104980 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 ec 14 00 00       	call   801017f0 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 99 11 80    	mov    %edx,0x80119900
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 98 11 80 	movsbl -0x7fee6780(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 99 11 80       	push   $0x80119920
8010034c:	e8 2f 46 00 00       	call   80104980 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 96 14 00 00       	call   801017f0 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 99 11 80       	mov    %eax,0x80119900
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli
  cons.locking = 0;
80100389:	c7 05 54 99 11 80 00 	movl   $0x0,0x80119954
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 12 25 00 00       	call   801028b0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 8d 76 10 80       	push   $0x8010768d
801003a7:	e8 04 03 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 fb 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 37 7e 10 80 	movl   $0x80107e37,(%esp)
801003bc:	e8 ef 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 73 43 00 00       	call   80104740 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 a1 76 10 80       	push   $0x801076a1
801003dd:	e8 ce 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 99 11 80 01 	movl   $0x1,0x80119958
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
80100409:	3d 00 01 00 00       	cmp    $0x100,%eax
8010040e:	0f 84 cc 00 00 00    	je     801004e0 <consputc.part.0+0xe0>
    uartputc(c);
80100414:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100417:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010041c:	89 c3                	mov    %eax,%ebx
8010041e:	50                   	push   %eax
8010041f:	e8 8c 5d 00 00       	call   801061b0 <uartputc>
80100424:	b8 0e 00 00 00       	mov    $0xe,%eax
80100429:	89 fa                	mov    %edi,%edx
8010042b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042c:	be d5 03 00 00       	mov    $0x3d5,%esi
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100434:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100437:	89 fa                	mov    %edi,%edx
80100439:	b8 0f 00 00 00       	mov    $0xf,%eax
8010043e:	c1 e1 08             	shl    $0x8,%ecx
80100441:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100442:	89 f2                	mov    %esi,%edx
80100444:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100445:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
80100448:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	75 76                	jne    801004c8 <consputc.part.0+0xc8>
    pos += 80 - pos%80;
80100452:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100457:	f7 e2                	mul    %edx
80100459:	c1 ea 06             	shr    $0x6,%edx
8010045c:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010045f:	c1 e0 04             	shl    $0x4,%eax
80100462:	8d 70 50             	lea    0x50(%eax),%esi
  if(pos < 0 || pos > 25*80)
80100465:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
8010046b:	0f 8f 2f 01 00 00    	jg     801005a0 <consputc.part.0+0x1a0>
  if((pos/80) >= 24){  // Scroll up.
80100471:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100477:	0f 8f c3 00 00 00    	jg     80100540 <consputc.part.0+0x140>
  outb(CRTPORT+1, pos>>8);
8010047d:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
8010047f:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100486:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100489:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048c:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100491:	b8 0e 00 00 00       	mov    $0xe,%eax
80100496:	89 da                	mov    %ebx,%edx
80100498:	ee                   	out    %al,(%dx)
80100499:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010049e:	89 f8                	mov    %edi,%eax
801004a0:	89 ca                	mov    %ecx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b8 0f 00 00 00       	mov    $0xf,%eax
801004a8:	89 da                	mov    %ebx,%edx
801004aa:	ee                   	out    %al,(%dx)
801004ab:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004af:	89 ca                	mov    %ecx,%edx
801004b1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b2:	b8 20 07 00 00       	mov    $0x720,%eax
801004b7:	66 89 06             	mov    %ax,(%esi)
}
801004ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004bd:	5b                   	pop    %ebx
801004be:	5e                   	pop    %esi
801004bf:	5f                   	pop    %edi
801004c0:	5d                   	pop    %ebp
801004c1:	c3                   	ret
801004c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  } else if(c == 0x41) {
801004c8:	83 fb 41             	cmp    $0x41,%ebx
801004cb:	74 ed                	je     801004ba <consputc.part.0+0xba>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004cd:	0f b6 db             	movzbl %bl,%ebx
801004d0:	8d 70 01             	lea    0x1(%eax),%esi
801004d3:	80 cf 07             	or     $0x7,%bh
801004d6:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
801004dd:	80 
801004de:	eb 85                	jmp    80100465 <consputc.part.0+0x65>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e0:	83 ec 0c             	sub    $0xc,%esp
801004e3:	be d4 03 00 00       	mov    $0x3d4,%esi
801004e8:	6a 08                	push   $0x8
801004ea:	e8 c1 5c 00 00       	call   801061b0 <uartputc>
801004ef:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f6:	e8 b5 5c 00 00       	call   801061b0 <uartputc>
801004fb:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100502:	e8 a9 5c 00 00       	call   801061b0 <uartputc>
80100507:	b8 0e 00 00 00       	mov    $0xe,%eax
8010050c:	89 f2                	mov    %esi,%edx
8010050e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010050f:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100514:	89 da                	mov    %ebx,%edx
80100516:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100517:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010051a:	89 f2                	mov    %esi,%edx
8010051c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100521:	c1 e1 08             	shl    $0x8,%ecx
80100524:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100525:	89 da                	mov    %ebx,%edx
80100527:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100528:	0f b6 f0             	movzbl %al,%esi
    if(pos > 0) --pos;
8010052b:	83 c4 10             	add    $0x10,%esp
8010052e:	09 ce                	or     %ecx,%esi
80100530:	74 5e                	je     80100590 <consputc.part.0+0x190>
80100532:	83 ee 01             	sub    $0x1,%esi
80100535:	e9 2b ff ff ff       	jmp    80100465 <consputc.part.0+0x65>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010054d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100552:	68 60 0e 00 00       	push   $0xe60
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 fa 44 00 00       	call   80104a60 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 55 44 00 00       	call   801049d0 <memset>
  outb(CRTPORT+1, pos);
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 06 ff ff ff       	jmp    8010048c <consputc.part.0+0x8c>
80100586:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058d:	8d 76 00             	lea    0x0(%esi),%esi
80100590:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80100594:	be 00 80 0b 80       	mov    $0x800b8000,%esi
80100599:	31 ff                	xor    %edi,%edi
8010059b:	e9 ec fe ff ff       	jmp    8010048c <consputc.part.0+0x8c>
    panic("pos under/overflow");
801005a0:	83 ec 0c             	sub    $0xc,%esp
801005a3:	68 a5 76 10 80       	push   $0x801076a5
801005a8:	e8 d3 fd ff ff       	call   80100380 <panic>
801005ad:	8d 76 00             	lea    0x0(%esi),%esi

801005b0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005b0:	55                   	push   %ebp
801005b1:	89 e5                	mov    %esp,%ebp
801005b3:	57                   	push   %edi
801005b4:	56                   	push   %esi
801005b5:	53                   	push   %ebx
801005b6:	83 ec 18             	sub    $0x18,%esp
801005b9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005bc:	ff 75 08             	push   0x8(%ebp)
801005bf:	e8 0c 13 00 00       	call   801018d0 <iunlock>
  acquire(&cons.lock);
801005c4:	c7 04 24 20 99 11 80 	movl   $0x80119920,(%esp)
801005cb:	e8 70 42 00 00       	call   80104840 <acquire>
  for(i = 0; i < n; i++)
801005d0:	83 c4 10             	add    $0x10,%esp
801005d3:	85 f6                	test   %esi,%esi
801005d5:	7e 25                	jle    801005fc <consolewrite+0x4c>
801005d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005da:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005dd:	8b 15 58 99 11 80    	mov    0x80119958,%edx
    consputc(buf[i] & 0xff);
801005e3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005e6:	85 d2                	test   %edx,%edx
801005e8:	74 06                	je     801005f0 <consolewrite+0x40>
  asm volatile("cli");
801005ea:	fa                   	cli
    for(;;)
801005eb:	eb fe                	jmp    801005eb <consolewrite+0x3b>
801005ed:	8d 76 00             	lea    0x0(%esi),%esi
801005f0:	e8 0b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005f5:	83 c3 01             	add    $0x1,%ebx
801005f8:	39 df                	cmp    %ebx,%edi
801005fa:	75 e1                	jne    801005dd <consolewrite+0x2d>
  release(&cons.lock);
801005fc:	83 ec 0c             	sub    $0xc,%esp
801005ff:	68 20 99 11 80       	push   $0x80119920
80100604:	e8 77 43 00 00       	call   80104980 <release>
  ilock(ip);
80100609:	58                   	pop    %eax
8010060a:	ff 75 08             	push   0x8(%ebp)
8010060d:	e8 de 11 00 00       	call   801017f0 <ilock>

  return n;
}
80100612:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100615:	89 f0                	mov    %esi,%eax
80100617:	5b                   	pop    %ebx
80100618:	5e                   	pop    %esi
80100619:	5f                   	pop    %edi
8010061a:	5d                   	pop    %ebp
8010061b:	c3                   	ret
8010061c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100620 <printint>:
{
80100620:	55                   	push   %ebp
80100621:	89 e5                	mov    %esp,%ebp
80100623:	57                   	push   %edi
80100624:	56                   	push   %esi
80100625:	89 c6                	mov    %eax,%esi
80100627:	53                   	push   %ebx
80100628:	89 d3                	mov    %edx,%ebx
8010062a:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010062d:	85 c9                	test   %ecx,%ecx
8010062f:	74 04                	je     80100635 <printint+0x15>
80100631:	85 c0                	test   %eax,%eax
80100633:	78 63                	js     80100698 <printint+0x78>
    x = xx;
80100635:	89 f1                	mov    %esi,%ecx
80100637:	31 c0                	xor    %eax,%eax
  i = 0;
80100639:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010063c:	31 f6                	xor    %esi,%esi
8010063e:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
80100640:	89 c8                	mov    %ecx,%eax
80100642:	31 d2                	xor    %edx,%edx
80100644:	89 f7                	mov    %esi,%edi
80100646:	f7 f3                	div    %ebx
80100648:	8d 76 01             	lea    0x1(%esi),%esi
8010064b:	0f b6 92 d0 76 10 80 	movzbl -0x7fef8930(%edx),%edx
80100652:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100656:	89 ca                	mov    %ecx,%edx
80100658:	89 c1                	mov    %eax,%ecx
8010065a:	39 da                	cmp    %ebx,%edx
8010065c:	73 e2                	jae    80100640 <printint+0x20>
  if(sign)
8010065e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100661:	85 c0                	test   %eax,%eax
80100663:	74 07                	je     8010066c <printint+0x4c>
    buf[i++] = '-';
80100665:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
8010066a:	89 f7                	mov    %esi,%edi
8010066c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010066f:	01 df                	add    %ebx,%edi
  if(panicked){
80100671:	8b 15 58 99 11 80    	mov    0x80119958,%edx
    consputc(buf[i]);
80100677:	0f be 07             	movsbl (%edi),%eax
  if(panicked){
8010067a:	85 d2                	test   %edx,%edx
8010067c:	74 0a                	je     80100688 <printint+0x68>
8010067e:	fa                   	cli
    for(;;)
8010067f:	eb fe                	jmp    8010067f <printint+0x5f>
80100681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100688:	e8 73 fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
8010068d:	8d 47 ff             	lea    -0x1(%edi),%eax
80100690:	39 df                	cmp    %ebx,%edi
80100692:	74 0c                	je     801006a0 <printint+0x80>
80100694:	89 c7                	mov    %eax,%edi
80100696:	eb d9                	jmp    80100671 <printint+0x51>
80100698:	89 c8                	mov    %ecx,%eax
    x = -xx;
8010069a:	89 f1                	mov    %esi,%ecx
8010069c:	f7 d9                	neg    %ecx
8010069e:	eb 99                	jmp    80100639 <printint+0x19>
}
801006a0:	83 c4 2c             	add    $0x2c,%esp
801006a3:	5b                   	pop    %ebx
801006a4:	5e                   	pop    %esi
801006a5:	5f                   	pop    %edi
801006a6:	5d                   	pop    %ebp
801006a7:	c3                   	ret
801006a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801006af:	90                   	nop

801006b0 <cprintf>:
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006b9:	8b 3d 54 99 11 80    	mov    0x80119954,%edi
  if (fmt == 0)
801006bf:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
801006c2:	85 ff                	test   %edi,%edi
801006c4:	0f 85 36 01 00 00    	jne    80100800 <cprintf+0x150>
  if (fmt == 0)
801006ca:	85 f6                	test   %esi,%esi
801006cc:	0f 84 e0 01 00 00    	je     801008b2 <cprintf+0x202>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d2:	0f b6 06             	movzbl (%esi),%eax
801006d5:	85 c0                	test   %eax,%eax
801006d7:	74 6b                	je     80100744 <cprintf+0x94>
  argp = (uint*)(void*)(&fmt + 1);
801006d9:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006dc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801006df:	31 db                	xor    %ebx,%ebx
801006e1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
801006e3:	83 f8 25             	cmp    $0x25,%eax
801006e6:	0f 85 dc 00 00 00    	jne    801007c8 <cprintf+0x118>
    c = fmt[++i] & 0xff;
801006ec:	83 c3 01             	add    $0x1,%ebx
801006ef:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801006f3:	85 c9                	test   %ecx,%ecx
801006f5:	74 42                	je     80100739 <cprintf+0x89>
    switch(c){
801006f7:	83 f9 70             	cmp    $0x70,%ecx
801006fa:	0f 84 99 00 00 00    	je     80100799 <cprintf+0xe9>
80100700:	7f 4e                	jg     80100750 <cprintf+0xa0>
80100702:	83 f9 25             	cmp    $0x25,%ecx
80100705:	0f 84 cd 00 00 00    	je     801007d8 <cprintf+0x128>
8010070b:	83 f9 64             	cmp    $0x64,%ecx
8010070e:	0f 85 24 01 00 00    	jne    80100838 <cprintf+0x188>
      printint(*argp++, 10, 1);
80100714:	8d 47 04             	lea    0x4(%edi),%eax
80100717:	b9 01 00 00 00       	mov    $0x1,%ecx
8010071c:	ba 0a 00 00 00       	mov    $0xa,%edx
80100721:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100724:	8b 07                	mov    (%edi),%eax
80100726:	e8 f5 fe ff ff       	call   80100620 <printint>
8010072b:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010072e:	83 c3 01             	add    $0x1,%ebx
80100731:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100735:	85 c0                	test   %eax,%eax
80100737:	75 aa                	jne    801006e3 <cprintf+0x33>
80100739:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
8010073c:	85 ff                	test   %edi,%edi
8010073e:	0f 85 df 00 00 00    	jne    80100823 <cprintf+0x173>
}
80100744:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100747:	5b                   	pop    %ebx
80100748:	5e                   	pop    %esi
80100749:	5f                   	pop    %edi
8010074a:	5d                   	pop    %ebp
8010074b:	c3                   	ret
8010074c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100750:	83 f9 73             	cmp    $0x73,%ecx
80100753:	75 3b                	jne    80100790 <cprintf+0xe0>
      if((s = (char*)*argp++) == 0)
80100755:	8b 17                	mov    (%edi),%edx
80100757:	8d 47 04             	lea    0x4(%edi),%eax
8010075a:	85 d2                	test   %edx,%edx
8010075c:	0f 85 0e 01 00 00    	jne    80100870 <cprintf+0x1c0>
80100762:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
80100767:	bf b8 76 10 80       	mov    $0x801076b8,%edi
8010076c:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010076f:	89 fb                	mov    %edi,%ebx
80100771:	89 f7                	mov    %esi,%edi
80100773:	89 c6                	mov    %eax,%esi
80100775:	0f be c1             	movsbl %cl,%eax
  if(panicked){
80100778:	8b 15 58 99 11 80    	mov    0x80119958,%edx
8010077e:	85 d2                	test   %edx,%edx
80100780:	0f 84 fe 00 00 00    	je     80100884 <cprintf+0x1d4>
80100786:	fa                   	cli
    for(;;)
80100787:	eb fe                	jmp    80100787 <cprintf+0xd7>
80100789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100790:	83 f9 78             	cmp    $0x78,%ecx
80100793:	0f 85 9f 00 00 00    	jne    80100838 <cprintf+0x188>
      printint(*argp++, 16, 0);
80100799:	8d 47 04             	lea    0x4(%edi),%eax
8010079c:	31 c9                	xor    %ecx,%ecx
8010079e:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007a3:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
801007a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007a9:	8b 07                	mov    (%edi),%eax
801007ab:	e8 70 fe ff ff       	call   80100620 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b0:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
801007b4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b7:	85 c0                	test   %eax,%eax
801007b9:	0f 85 24 ff ff ff    	jne    801006e3 <cprintf+0x33>
801007bf:	e9 75 ff ff ff       	jmp    80100739 <cprintf+0x89>
801007c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
801007c8:	8b 0d 58 99 11 80    	mov    0x80119958,%ecx
801007ce:	85 c9                	test   %ecx,%ecx
801007d0:	74 15                	je     801007e7 <cprintf+0x137>
801007d2:	fa                   	cli
    for(;;)
801007d3:	eb fe                	jmp    801007d3 <cprintf+0x123>
801007d5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007d8:	8b 0d 58 99 11 80    	mov    0x80119958,%ecx
801007de:	85 c9                	test   %ecx,%ecx
801007e0:	75 7e                	jne    80100860 <cprintf+0x1b0>
801007e2:	b8 25 00 00 00       	mov    $0x25,%eax
801007e7:	e8 14 fc ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007ec:	83 c3 01             	add    $0x1,%ebx
801007ef:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007f3:	85 c0                	test   %eax,%eax
801007f5:	0f 85 e8 fe ff ff    	jne    801006e3 <cprintf+0x33>
801007fb:	e9 39 ff ff ff       	jmp    80100739 <cprintf+0x89>
    acquire(&cons.lock);
80100800:	83 ec 0c             	sub    $0xc,%esp
80100803:	68 20 99 11 80       	push   $0x80119920
80100808:	e8 33 40 00 00       	call   80104840 <acquire>
  if (fmt == 0)
8010080d:	83 c4 10             	add    $0x10,%esp
80100810:	85 f6                	test   %esi,%esi
80100812:	0f 84 9a 00 00 00    	je     801008b2 <cprintf+0x202>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100818:	0f b6 06             	movzbl (%esi),%eax
8010081b:	85 c0                	test   %eax,%eax
8010081d:	0f 85 b6 fe ff ff    	jne    801006d9 <cprintf+0x29>
    release(&cons.lock);
80100823:	83 ec 0c             	sub    $0xc,%esp
80100826:	68 20 99 11 80       	push   $0x80119920
8010082b:	e8 50 41 00 00       	call   80104980 <release>
80100830:	83 c4 10             	add    $0x10,%esp
80100833:	e9 0c ff ff ff       	jmp    80100744 <cprintf+0x94>
  if(panicked){
80100838:	8b 15 58 99 11 80    	mov    0x80119958,%edx
8010083e:	85 d2                	test   %edx,%edx
80100840:	75 26                	jne    80100868 <cprintf+0x1b8>
80100842:	b8 25 00 00 00       	mov    $0x25,%eax
80100847:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010084a:	e8 b1 fb ff ff       	call   80100400 <consputc.part.0>
8010084f:	a1 58 99 11 80       	mov    0x80119958,%eax
80100854:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80100857:	85 c0                	test   %eax,%eax
80100859:	74 4b                	je     801008a6 <cprintf+0x1f6>
8010085b:	fa                   	cli
    for(;;)
8010085c:	eb fe                	jmp    8010085c <cprintf+0x1ac>
8010085e:	66 90                	xchg   %ax,%ax
80100860:	fa                   	cli
80100861:	eb fe                	jmp    80100861 <cprintf+0x1b1>
80100863:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100867:	90                   	nop
80100868:	fa                   	cli
80100869:	eb fe                	jmp    80100869 <cprintf+0x1b9>
8010086b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010086f:	90                   	nop
      for(; *s; s++)
80100870:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100873:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100875:	84 c9                	test   %cl,%cl
80100877:	0f 85 ef fe ff ff    	jne    8010076c <cprintf+0xbc>
      if((s = (char*)*argp++) == 0)
8010087d:	89 c7                	mov    %eax,%edi
8010087f:	e9 aa fe ff ff       	jmp    8010072e <cprintf+0x7e>
80100884:	e8 77 fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
80100889:	0f be 43 01          	movsbl 0x1(%ebx),%eax
8010088d:	83 c3 01             	add    $0x1,%ebx
80100890:	84 c0                	test   %al,%al
80100892:	0f 85 e0 fe ff ff    	jne    80100778 <cprintf+0xc8>
      if((s = (char*)*argp++) == 0)
80100898:	89 f0                	mov    %esi,%eax
8010089a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010089d:	89 fe                	mov    %edi,%esi
8010089f:	89 c7                	mov    %eax,%edi
801008a1:	e9 88 fe ff ff       	jmp    8010072e <cprintf+0x7e>
801008a6:	89 c8                	mov    %ecx,%eax
801008a8:	e8 53 fb ff ff       	call   80100400 <consputc.part.0>
801008ad:	e9 7c fe ff ff       	jmp    8010072e <cprintf+0x7e>
    panic("null fmt");
801008b2:	83 ec 0c             	sub    $0xc,%esp
801008b5:	68 bf 76 10 80       	push   $0x801076bf
801008ba:	e8 c1 fa ff ff       	call   80100380 <panic>
801008bf:	90                   	nop

801008c0 <consoleintr>:
{
801008c0:	55                   	push   %ebp
801008c1:	89 e5                	mov    %esp,%ebp
801008c3:	57                   	push   %edi
801008c4:	56                   	push   %esi
  int c, doprocdump = 0;   
801008c5:	31 f6                	xor    %esi,%esi
{
801008c7:	53                   	push   %ebx
801008c8:	83 ec 18             	sub    $0x18,%esp
801008cb:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
801008ce:	68 20 99 11 80       	push   $0x80119920
801008d3:	e8 68 3f 00 00       	call   80104840 <acquire>
  while((c = getc()) >= 0){
801008d8:	83 c4 10             	add    $0x10,%esp
801008db:	eb 1a                	jmp    801008f7 <consoleintr+0x37>
801008dd:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801008e0:	83 fb 08             	cmp    $0x8,%ebx
801008e3:	0f 84 d7 00 00 00    	je     801009c0 <consoleintr+0x100>
801008e9:	83 fb 10             	cmp    $0x10,%ebx
801008ec:	0f 85 2d 01 00 00    	jne    80100a1f <consoleintr+0x15f>
801008f2:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
801008f7:	ff d7                	call   *%edi
801008f9:	89 c3                	mov    %eax,%ebx
801008fb:	85 c0                	test   %eax,%eax
801008fd:	0f 88 e5 00 00 00    	js     801009e8 <consoleintr+0x128>
    switch(c){
80100903:	83 fb 15             	cmp    $0x15,%ebx
80100906:	74 7a                	je     80100982 <consoleintr+0xc2>
80100908:	7e d6                	jle    801008e0 <consoleintr+0x20>
8010090a:	83 fb 7f             	cmp    $0x7f,%ebx
8010090d:	0f 84 ad 00 00 00    	je     801009c0 <consoleintr+0x100>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100913:	a1 08 99 11 80       	mov    0x80119908,%eax
80100918:	89 c2                	mov    %eax,%edx
8010091a:	2b 15 00 99 11 80    	sub    0x80119900,%edx
80100920:	83 fa 7f             	cmp    $0x7f,%edx
80100923:	77 d2                	ja     801008f7 <consoleintr+0x37>
  if(panicked){
80100925:	8b 15 58 99 11 80    	mov    0x80119958,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
8010092b:	8d 48 01             	lea    0x1(%eax),%ecx
8010092e:	83 e0 7f             	and    $0x7f,%eax
80100931:	89 0d 08 99 11 80    	mov    %ecx,0x80119908
80100937:	88 98 80 98 11 80    	mov    %bl,-0x7fee6780(%eax)
  if(panicked){
8010093d:	85 d2                	test   %edx,%edx
8010093f:	0f 85 47 01 00 00    	jne    80100a8c <consoleintr+0x1cc>
80100945:	89 d8                	mov    %ebx,%eax
80100947:	e8 b4 fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010094c:	83 fb 0a             	cmp    $0xa,%ebx
8010094f:	0f 84 18 01 00 00    	je     80100a6d <consoleintr+0x1ad>
80100955:	83 fb 04             	cmp    $0x4,%ebx
80100958:	0f 84 0f 01 00 00    	je     80100a6d <consoleintr+0x1ad>
8010095e:	a1 00 99 11 80       	mov    0x80119900,%eax
80100963:	83 e8 80             	sub    $0xffffff80,%eax
80100966:	39 05 08 99 11 80    	cmp    %eax,0x80119908
8010096c:	75 89                	jne    801008f7 <consoleintr+0x37>
8010096e:	e9 ff 00 00 00       	jmp    80100a72 <consoleintr+0x1b2>
80100973:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100977:	90                   	nop
80100978:	b8 00 01 00 00       	mov    $0x100,%eax
8010097d:	e8 7e fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
80100982:	a1 08 99 11 80       	mov    0x80119908,%eax
80100987:	3b 05 04 99 11 80    	cmp    0x80119904,%eax
8010098d:	0f 84 64 ff ff ff    	je     801008f7 <consoleintr+0x37>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100993:	83 e8 01             	sub    $0x1,%eax
80100996:	89 c2                	mov    %eax,%edx
80100998:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
8010099b:	80 ba 80 98 11 80 0a 	cmpb   $0xa,-0x7fee6780(%edx)
801009a2:	0f 84 4f ff ff ff    	je     801008f7 <consoleintr+0x37>
  if(panicked){
801009a8:	8b 15 58 99 11 80    	mov    0x80119958,%edx
        input.e--;
801009ae:	a3 08 99 11 80       	mov    %eax,0x80119908
  if(panicked){
801009b3:	85 d2                	test   %edx,%edx
801009b5:	74 c1                	je     80100978 <consoleintr+0xb8>
801009b7:	fa                   	cli
    for(;;)
801009b8:	eb fe                	jmp    801009b8 <consoleintr+0xf8>
801009ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(input.e != input.w){
801009c0:	a1 08 99 11 80       	mov    0x80119908,%eax
801009c5:	3b 05 04 99 11 80    	cmp    0x80119904,%eax
801009cb:	0f 84 26 ff ff ff    	je     801008f7 <consoleintr+0x37>
        input.e--;
801009d1:	83 e8 01             	sub    $0x1,%eax
801009d4:	a3 08 99 11 80       	mov    %eax,0x80119908
  if(panicked){
801009d9:	a1 58 99 11 80       	mov    0x80119958,%eax
801009de:	85 c0                	test   %eax,%eax
801009e0:	74 22                	je     80100a04 <consoleintr+0x144>
801009e2:	fa                   	cli
    for(;;)
801009e3:	eb fe                	jmp    801009e3 <consoleintr+0x123>
801009e5:	8d 76 00             	lea    0x0(%esi),%esi
  release(&cons.lock);
801009e8:	83 ec 0c             	sub    $0xc,%esp
801009eb:	68 20 99 11 80       	push   $0x80119920
801009f0:	e8 8b 3f 00 00       	call   80104980 <release>
  if(doprocdump) {
801009f5:	83 c4 10             	add    $0x10,%esp
801009f8:	85 f6                	test   %esi,%esi
801009fa:	75 17                	jne    80100a13 <consoleintr+0x153>
}
801009fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009ff:	5b                   	pop    %ebx
80100a00:	5e                   	pop    %esi
80100a01:	5f                   	pop    %edi
80100a02:	5d                   	pop    %ebp
80100a03:	c3                   	ret
80100a04:	b8 00 01 00 00       	mov    $0x100,%eax
80100a09:	e8 f2 f9 ff ff       	call   80100400 <consputc.part.0>
80100a0e:	e9 e4 fe ff ff       	jmp    801008f7 <consoleintr+0x37>
80100a13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a16:	5b                   	pop    %ebx
80100a17:	5e                   	pop    %esi
80100a18:	5f                   	pop    %edi
80100a19:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a1a:	e9 c1 37 00 00       	jmp    801041e0 <procdump>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a1f:	85 db                	test   %ebx,%ebx
80100a21:	0f 84 d0 fe ff ff    	je     801008f7 <consoleintr+0x37>
80100a27:	a1 08 99 11 80       	mov    0x80119908,%eax
80100a2c:	89 c2                	mov    %eax,%edx
80100a2e:	2b 15 00 99 11 80    	sub    0x80119900,%edx
80100a34:	83 fa 7f             	cmp    $0x7f,%edx
80100a37:	0f 87 ba fe ff ff    	ja     801008f7 <consoleintr+0x37>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a3d:	8d 48 01             	lea    0x1(%eax),%ecx
  if(panicked){
80100a40:	8b 15 58 99 11 80    	mov    0x80119958,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100a46:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100a49:	83 fb 0d             	cmp    $0xd,%ebx
80100a4c:	0f 85 df fe ff ff    	jne    80100931 <consoleintr+0x71>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a52:	89 0d 08 99 11 80    	mov    %ecx,0x80119908
80100a58:	c6 80 80 98 11 80 0a 	movb   $0xa,-0x7fee6780(%eax)
  if(panicked){
80100a5f:	85 d2                	test   %edx,%edx
80100a61:	75 29                	jne    80100a8c <consoleintr+0x1cc>
80100a63:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a68:	e8 93 f9 ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100a6d:	a1 08 99 11 80       	mov    0x80119908,%eax
          wakeup(&input.r);
80100a72:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a75:	a3 04 99 11 80       	mov    %eax,0x80119904
          wakeup(&input.r);
80100a7a:	68 00 99 11 80       	push   $0x80119900
80100a7f:	e8 6c 36 00 00       	call   801040f0 <wakeup>
80100a84:	83 c4 10             	add    $0x10,%esp
80100a87:	e9 6b fe ff ff       	jmp    801008f7 <consoleintr+0x37>
80100a8c:	fa                   	cli
    for(;;)
80100a8d:	eb fe                	jmp    80100a8d <consoleintr+0x1cd>
80100a8f:	90                   	nop

80100a90 <consoleinit>:

void
consoleinit(void)
{
80100a90:	55                   	push   %ebp
80100a91:	89 e5                	mov    %esp,%ebp
80100a93:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a96:	68 c8 76 10 80       	push   $0x801076c8
80100a9b:	68 20 99 11 80       	push   $0x80119920
80100aa0:	e8 7b 3c 00 00       	call   80104720 <initlock>

  devsw[CONSOLE].write = consolewrite;
80100aa5:	c7 05 0c a3 11 80 b0 	movl   $0x801005b0,0x8011a30c
80100aac:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100aaf:	c7 05 08 a3 11 80 80 	movl   $0x80100280,0x8011a308
80100ab6:	02 10 80 
  cons.locking = 1;
80100ab9:	c7 05 54 99 11 80 01 	movl   $0x1,0x80119954
80100ac0:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100ac3:	58                   	pop    %eax
80100ac4:	5a                   	pop    %edx
80100ac5:	6a 00                	push   $0x0
80100ac7:	6a 01                	push   $0x1
80100ac9:	e8 32 1a 00 00       	call   80102500 <ioapicenable>
}
80100ace:	83 c4 10             	add    $0x10,%esp
80100ad1:	c9                   	leave
80100ad2:	c3                   	ret
80100ad3:	66 90                	xchg   %ax,%ax
80100ad5:	66 90                	xchg   %ax,%ax
80100ad7:	66 90                	xchg   %ax,%ax
80100ad9:	66 90                	xchg   %ax,%ax
80100adb:	66 90                	xchg   %ax,%ax
80100add:	66 90                	xchg   %ax,%ax
80100adf:	90                   	nop

80100ae0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ae0:	55                   	push   %ebp
80100ae1:	89 e5                	mov    %esp,%ebp
80100ae3:	57                   	push   %edi
80100ae4:	56                   	push   %esi
80100ae5:	53                   	push   %ebx
80100ae6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100aec:	e8 6f 2e 00 00       	call   80103960 <myproc>
80100af1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100af7:	e8 24 22 00 00       	call   80102d20 <begin_op>

  if((ip = namei(path)) == 0){
80100afc:	83 ec 0c             	sub    $0xc,%esp
80100aff:	ff 75 08             	push   0x8(%ebp)
80100b02:	e8 19 16 00 00       	call   80102120 <namei>
80100b07:	83 c4 10             	add    $0x10,%esp
80100b0a:	85 c0                	test   %eax,%eax
80100b0c:	0f 84 30 03 00 00    	je     80100e42 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b12:	83 ec 0c             	sub    $0xc,%esp
80100b15:	89 c7                	mov    %eax,%edi
80100b17:	50                   	push   %eax
80100b18:	e8 d3 0c 00 00       	call   801017f0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b1d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b23:	6a 34                	push   $0x34
80100b25:	6a 00                	push   $0x0
80100b27:	50                   	push   %eax
80100b28:	57                   	push   %edi
80100b29:	e8 d2 0f 00 00       	call   80101b00 <readi>
80100b2e:	83 c4 20             	add    $0x20,%esp
80100b31:	83 f8 34             	cmp    $0x34,%eax
80100b34:	0f 85 01 01 00 00    	jne    80100c3b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b3a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b41:	45 4c 46 
80100b44:	0f 85 f1 00 00 00    	jne    80100c3b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b4a:	e8 d1 67 00 00       	call   80107320 <setupkvm>
80100b4f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b55:	85 c0                	test   %eax,%eax
80100b57:	0f 84 de 00 00 00    	je     80100c3b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b5d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b64:	00 
80100b65:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b6b:	0f 84 a1 02 00 00    	je     80100e12 <exec+0x332>
  sz = 0;
80100b71:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b78:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b7b:	31 db                	xor    %ebx,%ebx
80100b7d:	e9 8c 00 00 00       	jmp    80100c0e <exec+0x12e>
80100b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100b88:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b8f:	75 6c                	jne    80100bfd <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100b91:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b97:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b9d:	0f 82 87 00 00 00    	jb     80100c2a <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ba3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ba9:	72 7f                	jb     80100c2a <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bab:	83 ec 04             	sub    $0x4,%esp
80100bae:	50                   	push   %eax
80100baf:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100bb5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bbb:	e8 90 65 00 00       	call   80107150 <allocuvm>
80100bc0:	83 c4 10             	add    $0x10,%esp
80100bc3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bc9:	85 c0                	test   %eax,%eax
80100bcb:	74 5d                	je     80100c2a <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100bcd:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bd3:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bd8:	75 50                	jne    80100c2a <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bda:	83 ec 0c             	sub    $0xc,%esp
80100bdd:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100be3:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100be9:	57                   	push   %edi
80100bea:	50                   	push   %eax
80100beb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bf1:	e8 8a 64 00 00       	call   80107080 <loaduvm>
80100bf6:	83 c4 20             	add    $0x20,%esp
80100bf9:	85 c0                	test   %eax,%eax
80100bfb:	78 2d                	js     80100c2a <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bfd:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100c04:	83 c3 01             	add    $0x1,%ebx
80100c07:	83 c6 20             	add    $0x20,%esi
80100c0a:	39 d8                	cmp    %ebx,%eax
80100c0c:	7e 52                	jle    80100c60 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c0e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c14:	6a 20                	push   $0x20
80100c16:	56                   	push   %esi
80100c17:	50                   	push   %eax
80100c18:	57                   	push   %edi
80100c19:	e8 e2 0e 00 00       	call   80101b00 <readi>
80100c1e:	83 c4 10             	add    $0x10,%esp
80100c21:	83 f8 20             	cmp    $0x20,%eax
80100c24:	0f 84 5e ff ff ff    	je     80100b88 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100c2a:	83 ec 0c             	sub    $0xc,%esp
80100c2d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c33:	e8 68 66 00 00       	call   801072a0 <freevm>
  if(ip){
80100c38:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100c3b:	83 ec 0c             	sub    $0xc,%esp
80100c3e:	57                   	push   %edi
80100c3f:	e8 3c 0e 00 00       	call   80101a80 <iunlockput>
    end_op();
80100c44:	e8 47 21 00 00       	call   80102d90 <end_op>
80100c49:	83 c4 10             	add    $0x10,%esp
    return -1;
80100c4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100c51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c54:	5b                   	pop    %ebx
80100c55:	5e                   	pop    %esi
80100c56:	5f                   	pop    %edi
80100c57:	5d                   	pop    %ebp
80100c58:	c3                   	ret
80100c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100c60:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c66:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100c6c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c72:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100c78:	83 ec 0c             	sub    $0xc,%esp
80100c7b:	57                   	push   %edi
80100c7c:	e8 ff 0d 00 00       	call   80101a80 <iunlockput>
  end_op();
80100c81:	e8 0a 21 00 00       	call   80102d90 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c86:	83 c4 0c             	add    $0xc,%esp
80100c89:	53                   	push   %ebx
80100c8a:	56                   	push   %esi
80100c8b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c91:	56                   	push   %esi
80100c92:	e8 b9 64 00 00       	call   80107150 <allocuvm>
80100c97:	83 c4 10             	add    $0x10,%esp
80100c9a:	89 c7                	mov    %eax,%edi
80100c9c:	85 c0                	test   %eax,%eax
80100c9e:	0f 84 86 00 00 00    	je     80100d2a <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ca4:	83 ec 08             	sub    $0x8,%esp
80100ca7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100cad:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100caf:	50                   	push   %eax
80100cb0:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100cb1:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cb3:	e8 08 67 00 00       	call   801073c0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100cb8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cbb:	83 c4 10             	add    $0x10,%esp
80100cbe:	8b 10                	mov    (%eax),%edx
80100cc0:	85 d2                	test   %edx,%edx
80100cc2:	0f 84 56 01 00 00    	je     80100e1e <exec+0x33e>
80100cc8:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100cce:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100cd1:	eb 23                	jmp    80100cf6 <exec+0x216>
80100cd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cd7:	90                   	nop
80100cd8:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100cdb:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100ce2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100ce8:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100ceb:	85 d2                	test   %edx,%edx
80100ced:	74 51                	je     80100d40 <exec+0x260>
    if(argc >= MAXARG)
80100cef:	83 f8 20             	cmp    $0x20,%eax
80100cf2:	74 36                	je     80100d2a <exec+0x24a>
  for(argc = 0; argv[argc]; argc++) {
80100cf4:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cf6:	83 ec 0c             	sub    $0xc,%esp
80100cf9:	52                   	push   %edx
80100cfa:	e8 c1 3e 00 00       	call   80104bc0 <strlen>
80100cff:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d01:	58                   	pop    %eax
80100d02:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d05:	83 eb 01             	sub    $0x1,%ebx
80100d08:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d0b:	e8 b0 3e 00 00       	call   80104bc0 <strlen>
80100d10:	83 c0 01             	add    $0x1,%eax
80100d13:	50                   	push   %eax
80100d14:	ff 34 b7             	push   (%edi,%esi,4)
80100d17:	53                   	push   %ebx
80100d18:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d1e:	e8 5d 68 00 00       	call   80107580 <copyout>
80100d23:	83 c4 20             	add    $0x20,%esp
80100d26:	85 c0                	test   %eax,%eax
80100d28:	79 ae                	jns    80100cd8 <exec+0x1f8>
    freevm(pgdir);
80100d2a:	83 ec 0c             	sub    $0xc,%esp
80100d2d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d33:	e8 68 65 00 00       	call   801072a0 <freevm>
80100d38:	83 c4 10             	add    $0x10,%esp
80100d3b:	e9 0c ff ff ff       	jmp    80100c4c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d40:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100d47:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d4d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100d53:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100d56:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100d59:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100d60:	00 00 00 00 
  ustack[1] = argc;
80100d64:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100d6a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d71:	ff ff ff 
  ustack[1] = argc;
80100d74:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d7a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100d7c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d7e:	29 d0                	sub    %edx,%eax
80100d80:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d86:	56                   	push   %esi
80100d87:	51                   	push   %ecx
80100d88:	53                   	push   %ebx
80100d89:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d8f:	e8 ec 67 00 00       	call   80107580 <copyout>
80100d94:	83 c4 10             	add    $0x10,%esp
80100d97:	85 c0                	test   %eax,%eax
80100d99:	78 8f                	js     80100d2a <exec+0x24a>
  for(last=s=path; *s; s++)
80100d9b:	8b 45 08             	mov    0x8(%ebp),%eax
80100d9e:	8b 55 08             	mov    0x8(%ebp),%edx
80100da1:	0f b6 00             	movzbl (%eax),%eax
80100da4:	84 c0                	test   %al,%al
80100da6:	74 17                	je     80100dbf <exec+0x2df>
80100da8:	89 d1                	mov    %edx,%ecx
80100daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100db0:	83 c1 01             	add    $0x1,%ecx
80100db3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100db5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100db8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100dbb:	84 c0                	test   %al,%al
80100dbd:	75 f1                	jne    80100db0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100dbf:	83 ec 04             	sub    $0x4,%esp
80100dc2:	6a 10                	push   $0x10
80100dc4:	52                   	push   %edx
80100dc5:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100dcb:	8d 46 6c             	lea    0x6c(%esi),%eax
80100dce:	50                   	push   %eax
80100dcf:	e8 ac 3d 00 00       	call   80104b80 <safestrcpy>
  curproc->pgdir = pgdir;
80100dd4:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100dda:	89 f0                	mov    %esi,%eax
80100ddc:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100ddf:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100de1:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100de4:	89 c1                	mov    %eax,%ecx
80100de6:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dec:	8b 40 18             	mov    0x18(%eax),%eax
80100def:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100df2:	8b 41 18             	mov    0x18(%ecx),%eax
80100df5:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100df8:	89 0c 24             	mov    %ecx,(%esp)
80100dfb:	e8 f0 60 00 00       	call   80106ef0 <switchuvm>
  freevm(oldpgdir);
80100e00:	89 34 24             	mov    %esi,(%esp)
80100e03:	e8 98 64 00 00       	call   801072a0 <freevm>
  return 0;
80100e08:	83 c4 10             	add    $0x10,%esp
80100e0b:	31 c0                	xor    %eax,%eax
80100e0d:	e9 3f fe ff ff       	jmp    80100c51 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e12:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100e17:	31 f6                	xor    %esi,%esi
80100e19:	e9 5a fe ff ff       	jmp    80100c78 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100e1e:	be 10 00 00 00       	mov    $0x10,%esi
80100e23:	ba 04 00 00 00       	mov    $0x4,%edx
80100e28:	b8 03 00 00 00       	mov    $0x3,%eax
80100e2d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100e34:	00 00 00 
80100e37:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100e3d:	e9 17 ff ff ff       	jmp    80100d59 <exec+0x279>
    end_op();
80100e42:	e8 49 1f 00 00       	call   80102d90 <end_op>
    cprintf("exec: fail\n");
80100e47:	83 ec 0c             	sub    $0xc,%esp
80100e4a:	68 e1 76 10 80       	push   $0x801076e1
80100e4f:	e8 5c f8 ff ff       	call   801006b0 <cprintf>
    return -1;
80100e54:	83 c4 10             	add    $0x10,%esp
80100e57:	e9 f0 fd ff ff       	jmp    80100c4c <exec+0x16c>
80100e5c:	66 90                	xchg   %ax,%ax
80100e5e:	66 90                	xchg   %ax,%ax

80100e60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e60:	55                   	push   %ebp
80100e61:	89 e5                	mov    %esp,%ebp
80100e63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e66:	68 ed 76 10 80       	push   $0x801076ed
80100e6b:	68 60 99 11 80       	push   $0x80119960
80100e70:	e8 ab 38 00 00       	call   80104720 <initlock>
}
80100e75:	83 c4 10             	add    $0x10,%esp
80100e78:	c9                   	leave
80100e79:	c3                   	ret
80100e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e80:	55                   	push   %ebp
80100e81:	89 e5                	mov    %esp,%ebp
80100e83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e84:	bb 94 99 11 80       	mov    $0x80119994,%ebx
{
80100e89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e8c:	68 60 99 11 80       	push   $0x80119960
80100e91:	e8 aa 39 00 00       	call   80104840 <acquire>
80100e96:	83 c4 10             	add    $0x10,%esp
80100e99:	eb 10                	jmp    80100eab <filealloc+0x2b>
80100e9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e9f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ea0:	83 c3 18             	add    $0x18,%ebx
80100ea3:	81 fb f4 a2 11 80    	cmp    $0x8011a2f4,%ebx
80100ea9:	74 25                	je     80100ed0 <filealloc+0x50>
    if(f->ref == 0){
80100eab:	8b 43 04             	mov    0x4(%ebx),%eax
80100eae:	85 c0                	test   %eax,%eax
80100eb0:	75 ee                	jne    80100ea0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100eb2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100eb5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100ebc:	68 60 99 11 80       	push   $0x80119960
80100ec1:	e8 ba 3a 00 00       	call   80104980 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100ec6:	89 d8                	mov    %ebx,%eax
      return f;
80100ec8:	83 c4 10             	add    $0x10,%esp
}
80100ecb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ece:	c9                   	leave
80100ecf:	c3                   	ret
  release(&ftable.lock);
80100ed0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100ed3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100ed5:	68 60 99 11 80       	push   $0x80119960
80100eda:	e8 a1 3a 00 00       	call   80104980 <release>
}
80100edf:	89 d8                	mov    %ebx,%eax
  return 0;
80100ee1:	83 c4 10             	add    $0x10,%esp
}
80100ee4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ee7:	c9                   	leave
80100ee8:	c3                   	ret
80100ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	53                   	push   %ebx
80100ef4:	83 ec 10             	sub    $0x10,%esp
80100ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100efa:	68 60 99 11 80       	push   $0x80119960
80100eff:	e8 3c 39 00 00       	call   80104840 <acquire>
  if(f->ref < 1)
80100f04:	8b 43 04             	mov    0x4(%ebx),%eax
80100f07:	83 c4 10             	add    $0x10,%esp
80100f0a:	85 c0                	test   %eax,%eax
80100f0c:	7e 1a                	jle    80100f28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100f0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100f11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100f14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f17:	68 60 99 11 80       	push   $0x80119960
80100f1c:	e8 5f 3a 00 00       	call   80104980 <release>
  return f;
}
80100f21:	89 d8                	mov    %ebx,%eax
80100f23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f26:	c9                   	leave
80100f27:	c3                   	ret
    panic("filedup");
80100f28:	83 ec 0c             	sub    $0xc,%esp
80100f2b:	68 f4 76 10 80       	push   $0x801076f4
80100f30:	e8 4b f4 ff ff       	call   80100380 <panic>
80100f35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	57                   	push   %edi
80100f44:	56                   	push   %esi
80100f45:	53                   	push   %ebx
80100f46:	83 ec 28             	sub    $0x28,%esp
80100f49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f4c:	68 60 99 11 80       	push   $0x80119960
80100f51:	e8 ea 38 00 00       	call   80104840 <acquire>
  if(f->ref < 1)
80100f56:	8b 53 04             	mov    0x4(%ebx),%edx
80100f59:	83 c4 10             	add    $0x10,%esp
80100f5c:	85 d2                	test   %edx,%edx
80100f5e:	0f 8e a5 00 00 00    	jle    80101009 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100f64:	83 ea 01             	sub    $0x1,%edx
80100f67:	89 53 04             	mov    %edx,0x4(%ebx)
80100f6a:	75 44                	jne    80100fb0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f6c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f70:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f73:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100f75:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f7b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f7e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f81:	8b 43 10             	mov    0x10(%ebx),%eax
80100f84:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f87:	68 60 99 11 80       	push   $0x80119960
80100f8c:	e8 ef 39 00 00       	call   80104980 <release>

  if(ff.type == FD_PIPE)
80100f91:	83 c4 10             	add    $0x10,%esp
80100f94:	83 ff 01             	cmp    $0x1,%edi
80100f97:	74 57                	je     80100ff0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f99:	83 ff 02             	cmp    $0x2,%edi
80100f9c:	74 2a                	je     80100fc8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fa1:	5b                   	pop    %ebx
80100fa2:	5e                   	pop    %esi
80100fa3:	5f                   	pop    %edi
80100fa4:	5d                   	pop    %ebp
80100fa5:	c3                   	ret
80100fa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fad:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100fb0:	c7 45 08 60 99 11 80 	movl   $0x80119960,0x8(%ebp)
}
80100fb7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fba:	5b                   	pop    %ebx
80100fbb:	5e                   	pop    %esi
80100fbc:	5f                   	pop    %edi
80100fbd:	5d                   	pop    %ebp
    release(&ftable.lock);
80100fbe:	e9 bd 39 00 00       	jmp    80104980 <release>
80100fc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100fc7:	90                   	nop
    begin_op();
80100fc8:	e8 53 1d 00 00       	call   80102d20 <begin_op>
    iput(ff.ip);
80100fcd:	83 ec 0c             	sub    $0xc,%esp
80100fd0:	ff 75 e0             	push   -0x20(%ebp)
80100fd3:	e8 48 09 00 00       	call   80101920 <iput>
    end_op();
80100fd8:	83 c4 10             	add    $0x10,%esp
}
80100fdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fde:	5b                   	pop    %ebx
80100fdf:	5e                   	pop    %esi
80100fe0:	5f                   	pop    %edi
80100fe1:	5d                   	pop    %ebp
    end_op();
80100fe2:	e9 a9 1d 00 00       	jmp    80102d90 <end_op>
80100fe7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fee:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100ff0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ff4:	83 ec 08             	sub    $0x8,%esp
80100ff7:	53                   	push   %ebx
80100ff8:	56                   	push   %esi
80100ff9:	e8 e2 24 00 00       	call   801034e0 <pipeclose>
80100ffe:	83 c4 10             	add    $0x10,%esp
}
80101001:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101004:	5b                   	pop    %ebx
80101005:	5e                   	pop    %esi
80101006:	5f                   	pop    %edi
80101007:	5d                   	pop    %ebp
80101008:	c3                   	ret
    panic("fileclose");
80101009:	83 ec 0c             	sub    $0xc,%esp
8010100c:	68 fc 76 10 80       	push   $0x801076fc
80101011:	e8 6a f3 ff ff       	call   80100380 <panic>
80101016:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010101d:	8d 76 00             	lea    0x0(%esi),%esi

80101020 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	53                   	push   %ebx
80101024:	83 ec 04             	sub    $0x4,%esp
80101027:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010102a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010102d:	75 31                	jne    80101060 <filestat+0x40>
    ilock(f->ip);
8010102f:	83 ec 0c             	sub    $0xc,%esp
80101032:	ff 73 10             	push   0x10(%ebx)
80101035:	e8 b6 07 00 00       	call   801017f0 <ilock>
    stati(f->ip, st);
8010103a:	58                   	pop    %eax
8010103b:	5a                   	pop    %edx
8010103c:	ff 75 0c             	push   0xc(%ebp)
8010103f:	ff 73 10             	push   0x10(%ebx)
80101042:	e8 89 0a 00 00       	call   80101ad0 <stati>
    iunlock(f->ip);
80101047:	59                   	pop    %ecx
80101048:	ff 73 10             	push   0x10(%ebx)
8010104b:	e8 80 08 00 00       	call   801018d0 <iunlock>
    return 0;
  }
  return -1;
}
80101050:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101053:	83 c4 10             	add    $0x10,%esp
80101056:	31 c0                	xor    %eax,%eax
}
80101058:	c9                   	leave
80101059:	c3                   	ret
8010105a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101060:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101063:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101068:	c9                   	leave
80101069:	c3                   	ret
8010106a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101070 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101070:	55                   	push   %ebp
80101071:	89 e5                	mov    %esp,%ebp
80101073:	57                   	push   %edi
80101074:	56                   	push   %esi
80101075:	53                   	push   %ebx
80101076:	83 ec 0c             	sub    $0xc,%esp
80101079:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010107c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010107f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101082:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101086:	74 60                	je     801010e8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101088:	8b 03                	mov    (%ebx),%eax
8010108a:	83 f8 01             	cmp    $0x1,%eax
8010108d:	74 41                	je     801010d0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010108f:	83 f8 02             	cmp    $0x2,%eax
80101092:	75 5b                	jne    801010ef <fileread+0x7f>
    ilock(f->ip);
80101094:	83 ec 0c             	sub    $0xc,%esp
80101097:	ff 73 10             	push   0x10(%ebx)
8010109a:	e8 51 07 00 00       	call   801017f0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010109f:	57                   	push   %edi
801010a0:	ff 73 14             	push   0x14(%ebx)
801010a3:	56                   	push   %esi
801010a4:	ff 73 10             	push   0x10(%ebx)
801010a7:	e8 54 0a 00 00       	call   80101b00 <readi>
801010ac:	83 c4 20             	add    $0x20,%esp
801010af:	89 c6                	mov    %eax,%esi
801010b1:	85 c0                	test   %eax,%eax
801010b3:	7e 03                	jle    801010b8 <fileread+0x48>
      f->off += r;
801010b5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801010b8:	83 ec 0c             	sub    $0xc,%esp
801010bb:	ff 73 10             	push   0x10(%ebx)
801010be:	e8 0d 08 00 00       	call   801018d0 <iunlock>
    return r;
801010c3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801010c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c9:	89 f0                	mov    %esi,%eax
801010cb:	5b                   	pop    %ebx
801010cc:	5e                   	pop    %esi
801010cd:	5f                   	pop    %edi
801010ce:	5d                   	pop    %ebp
801010cf:	c3                   	ret
    return piperead(f->pipe, addr, n);
801010d0:	8b 43 0c             	mov    0xc(%ebx),%eax
801010d3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d9:	5b                   	pop    %ebx
801010da:	5e                   	pop    %esi
801010db:	5f                   	pop    %edi
801010dc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801010dd:	e9 be 25 00 00       	jmp    801036a0 <piperead>
801010e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801010e8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801010ed:	eb d7                	jmp    801010c6 <fileread+0x56>
  panic("fileread");
801010ef:	83 ec 0c             	sub    $0xc,%esp
801010f2:	68 06 77 10 80       	push   $0x80107706
801010f7:	e8 84 f2 ff ff       	call   80100380 <panic>
801010fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101100 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	56                   	push   %esi
80101105:	53                   	push   %ebx
80101106:	83 ec 1c             	sub    $0x1c,%esp
80101109:	8b 45 0c             	mov    0xc(%ebp),%eax
8010110c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010110f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101112:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101115:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101119:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010111c:	0f 84 bb 00 00 00    	je     801011dd <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101122:	8b 03                	mov    (%ebx),%eax
80101124:	83 f8 01             	cmp    $0x1,%eax
80101127:	0f 84 bf 00 00 00    	je     801011ec <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010112d:	83 f8 02             	cmp    $0x2,%eax
80101130:	0f 85 c8 00 00 00    	jne    801011fe <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101136:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101139:	31 f6                	xor    %esi,%esi
    while(i < n){
8010113b:	85 c0                	test   %eax,%eax
8010113d:	7f 30                	jg     8010116f <filewrite+0x6f>
8010113f:	e9 94 00 00 00       	jmp    801011d8 <filewrite+0xd8>
80101144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101148:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010114b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010114e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101151:	ff 73 10             	push   0x10(%ebx)
80101154:	e8 77 07 00 00       	call   801018d0 <iunlock>
      end_op();
80101159:	e8 32 1c 00 00       	call   80102d90 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010115e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101161:	83 c4 10             	add    $0x10,%esp
80101164:	39 c7                	cmp    %eax,%edi
80101166:	75 5c                	jne    801011c4 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101168:	01 fe                	add    %edi,%esi
    while(i < n){
8010116a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010116d:	7e 69                	jle    801011d8 <filewrite+0xd8>
      int n1 = n - i;
8010116f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
80101172:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101177:	29 f7                	sub    %esi,%edi
      if(n1 > max)
80101179:	39 c7                	cmp    %eax,%edi
8010117b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010117e:	e8 9d 1b 00 00       	call   80102d20 <begin_op>
      ilock(f->ip);
80101183:	83 ec 0c             	sub    $0xc,%esp
80101186:	ff 73 10             	push   0x10(%ebx)
80101189:	e8 62 06 00 00       	call   801017f0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010118e:	57                   	push   %edi
8010118f:	ff 73 14             	push   0x14(%ebx)
80101192:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101195:	01 f0                	add    %esi,%eax
80101197:	50                   	push   %eax
80101198:	ff 73 10             	push   0x10(%ebx)
8010119b:	e8 60 0a 00 00       	call   80101c00 <writei>
801011a0:	83 c4 20             	add    $0x20,%esp
801011a3:	85 c0                	test   %eax,%eax
801011a5:	7f a1                	jg     80101148 <filewrite+0x48>
801011a7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801011aa:	83 ec 0c             	sub    $0xc,%esp
801011ad:	ff 73 10             	push   0x10(%ebx)
801011b0:	e8 1b 07 00 00       	call   801018d0 <iunlock>
      end_op();
801011b5:	e8 d6 1b 00 00       	call   80102d90 <end_op>
      if(r < 0)
801011ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011bd:	83 c4 10             	add    $0x10,%esp
801011c0:	85 c0                	test   %eax,%eax
801011c2:	75 14                	jne    801011d8 <filewrite+0xd8>
        panic("short filewrite");
801011c4:	83 ec 0c             	sub    $0xc,%esp
801011c7:	68 0f 77 10 80       	push   $0x8010770f
801011cc:	e8 af f1 ff ff       	call   80100380 <panic>
801011d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
801011d8:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801011db:	74 05                	je     801011e2 <filewrite+0xe2>
    return -1;
801011dd:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
801011e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011e5:	89 f0                	mov    %esi,%eax
801011e7:	5b                   	pop    %ebx
801011e8:	5e                   	pop    %esi
801011e9:	5f                   	pop    %edi
801011ea:	5d                   	pop    %ebp
801011eb:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
801011ec:	8b 43 0c             	mov    0xc(%ebx),%eax
801011ef:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011f5:	5b                   	pop    %ebx
801011f6:	5e                   	pop    %esi
801011f7:	5f                   	pop    %edi
801011f8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011f9:	e9 82 23 00 00       	jmp    80103580 <pipewrite>
  panic("filewrite");
801011fe:	83 ec 0c             	sub    $0xc,%esp
80101201:	68 15 77 10 80       	push   $0x80107715
80101206:	e8 75 f1 ff ff       	call   80100380 <panic>
8010120b:	66 90                	xchg   %ax,%ax
8010120d:	66 90                	xchg   %ax,%ax
8010120f:	90                   	nop

80101210 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101210:	55                   	push   %ebp
80101211:	89 e5                	mov    %esp,%ebp
80101213:	57                   	push   %edi
80101214:	56                   	push   %esi
80101215:	53                   	push   %ebx
80101216:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101219:	8b 0d b4 bf 11 80    	mov    0x8011bfb4,%ecx
{
8010121f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101222:	85 c9                	test   %ecx,%ecx
80101224:	0f 84 8c 00 00 00    	je     801012b6 <balloc+0xa6>
8010122a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
8010122c:	89 f8                	mov    %edi,%eax
8010122e:	83 ec 08             	sub    $0x8,%esp
80101231:	89 fe                	mov    %edi,%esi
80101233:	c1 f8 0e             	sar    $0xe,%eax
80101236:	03 05 cc bf 11 80    	add    0x8011bfcc,%eax
8010123c:	50                   	push   %eax
8010123d:	ff 75 dc             	push   -0x24(%ebp)
80101240:	e8 8b ee ff ff       	call   801000d0 <bread>
80101245:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101248:	83 c4 10             	add    $0x10,%esp
8010124b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010124e:	a1 b4 bf 11 80       	mov    0x8011bfb4,%eax
80101253:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101256:	31 c0                	xor    %eax,%eax
80101258:	eb 32                	jmp    8010128c <balloc+0x7c>
8010125a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101260:	89 c1                	mov    %eax,%ecx
80101262:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101267:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010126a:	83 e1 07             	and    $0x7,%ecx
8010126d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010126f:	89 c1                	mov    %eax,%ecx
80101271:	c1 f9 03             	sar    $0x3,%ecx
80101274:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101279:	89 fa                	mov    %edi,%edx
8010127b:	85 df                	test   %ebx,%edi
8010127d:	74 49                	je     801012c8 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010127f:	83 c0 01             	add    $0x1,%eax
80101282:	83 c6 01             	add    $0x1,%esi
80101285:	3d 00 40 00 00       	cmp    $0x4000,%eax
8010128a:	74 07                	je     80101293 <balloc+0x83>
8010128c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010128f:	39 d6                	cmp    %edx,%esi
80101291:	72 cd                	jb     80101260 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101293:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101296:	83 ec 0c             	sub    $0xc,%esp
80101299:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010129c:	81 c7 00 40 00 00    	add    $0x4000,%edi
    brelse(bp);
801012a2:	e8 49 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012a7:	83 c4 10             	add    $0x10,%esp
801012aa:	3b 3d b4 bf 11 80    	cmp    0x8011bfb4,%edi
801012b0:	0f 82 76 ff ff ff    	jb     8010122c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
801012b6:	83 ec 0c             	sub    $0xc,%esp
801012b9:	68 1f 77 10 80       	push   $0x8010771f
801012be:	e8 bd f0 ff ff       	call   80100380 <panic>
801012c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801012c7:	90                   	nop
        bp->data[bi/8] |= m;  // Mark block in use.
801012c8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801012cb:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801012ce:	09 da                	or     %ebx,%edx
801012d0:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801012d4:	57                   	push   %edi
801012d5:	e8 26 1c 00 00       	call   80102f00 <log_write>
        brelse(bp);
801012da:	89 3c 24             	mov    %edi,(%esp)
801012dd:	e8 0e ef ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801012e2:	58                   	pop    %eax
801012e3:	5a                   	pop    %edx
801012e4:	56                   	push   %esi
801012e5:	ff 75 dc             	push   -0x24(%ebp)
801012e8:	e8 e3 ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801012ed:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801012f0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012f2:	8d 40 5c             	lea    0x5c(%eax),%eax
801012f5:	68 00 08 00 00       	push   $0x800
801012fa:	6a 00                	push   $0x0
801012fc:	50                   	push   %eax
801012fd:	e8 ce 36 00 00       	call   801049d0 <memset>
  log_write(bp);
80101302:	89 1c 24             	mov    %ebx,(%esp)
80101305:	e8 f6 1b 00 00       	call   80102f00 <log_write>
  brelse(bp);
8010130a:	89 1c 24             	mov    %ebx,(%esp)
8010130d:	e8 de ee ff ff       	call   801001f0 <brelse>
}
80101312:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101315:	89 f0                	mov    %esi,%eax
80101317:	5b                   	pop    %ebx
80101318:	5e                   	pop    %esi
80101319:	5f                   	pop    %edi
8010131a:	5d                   	pop    %ebp
8010131b:	c3                   	ret
8010131c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101320 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101320:	55                   	push   %ebp
80101321:	89 e5                	mov    %esp,%ebp
80101323:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101324:	31 ff                	xor    %edi,%edi
{
80101326:	56                   	push   %esi
80101327:	89 c6                	mov    %eax,%esi
80101329:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010132a:	bb 94 a3 11 80       	mov    $0x8011a394,%ebx
{
8010132f:	83 ec 28             	sub    $0x28,%esp
80101332:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101335:	68 60 a3 11 80       	push   $0x8011a360
8010133a:	e8 01 35 00 00       	call   80104840 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010133f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101342:	83 c4 10             	add    $0x10,%esp
80101345:	eb 1b                	jmp    80101362 <iget+0x42>
80101347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010134e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101350:	39 33                	cmp    %esi,(%ebx)
80101352:	74 6c                	je     801013c0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101354:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010135a:	81 fb b4 bf 11 80    	cmp    $0x8011bfb4,%ebx
80101360:	74 26                	je     80101388 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101362:	8b 43 08             	mov    0x8(%ebx),%eax
80101365:	85 c0                	test   %eax,%eax
80101367:	7f e7                	jg     80101350 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101369:	85 ff                	test   %edi,%edi
8010136b:	75 e7                	jne    80101354 <iget+0x34>
8010136d:	85 c0                	test   %eax,%eax
8010136f:	75 76                	jne    801013e7 <iget+0xc7>
80101371:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101373:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101379:	81 fb b4 bf 11 80    	cmp    $0x8011bfb4,%ebx
8010137f:	75 e1                	jne    80101362 <iget+0x42>
80101381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101388:	85 ff                	test   %edi,%edi
8010138a:	74 79                	je     80101405 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010138c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010138f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80101391:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80101394:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
8010139b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
801013a2:	68 60 a3 11 80       	push   $0x8011a360
801013a7:	e8 d4 35 00 00       	call   80104980 <release>

  return ip;
801013ac:	83 c4 10             	add    $0x10,%esp
}
801013af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013b2:	89 f8                	mov    %edi,%eax
801013b4:	5b                   	pop    %ebx
801013b5:	5e                   	pop    %esi
801013b6:	5f                   	pop    %edi
801013b7:	5d                   	pop    %ebp
801013b8:	c3                   	ret
801013b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013c0:	39 53 04             	cmp    %edx,0x4(%ebx)
801013c3:	75 8f                	jne    80101354 <iget+0x34>
      ip->ref++;
801013c5:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
801013c8:	83 ec 0c             	sub    $0xc,%esp
      return ip;
801013cb:	89 df                	mov    %ebx,%edi
      ip->ref++;
801013cd:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
801013d0:	68 60 a3 11 80       	push   $0x8011a360
801013d5:	e8 a6 35 00 00       	call   80104980 <release>
      return ip;
801013da:	83 c4 10             	add    $0x10,%esp
}
801013dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e0:	89 f8                	mov    %edi,%eax
801013e2:	5b                   	pop    %ebx
801013e3:	5e                   	pop    %esi
801013e4:	5f                   	pop    %edi
801013e5:	5d                   	pop    %ebp
801013e6:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013e7:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013ed:	81 fb b4 bf 11 80    	cmp    $0x8011bfb4,%ebx
801013f3:	74 10                	je     80101405 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013f5:	8b 43 08             	mov    0x8(%ebx),%eax
801013f8:	85 c0                	test   %eax,%eax
801013fa:	0f 8f 50 ff ff ff    	jg     80101350 <iget+0x30>
80101400:	e9 68 ff ff ff       	jmp    8010136d <iget+0x4d>
    panic("iget: no inodes");
80101405:	83 ec 0c             	sub    $0xc,%esp
80101408:	68 35 77 10 80       	push   $0x80107735
8010140d:	e8 6e ef ff ff       	call   80100380 <panic>
80101412:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101420 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	57                   	push   %edi
80101424:	56                   	push   %esi
80101425:	89 c6                	mov    %eax,%esi
80101427:	53                   	push   %ebx
80101428:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010142b:	83 fa 0b             	cmp    $0xb,%edx
8010142e:	0f 86 8c 00 00 00    	jbe    801014c0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101434:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101437:	81 fb ff 01 00 00    	cmp    $0x1ff,%ebx
8010143d:	0f 87 9f 00 00 00    	ja     801014e2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101443:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101449:	85 c0                	test   %eax,%eax
8010144b:	74 5b                	je     801014a8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010144d:	83 ec 08             	sub    $0x8,%esp
80101450:	50                   	push   %eax
80101451:	ff 36                	push   (%esi)
80101453:	e8 78 ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101458:	83 c4 10             	add    $0x10,%esp
8010145b:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010145f:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
80101461:	8b 3b                	mov    (%ebx),%edi
80101463:	85 ff                	test   %edi,%edi
80101465:	74 19                	je     80101480 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101467:	83 ec 0c             	sub    $0xc,%esp
8010146a:	52                   	push   %edx
8010146b:	e8 80 ed ff ff       	call   801001f0 <brelse>
80101470:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101473:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101476:	89 f8                	mov    %edi,%eax
80101478:	5b                   	pop    %ebx
80101479:	5e                   	pop    %esi
8010147a:	5f                   	pop    %edi
8010147b:	5d                   	pop    %ebp
8010147c:	c3                   	ret
8010147d:	8d 76 00             	lea    0x0(%esi),%esi
80101480:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101483:	8b 06                	mov    (%esi),%eax
80101485:	e8 86 fd ff ff       	call   80101210 <balloc>
      log_write(bp);
8010148a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010148d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101490:	89 03                	mov    %eax,(%ebx)
80101492:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101494:	52                   	push   %edx
80101495:	e8 66 1a 00 00       	call   80102f00 <log_write>
8010149a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010149d:	83 c4 10             	add    $0x10,%esp
801014a0:	eb c5                	jmp    80101467 <bmap+0x47>
801014a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014a8:	8b 06                	mov    (%esi),%eax
801014aa:	e8 61 fd ff ff       	call   80101210 <balloc>
801014af:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801014b5:	eb 96                	jmp    8010144d <bmap+0x2d>
801014b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014be:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
801014c0:	8d 5a 14             	lea    0x14(%edx),%ebx
801014c3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801014c7:	85 ff                	test   %edi,%edi
801014c9:	75 a8                	jne    80101473 <bmap+0x53>
      ip->addrs[bn] = addr = balloc(ip->dev);
801014cb:	8b 00                	mov    (%eax),%eax
801014cd:	e8 3e fd ff ff       	call   80101210 <balloc>
801014d2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
801014d6:	89 c7                	mov    %eax,%edi
}
801014d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014db:	5b                   	pop    %ebx
801014dc:	89 f8                	mov    %edi,%eax
801014de:	5e                   	pop    %esi
801014df:	5f                   	pop    %edi
801014e0:	5d                   	pop    %ebp
801014e1:	c3                   	ret
  panic("bmap: out of range");
801014e2:	83 ec 0c             	sub    $0xc,%esp
801014e5:	68 45 77 10 80       	push   $0x80107745
801014ea:	e8 91 ee ff ff       	call   80100380 <panic>
801014ef:	90                   	nop

801014f0 <bfree>:
{
801014f0:	55                   	push   %ebp
801014f1:	89 e5                	mov    %esp,%ebp
801014f3:	57                   	push   %edi
801014f4:	56                   	push   %esi
801014f5:	89 c6                	mov    %eax,%esi
801014f7:	53                   	push   %ebx
801014f8:	89 d3                	mov    %edx,%ebx
801014fa:	83 ec 14             	sub    $0x14,%esp
  bp = bread(dev, 1);
801014fd:	6a 01                	push   $0x1
801014ff:	50                   	push   %eax
80101500:	e8 cb eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101505:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101508:	89 c7                	mov    %eax,%edi
  memmove(sb, bp->data, sizeof(*sb));
8010150a:	83 c0 5c             	add    $0x5c,%eax
8010150d:	6a 1c                	push   $0x1c
8010150f:	50                   	push   %eax
80101510:	68 b4 bf 11 80       	push   $0x8011bfb4
80101515:	e8 46 35 00 00       	call   80104a60 <memmove>
  brelse(bp);
8010151a:	89 3c 24             	mov    %edi,(%esp)
8010151d:	e8 ce ec ff ff       	call   801001f0 <brelse>
  bp = bread(dev, BBLOCK(b, sb));
80101522:	58                   	pop    %eax
80101523:	89 d8                	mov    %ebx,%eax
80101525:	5a                   	pop    %edx
80101526:	c1 e8 0e             	shr    $0xe,%eax
80101529:	03 05 cc bf 11 80    	add    0x8011bfcc,%eax
8010152f:	50                   	push   %eax
80101530:	56                   	push   %esi
80101531:	e8 9a eb ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101536:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101538:	c1 fb 03             	sar    $0x3,%ebx
8010153b:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
8010153e:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101540:	83 e1 07             	and    $0x7,%ecx
80101543:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101548:	81 e3 ff 07 00 00    	and    $0x7ff,%ebx
  m = 1 << (bi % 8);
8010154e:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101550:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101555:	85 c1                	test   %eax,%ecx
80101557:	74 24                	je     8010157d <bfree+0x8d>
  bp->data[bi/8] &= ~m;
80101559:	f7 d0                	not    %eax
  log_write(bp);
8010155b:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
8010155e:	21 c8                	and    %ecx,%eax
80101560:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
80101564:	56                   	push   %esi
80101565:	e8 96 19 00 00       	call   80102f00 <log_write>
  brelse(bp);
8010156a:	89 34 24             	mov    %esi,(%esp)
8010156d:	e8 7e ec ff ff       	call   801001f0 <brelse>
}
80101572:	83 c4 10             	add    $0x10,%esp
80101575:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101578:	5b                   	pop    %ebx
80101579:	5e                   	pop    %esi
8010157a:	5f                   	pop    %edi
8010157b:	5d                   	pop    %ebp
8010157c:	c3                   	ret
    panic("freeing free block");
8010157d:	83 ec 0c             	sub    $0xc,%esp
80101580:	68 58 77 10 80       	push   $0x80107758
80101585:	e8 f6 ed ff ff       	call   80100380 <panic>
8010158a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101590 <readsb>:
{
80101590:	55                   	push   %ebp
80101591:	89 e5                	mov    %esp,%ebp
80101593:	56                   	push   %esi
80101594:	53                   	push   %ebx
80101595:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101598:	83 ec 08             	sub    $0x8,%esp
8010159b:	6a 01                	push   $0x1
8010159d:	ff 75 08             	push   0x8(%ebp)
801015a0:	e8 2b eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015a5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015a8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015aa:	8d 40 5c             	lea    0x5c(%eax),%eax
801015ad:	6a 1c                	push   $0x1c
801015af:	50                   	push   %eax
801015b0:	56                   	push   %esi
801015b1:	e8 aa 34 00 00       	call   80104a60 <memmove>
  brelse(bp);
801015b6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801015b9:	83 c4 10             	add    $0x10,%esp
}
801015bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015bf:	5b                   	pop    %ebx
801015c0:	5e                   	pop    %esi
801015c1:	5d                   	pop    %ebp
  brelse(bp);
801015c2:	e9 29 ec ff ff       	jmp    801001f0 <brelse>
801015c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015ce:	66 90                	xchg   %ax,%ax

801015d0 <iinit>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	53                   	push   %ebx
801015d4:	bb a0 a3 11 80       	mov    $0x8011a3a0,%ebx
801015d9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801015dc:	68 6b 77 10 80       	push   $0x8010776b
801015e1:	68 60 a3 11 80       	push   $0x8011a360
801015e6:	e8 35 31 00 00       	call   80104720 <initlock>
  for(i = 0; i < NINODE; i++) {
801015eb:	83 c4 10             	add    $0x10,%esp
801015ee:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801015f0:	83 ec 08             	sub    $0x8,%esp
801015f3:	68 72 77 10 80       	push   $0x80107772
801015f8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801015f9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801015ff:	e8 0c 30 00 00       	call   80104610 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101604:	83 c4 10             	add    $0x10,%esp
80101607:	81 fb c0 bf 11 80    	cmp    $0x8011bfc0,%ebx
8010160d:	75 e1                	jne    801015f0 <iinit+0x20>
  bp = bread(dev, 1);
8010160f:	83 ec 08             	sub    $0x8,%esp
80101612:	6a 01                	push   $0x1
80101614:	ff 75 08             	push   0x8(%ebp)
80101617:	e8 b4 ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010161c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010161f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101621:	8d 40 5c             	lea    0x5c(%eax),%eax
80101624:	6a 1c                	push   $0x1c
80101626:	50                   	push   %eax
80101627:	68 b4 bf 11 80       	push   $0x8011bfb4
8010162c:	e8 2f 34 00 00       	call   80104a60 <memmove>
  brelse(bp);
80101631:	89 1c 24             	mov    %ebx,(%esp)
80101634:	e8 b7 eb ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101639:	ff 35 cc bf 11 80    	push   0x8011bfcc
8010163f:	ff 35 c8 bf 11 80    	push   0x8011bfc8
80101645:	ff 35 c4 bf 11 80    	push   0x8011bfc4
8010164b:	ff 35 c0 bf 11 80    	push   0x8011bfc0
80101651:	ff 35 bc bf 11 80    	push   0x8011bfbc
80101657:	ff 35 b8 bf 11 80    	push   0x8011bfb8
8010165d:	ff 35 b4 bf 11 80    	push   0x8011bfb4
80101663:	68 d8 77 10 80       	push   $0x801077d8
80101668:	e8 43 f0 ff ff       	call   801006b0 <cprintf>
}
8010166d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101670:	83 c4 30             	add    $0x30,%esp
80101673:	c9                   	leave
80101674:	c3                   	ret
80101675:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <ialloc>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	57                   	push   %edi
80101684:	56                   	push   %esi
80101685:	53                   	push   %ebx
80101686:	83 ec 1c             	sub    $0x1c,%esp
80101689:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010168c:	83 3d bc bf 11 80 01 	cmpl   $0x1,0x8011bfbc
{
80101693:	8b 75 08             	mov    0x8(%ebp),%esi
80101696:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101699:	0f 86 91 00 00 00    	jbe    80101730 <ialloc+0xb0>
8010169f:	bf 01 00 00 00       	mov    $0x1,%edi
801016a4:	eb 21                	jmp    801016c7 <ialloc+0x47>
801016a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016ad:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
801016b0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801016b3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801016b6:	53                   	push   %ebx
801016b7:	e8 34 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801016bc:	83 c4 10             	add    $0x10,%esp
801016bf:	3b 3d bc bf 11 80    	cmp    0x8011bfbc,%edi
801016c5:	73 69                	jae    80101730 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801016c7:	89 f8                	mov    %edi,%eax
801016c9:	83 ec 08             	sub    $0x8,%esp
801016cc:	c1 e8 05             	shr    $0x5,%eax
801016cf:	03 05 c8 bf 11 80    	add    0x8011bfc8,%eax
801016d5:	50                   	push   %eax
801016d6:	56                   	push   %esi
801016d7:	e8 f4 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801016dc:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801016df:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801016e1:	89 f8                	mov    %edi,%eax
801016e3:	83 e0 1f             	and    $0x1f,%eax
801016e6:	c1 e0 06             	shl    $0x6,%eax
801016e9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016ed:	66 83 39 00          	cmpw   $0x0,(%ecx)
801016f1:	75 bd                	jne    801016b0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801016f3:	83 ec 04             	sub    $0x4,%esp
801016f6:	6a 40                	push   $0x40
801016f8:	6a 00                	push   $0x0
801016fa:	51                   	push   %ecx
801016fb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801016fe:	e8 cd 32 00 00       	call   801049d0 <memset>
      dip->type = type;
80101703:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101707:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010170a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010170d:	89 1c 24             	mov    %ebx,(%esp)
80101710:	e8 eb 17 00 00       	call   80102f00 <log_write>
      brelse(bp);
80101715:	89 1c 24             	mov    %ebx,(%esp)
80101718:	e8 d3 ea ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010171d:	83 c4 10             	add    $0x10,%esp
}
80101720:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101723:	89 fa                	mov    %edi,%edx
}
80101725:	5b                   	pop    %ebx
      return iget(dev, inum);
80101726:	89 f0                	mov    %esi,%eax
}
80101728:	5e                   	pop    %esi
80101729:	5f                   	pop    %edi
8010172a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010172b:	e9 f0 fb ff ff       	jmp    80101320 <iget>
  panic("ialloc: no inodes");
80101730:	83 ec 0c             	sub    $0xc,%esp
80101733:	68 78 77 10 80       	push   $0x80107778
80101738:	e8 43 ec ff ff       	call   80100380 <panic>
8010173d:	8d 76 00             	lea    0x0(%esi),%esi

80101740 <iupdate>:
{
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	56                   	push   %esi
80101744:	53                   	push   %ebx
80101745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101748:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010174b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010174e:	83 ec 08             	sub    $0x8,%esp
80101751:	c1 e8 05             	shr    $0x5,%eax
80101754:	03 05 c8 bf 11 80    	add    0x8011bfc8,%eax
8010175a:	50                   	push   %eax
8010175b:	ff 73 a4             	push   -0x5c(%ebx)
8010175e:	e8 6d e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101763:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101767:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010176a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010176c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010176f:	83 e0 1f             	and    $0x1f,%eax
80101772:	c1 e0 06             	shl    $0x6,%eax
80101775:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101779:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010177c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101780:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101783:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101787:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010178b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010178f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101793:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101797:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010179a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010179d:	6a 34                	push   $0x34
8010179f:	53                   	push   %ebx
801017a0:	50                   	push   %eax
801017a1:	e8 ba 32 00 00       	call   80104a60 <memmove>
  log_write(bp);
801017a6:	89 34 24             	mov    %esi,(%esp)
801017a9:	e8 52 17 00 00       	call   80102f00 <log_write>
  brelse(bp);
801017ae:	89 75 08             	mov    %esi,0x8(%ebp)
801017b1:	83 c4 10             	add    $0x10,%esp
}
801017b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017b7:	5b                   	pop    %ebx
801017b8:	5e                   	pop    %esi
801017b9:	5d                   	pop    %ebp
  brelse(bp);
801017ba:	e9 31 ea ff ff       	jmp    801001f0 <brelse>
801017bf:	90                   	nop

801017c0 <idup>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	53                   	push   %ebx
801017c4:	83 ec 10             	sub    $0x10,%esp
801017c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801017ca:	68 60 a3 11 80       	push   $0x8011a360
801017cf:	e8 6c 30 00 00       	call   80104840 <acquire>
  ip->ref++;
801017d4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017d8:	c7 04 24 60 a3 11 80 	movl   $0x8011a360,(%esp)
801017df:	e8 9c 31 00 00       	call   80104980 <release>
}
801017e4:	89 d8                	mov    %ebx,%eax
801017e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017e9:	c9                   	leave
801017ea:	c3                   	ret
801017eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801017ef:	90                   	nop

801017f0 <ilock>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	56                   	push   %esi
801017f4:	53                   	push   %ebx
801017f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801017f8:	85 db                	test   %ebx,%ebx
801017fa:	0f 84 b7 00 00 00    	je     801018b7 <ilock+0xc7>
80101800:	8b 53 08             	mov    0x8(%ebx),%edx
80101803:	85 d2                	test   %edx,%edx
80101805:	0f 8e ac 00 00 00    	jle    801018b7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010180b:	83 ec 0c             	sub    $0xc,%esp
8010180e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101811:	50                   	push   %eax
80101812:	e8 39 2e 00 00       	call   80104650 <acquiresleep>
  if(ip->valid == 0){
80101817:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010181a:	83 c4 10             	add    $0x10,%esp
8010181d:	85 c0                	test   %eax,%eax
8010181f:	74 0f                	je     80101830 <ilock+0x40>
}
80101821:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101824:	5b                   	pop    %ebx
80101825:	5e                   	pop    %esi
80101826:	5d                   	pop    %ebp
80101827:	c3                   	ret
80101828:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010182f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101830:	8b 43 04             	mov    0x4(%ebx),%eax
80101833:	83 ec 08             	sub    $0x8,%esp
80101836:	c1 e8 05             	shr    $0x5,%eax
80101839:	03 05 c8 bf 11 80    	add    0x8011bfc8,%eax
8010183f:	50                   	push   %eax
80101840:	ff 33                	push   (%ebx)
80101842:	e8 89 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101847:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010184a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010184c:	8b 43 04             	mov    0x4(%ebx),%eax
8010184f:	83 e0 1f             	and    $0x1f,%eax
80101852:	c1 e0 06             	shl    $0x6,%eax
80101855:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101859:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010185c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010185f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101863:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101867:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010186b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010186f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101873:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101877:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010187b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010187e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101881:	6a 34                	push   $0x34
80101883:	50                   	push   %eax
80101884:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101887:	50                   	push   %eax
80101888:	e8 d3 31 00 00       	call   80104a60 <memmove>
    brelse(bp);
8010188d:	89 34 24             	mov    %esi,(%esp)
80101890:	e8 5b e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101895:	83 c4 10             	add    $0x10,%esp
80101898:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010189d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801018a4:	0f 85 77 ff ff ff    	jne    80101821 <ilock+0x31>
      panic("ilock: no type");
801018aa:	83 ec 0c             	sub    $0xc,%esp
801018ad:	68 90 77 10 80       	push   $0x80107790
801018b2:	e8 c9 ea ff ff       	call   80100380 <panic>
    panic("ilock");
801018b7:	83 ec 0c             	sub    $0xc,%esp
801018ba:	68 8a 77 10 80       	push   $0x8010778a
801018bf:	e8 bc ea ff ff       	call   80100380 <panic>
801018c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018cf:	90                   	nop

801018d0 <iunlock>:
{
801018d0:	55                   	push   %ebp
801018d1:	89 e5                	mov    %esp,%ebp
801018d3:	56                   	push   %esi
801018d4:	53                   	push   %ebx
801018d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801018d8:	85 db                	test   %ebx,%ebx
801018da:	74 28                	je     80101904 <iunlock+0x34>
801018dc:	83 ec 0c             	sub    $0xc,%esp
801018df:	8d 73 0c             	lea    0xc(%ebx),%esi
801018e2:	56                   	push   %esi
801018e3:	e8 08 2e 00 00       	call   801046f0 <holdingsleep>
801018e8:	83 c4 10             	add    $0x10,%esp
801018eb:	85 c0                	test   %eax,%eax
801018ed:	74 15                	je     80101904 <iunlock+0x34>
801018ef:	8b 43 08             	mov    0x8(%ebx),%eax
801018f2:	85 c0                	test   %eax,%eax
801018f4:	7e 0e                	jle    80101904 <iunlock+0x34>
  releasesleep(&ip->lock);
801018f6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801018f9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018fc:	5b                   	pop    %ebx
801018fd:	5e                   	pop    %esi
801018fe:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801018ff:	e9 ac 2d 00 00       	jmp    801046b0 <releasesleep>
    panic("iunlock");
80101904:	83 ec 0c             	sub    $0xc,%esp
80101907:	68 9f 77 10 80       	push   $0x8010779f
8010190c:	e8 6f ea ff ff       	call   80100380 <panic>
80101911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101918:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010191f:	90                   	nop

80101920 <iput>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	57                   	push   %edi
80101924:	56                   	push   %esi
80101925:	53                   	push   %ebx
80101926:	83 ec 28             	sub    $0x28,%esp
80101929:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010192c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010192f:	57                   	push   %edi
80101930:	e8 1b 2d 00 00       	call   80104650 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101935:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101938:	83 c4 10             	add    $0x10,%esp
8010193b:	85 d2                	test   %edx,%edx
8010193d:	74 07                	je     80101946 <iput+0x26>
8010193f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101944:	74 32                	je     80101978 <iput+0x58>
  releasesleep(&ip->lock);
80101946:	83 ec 0c             	sub    $0xc,%esp
80101949:	57                   	push   %edi
8010194a:	e8 61 2d 00 00       	call   801046b0 <releasesleep>
  acquire(&icache.lock);
8010194f:	c7 04 24 60 a3 11 80 	movl   $0x8011a360,(%esp)
80101956:	e8 e5 2e 00 00       	call   80104840 <acquire>
  ip->ref--;
8010195b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010195f:	83 c4 10             	add    $0x10,%esp
80101962:	c7 45 08 60 a3 11 80 	movl   $0x8011a360,0x8(%ebp)
}
80101969:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010196c:	5b                   	pop    %ebx
8010196d:	5e                   	pop    %esi
8010196e:	5f                   	pop    %edi
8010196f:	5d                   	pop    %ebp
  release(&icache.lock);
80101970:	e9 0b 30 00 00       	jmp    80104980 <release>
80101975:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101978:	83 ec 0c             	sub    $0xc,%esp
8010197b:	68 60 a3 11 80       	push   $0x8011a360
80101980:	e8 bb 2e 00 00       	call   80104840 <acquire>
    int r = ip->ref;
80101985:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101988:	c7 04 24 60 a3 11 80 	movl   $0x8011a360,(%esp)
8010198f:	e8 ec 2f 00 00       	call   80104980 <release>
    if(r == 1){
80101994:	83 c4 10             	add    $0x10,%esp
80101997:	83 fe 01             	cmp    $0x1,%esi
8010199a:	75 aa                	jne    80101946 <iput+0x26>
8010199c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801019a2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801019a5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801019a8:	89 df                	mov    %ebx,%edi
801019aa:	89 cb                	mov    %ecx,%ebx
801019ac:	eb 09                	jmp    801019b7 <iput+0x97>
801019ae:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801019b0:	83 c6 04             	add    $0x4,%esi
801019b3:	39 de                	cmp    %ebx,%esi
801019b5:	74 19                	je     801019d0 <iput+0xb0>
    if(ip->addrs[i]){
801019b7:	8b 16                	mov    (%esi),%edx
801019b9:	85 d2                	test   %edx,%edx
801019bb:	74 f3                	je     801019b0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801019bd:	8b 07                	mov    (%edi),%eax
801019bf:	e8 2c fb ff ff       	call   801014f0 <bfree>
      ip->addrs[i] = 0;
801019c4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801019ca:	eb e4                	jmp    801019b0 <iput+0x90>
801019cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801019d0:	89 fb                	mov    %edi,%ebx
801019d2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019d5:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801019db:	85 c0                	test   %eax,%eax
801019dd:	75 2d                	jne    80101a0c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801019df:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801019e2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801019e9:	53                   	push   %ebx
801019ea:	e8 51 fd ff ff       	call   80101740 <iupdate>
      ip->type = 0;
801019ef:	31 c0                	xor    %eax,%eax
801019f1:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801019f5:	89 1c 24             	mov    %ebx,(%esp)
801019f8:	e8 43 fd ff ff       	call   80101740 <iupdate>
      ip->valid = 0;
801019fd:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101a04:	83 c4 10             	add    $0x10,%esp
80101a07:	e9 3a ff ff ff       	jmp    80101946 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a0c:	83 ec 08             	sub    $0x8,%esp
80101a0f:	50                   	push   %eax
80101a10:	ff 33                	push   (%ebx)
80101a12:	e8 b9 e6 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101a17:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a1a:	83 c4 10             	add    $0x10,%esp
80101a1d:	8d 88 5c 08 00 00    	lea    0x85c(%eax),%ecx
80101a23:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a26:	8d 70 5c             	lea    0x5c(%eax),%esi
80101a29:	89 cf                	mov    %ecx,%edi
80101a2b:	eb 0a                	jmp    80101a37 <iput+0x117>
80101a2d:	8d 76 00             	lea    0x0(%esi),%esi
80101a30:	83 c6 04             	add    $0x4,%esi
80101a33:	39 fe                	cmp    %edi,%esi
80101a35:	74 0f                	je     80101a46 <iput+0x126>
      if(a[j])
80101a37:	8b 16                	mov    (%esi),%edx
80101a39:	85 d2                	test   %edx,%edx
80101a3b:	74 f3                	je     80101a30 <iput+0x110>
        bfree(ip->dev, a[j]);
80101a3d:	8b 03                	mov    (%ebx),%eax
80101a3f:	e8 ac fa ff ff       	call   801014f0 <bfree>
80101a44:	eb ea                	jmp    80101a30 <iput+0x110>
    brelse(bp);
80101a46:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a49:	83 ec 0c             	sub    $0xc,%esp
80101a4c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a4f:	50                   	push   %eax
80101a50:	e8 9b e7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a55:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a5b:	8b 03                	mov    (%ebx),%eax
80101a5d:	e8 8e fa ff ff       	call   801014f0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a62:	83 c4 10             	add    $0x10,%esp
80101a65:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a6c:	00 00 00 
80101a6f:	e9 6b ff ff ff       	jmp    801019df <iput+0xbf>
80101a74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a7f:	90                   	nop

80101a80 <iunlockput>:
{
80101a80:	55                   	push   %ebp
80101a81:	89 e5                	mov    %esp,%ebp
80101a83:	56                   	push   %esi
80101a84:	53                   	push   %ebx
80101a85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a88:	85 db                	test   %ebx,%ebx
80101a8a:	74 34                	je     80101ac0 <iunlockput+0x40>
80101a8c:	83 ec 0c             	sub    $0xc,%esp
80101a8f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a92:	56                   	push   %esi
80101a93:	e8 58 2c 00 00       	call   801046f0 <holdingsleep>
80101a98:	83 c4 10             	add    $0x10,%esp
80101a9b:	85 c0                	test   %eax,%eax
80101a9d:	74 21                	je     80101ac0 <iunlockput+0x40>
80101a9f:	8b 43 08             	mov    0x8(%ebx),%eax
80101aa2:	85 c0                	test   %eax,%eax
80101aa4:	7e 1a                	jle    80101ac0 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101aa6:	83 ec 0c             	sub    $0xc,%esp
80101aa9:	56                   	push   %esi
80101aaa:	e8 01 2c 00 00       	call   801046b0 <releasesleep>
  iput(ip);
80101aaf:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101ab2:	83 c4 10             	add    $0x10,%esp
}
80101ab5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101ab8:	5b                   	pop    %ebx
80101ab9:	5e                   	pop    %esi
80101aba:	5d                   	pop    %ebp
  iput(ip);
80101abb:	e9 60 fe ff ff       	jmp    80101920 <iput>
    panic("iunlock");
80101ac0:	83 ec 0c             	sub    $0xc,%esp
80101ac3:	68 9f 77 10 80       	push   $0x8010779f
80101ac8:	e8 b3 e8 ff ff       	call   80100380 <panic>
80101acd:	8d 76 00             	lea    0x0(%esi),%esi

80101ad0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ad6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ad9:	8b 0a                	mov    (%edx),%ecx
80101adb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101ade:	8b 4a 04             	mov    0x4(%edx),%ecx
80101ae1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101ae4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101ae8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101aeb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101aef:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101af3:	8b 52 58             	mov    0x58(%edx),%edx
80101af6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101af9:	5d                   	pop    %ebp
80101afa:	c3                   	ret
80101afb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101aff:	90                   	nop

80101b00 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b00:	55                   	push   %ebp
80101b01:	89 e5                	mov    %esp,%ebp
80101b03:	57                   	push   %edi
80101b04:	56                   	push   %esi
80101b05:	53                   	push   %ebx
80101b06:	83 ec 1c             	sub    $0x1c,%esp
80101b09:	8b 75 08             	mov    0x8(%ebp),%esi
80101b0c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b0f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b12:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101b17:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101b1a:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101b1d:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101b20:	0f 84 aa 00 00 00    	je     80101bd0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b26:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101b29:	8b 56 58             	mov    0x58(%esi),%edx
80101b2c:	39 fa                	cmp    %edi,%edx
80101b2e:	0f 82 bd 00 00 00    	jb     80101bf1 <readi+0xf1>
80101b34:	89 f9                	mov    %edi,%ecx
80101b36:	31 db                	xor    %ebx,%ebx
80101b38:	01 c1                	add    %eax,%ecx
80101b3a:	0f 92 c3             	setb   %bl
80101b3d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101b40:	0f 82 ab 00 00 00    	jb     80101bf1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b46:	89 d3                	mov    %edx,%ebx
80101b48:	29 fb                	sub    %edi,%ebx
80101b4a:	39 ca                	cmp    %ecx,%edx
80101b4c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b4f:	85 c0                	test   %eax,%eax
80101b51:	74 73                	je     80101bc6 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101b53:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101b56:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b60:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b63:	89 fa                	mov    %edi,%edx
80101b65:	c1 ea 0b             	shr    $0xb,%edx
80101b68:	89 d8                	mov    %ebx,%eax
80101b6a:	e8 b1 f8 ff ff       	call   80101420 <bmap>
80101b6f:	83 ec 08             	sub    $0x8,%esp
80101b72:	50                   	push   %eax
80101b73:	ff 33                	push   (%ebx)
80101b75:	e8 56 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b7a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b7d:	b9 00 08 00 00       	mov    $0x800,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b82:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b84:	89 f8                	mov    %edi,%eax
80101b86:	25 ff 07 00 00       	and    $0x7ff,%eax
80101b8b:	29 f3                	sub    %esi,%ebx
80101b8d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b8f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b93:	39 d9                	cmp    %ebx,%ecx
80101b95:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b98:	83 c4 0c             	add    $0xc,%esp
80101b9b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b9c:	01 de                	add    %ebx,%esi
80101b9e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101ba0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ba3:	50                   	push   %eax
80101ba4:	ff 75 e0             	push   -0x20(%ebp)
80101ba7:	e8 b4 2e 00 00       	call   80104a60 <memmove>
    brelse(bp);
80101bac:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101baf:	89 14 24             	mov    %edx,(%esp)
80101bb2:	e8 39 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bb7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101bba:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101bbd:	83 c4 10             	add    $0x10,%esp
80101bc0:	39 de                	cmp    %ebx,%esi
80101bc2:	72 9c                	jb     80101b60 <readi+0x60>
80101bc4:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101bc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bc9:	5b                   	pop    %ebx
80101bca:	5e                   	pop    %esi
80101bcb:	5f                   	pop    %edi
80101bcc:	5d                   	pop    %ebp
80101bcd:	c3                   	ret
80101bce:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101bd0:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101bd4:	66 83 fa 09          	cmp    $0x9,%dx
80101bd8:	77 17                	ja     80101bf1 <readi+0xf1>
80101bda:	8b 14 d5 00 a3 11 80 	mov    -0x7fee5d00(,%edx,8),%edx
80101be1:	85 d2                	test   %edx,%edx
80101be3:	74 0c                	je     80101bf1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101be5:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101be8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101beb:	5b                   	pop    %ebx
80101bec:	5e                   	pop    %esi
80101bed:	5f                   	pop    %edi
80101bee:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101bef:	ff e2                	jmp    *%edx
      return -1;
80101bf1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bf6:	eb ce                	jmp    80101bc6 <readi+0xc6>
80101bf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bff:	90                   	nop

80101c00 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c00:	55                   	push   %ebp
80101c01:	89 e5                	mov    %esp,%ebp
80101c03:	57                   	push   %edi
80101c04:	56                   	push   %esi
80101c05:	53                   	push   %ebx
80101c06:	83 ec 1c             	sub    $0x1c,%esp
80101c09:	8b 45 08             	mov    0x8(%ebp),%eax
80101c0c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101c0f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c12:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101c17:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101c1a:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101c1d:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101c20:	0f 84 ca 00 00 00    	je     80101cf0 <writei+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c26:	39 78 58             	cmp    %edi,0x58(%eax)
80101c29:	0f 82 fa 00 00 00    	jb     80101d29 <writei+0x129>
80101c2f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101c32:	31 c9                	xor    %ecx,%ecx
80101c34:	89 f2                	mov    %esi,%edx
80101c36:	01 fa                	add    %edi,%edx
80101c38:	0f 92 c1             	setb   %cl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c3b:	81 fa 00 60 10 00    	cmp    $0x106000,%edx
80101c41:	0f 87 e2 00 00 00    	ja     80101d29 <writei+0x129>
80101c47:	85 c9                	test   %ecx,%ecx
80101c49:	0f 85 da 00 00 00    	jne    80101d29 <writei+0x129>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c4f:	85 f6                	test   %esi,%esi
80101c51:	0f 84 86 00 00 00    	je     80101cdd <writei+0xdd>
80101c57:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101c5e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c68:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101c6b:	89 fa                	mov    %edi,%edx
80101c6d:	c1 ea 0b             	shr    $0xb,%edx
80101c70:	89 f0                	mov    %esi,%eax
80101c72:	e8 a9 f7 ff ff       	call   80101420 <bmap>
80101c77:	83 ec 08             	sub    $0x8,%esp
80101c7a:	50                   	push   %eax
80101c7b:	ff 36                	push   (%esi)
80101c7d:	e8 4e e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c82:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c85:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c88:	b9 00 08 00 00       	mov    $0x800,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c8d:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c8f:	89 f8                	mov    %edi,%eax
80101c91:	25 ff 07 00 00       	and    $0x7ff,%eax
80101c96:	29 d3                	sub    %edx,%ebx
80101c98:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c9a:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c9e:	39 d9                	cmp    %ebx,%ecx
80101ca0:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ca3:	83 c4 0c             	add    $0xc,%esp
80101ca6:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ca7:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101ca9:	ff 75 dc             	push   -0x24(%ebp)
80101cac:	50                   	push   %eax
80101cad:	e8 ae 2d 00 00       	call   80104a60 <memmove>
    log_write(bp);
80101cb2:	89 34 24             	mov    %esi,(%esp)
80101cb5:	e8 46 12 00 00       	call   80102f00 <log_write>
    brelse(bp);
80101cba:	89 34 24             	mov    %esi,(%esp)
80101cbd:	e8 2e e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cc2:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101cc5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101cc8:	83 c4 10             	add    $0x10,%esp
80101ccb:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101cce:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101cd1:	39 d8                	cmp    %ebx,%eax
80101cd3:	72 93                	jb     80101c68 <writei+0x68>
  }

  if(n > 0 && off > ip->size){
80101cd5:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cd8:	39 78 58             	cmp    %edi,0x58(%eax)
80101cdb:	72 3b                	jb     80101d18 <writei+0x118>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101cdd:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ce0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ce3:	5b                   	pop    %ebx
80101ce4:	5e                   	pop    %esi
80101ce5:	5f                   	pop    %edi
80101ce6:	5d                   	pop    %ebp
80101ce7:	c3                   	ret
80101ce8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cef:	90                   	nop
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101cf0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101cf4:	66 83 f8 09          	cmp    $0x9,%ax
80101cf8:	77 2f                	ja     80101d29 <writei+0x129>
80101cfa:	8b 04 c5 04 a3 11 80 	mov    -0x7fee5cfc(,%eax,8),%eax
80101d01:	85 c0                	test   %eax,%eax
80101d03:	74 24                	je     80101d29 <writei+0x129>
    return devsw[ip->major].write(ip, src, n);
80101d05:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101d08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d0b:	5b                   	pop    %ebx
80101d0c:	5e                   	pop    %esi
80101d0d:	5f                   	pop    %edi
80101d0e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101d0f:	ff e0                	jmp    *%eax
80101d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101d18:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101d1b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101d1e:	50                   	push   %eax
80101d1f:	e8 1c fa ff ff       	call   80101740 <iupdate>
80101d24:	83 c4 10             	add    $0x10,%esp
80101d27:	eb b4                	jmp    80101cdd <writei+0xdd>
      return -1;
80101d29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d2e:	eb b0                	jmp    80101ce0 <writei+0xe0>

80101d30 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d30:	55                   	push   %ebp
80101d31:	89 e5                	mov    %esp,%ebp
80101d33:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101d36:	6a 0e                	push   $0xe
80101d38:	ff 75 0c             	push   0xc(%ebp)
80101d3b:	ff 75 08             	push   0x8(%ebp)
80101d3e:	e8 8d 2d 00 00       	call   80104ad0 <strncmp>
}
80101d43:	c9                   	leave
80101d44:	c3                   	ret
80101d45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101d50 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d50:	55                   	push   %ebp
80101d51:	89 e5                	mov    %esp,%ebp
80101d53:	57                   	push   %edi
80101d54:	56                   	push   %esi
80101d55:	53                   	push   %ebx
80101d56:	83 ec 1c             	sub    $0x1c,%esp
80101d59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d5c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d61:	0f 85 85 00 00 00    	jne    80101dec <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d67:	8b 53 58             	mov    0x58(%ebx),%edx
80101d6a:	31 ff                	xor    %edi,%edi
80101d6c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d6f:	85 d2                	test   %edx,%edx
80101d71:	74 3e                	je     80101db1 <dirlookup+0x61>
80101d73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d77:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d78:	6a 10                	push   $0x10
80101d7a:	57                   	push   %edi
80101d7b:	56                   	push   %esi
80101d7c:	53                   	push   %ebx
80101d7d:	e8 7e fd ff ff       	call   80101b00 <readi>
80101d82:	83 c4 10             	add    $0x10,%esp
80101d85:	83 f8 10             	cmp    $0x10,%eax
80101d88:	75 55                	jne    80101ddf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d8f:	74 18                	je     80101da9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d91:	83 ec 04             	sub    $0x4,%esp
80101d94:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d97:	6a 0e                	push   $0xe
80101d99:	50                   	push   %eax
80101d9a:	ff 75 0c             	push   0xc(%ebp)
80101d9d:	e8 2e 2d 00 00       	call   80104ad0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101da2:	83 c4 10             	add    $0x10,%esp
80101da5:	85 c0                	test   %eax,%eax
80101da7:	74 17                	je     80101dc0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101da9:	83 c7 10             	add    $0x10,%edi
80101dac:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101daf:	72 c7                	jb     80101d78 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101db1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101db4:	31 c0                	xor    %eax,%eax
}
80101db6:	5b                   	pop    %ebx
80101db7:	5e                   	pop    %esi
80101db8:	5f                   	pop    %edi
80101db9:	5d                   	pop    %ebp
80101dba:	c3                   	ret
80101dbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101dbf:	90                   	nop
      if(poff)
80101dc0:	8b 45 10             	mov    0x10(%ebp),%eax
80101dc3:	85 c0                	test   %eax,%eax
80101dc5:	74 05                	je     80101dcc <dirlookup+0x7c>
        *poff = off;
80101dc7:	8b 45 10             	mov    0x10(%ebp),%eax
80101dca:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101dcc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101dd0:	8b 03                	mov    (%ebx),%eax
80101dd2:	e8 49 f5 ff ff       	call   80101320 <iget>
}
80101dd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dda:	5b                   	pop    %ebx
80101ddb:	5e                   	pop    %esi
80101ddc:	5f                   	pop    %edi
80101ddd:	5d                   	pop    %ebp
80101dde:	c3                   	ret
      panic("dirlookup read");
80101ddf:	83 ec 0c             	sub    $0xc,%esp
80101de2:	68 b9 77 10 80       	push   $0x801077b9
80101de7:	e8 94 e5 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101dec:	83 ec 0c             	sub    $0xc,%esp
80101def:	68 a7 77 10 80       	push   $0x801077a7
80101df4:	e8 87 e5 ff ff       	call   80100380 <panic>
80101df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e00 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	89 c3                	mov    %eax,%ebx
80101e08:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e0b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101e0e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e11:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101e14:	0f 84 64 01 00 00    	je     80101f7e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e1a:	e8 41 1b 00 00       	call   80103960 <myproc>
  acquire(&icache.lock);
80101e1f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101e22:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101e25:	68 60 a3 11 80       	push   $0x8011a360
80101e2a:	e8 11 2a 00 00       	call   80104840 <acquire>
  ip->ref++;
80101e2f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e33:	c7 04 24 60 a3 11 80 	movl   $0x8011a360,(%esp)
80101e3a:	e8 41 2b 00 00       	call   80104980 <release>
80101e3f:	83 c4 10             	add    $0x10,%esp
80101e42:	eb 07                	jmp    80101e4b <namex+0x4b>
80101e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e48:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e4b:	0f b6 03             	movzbl (%ebx),%eax
80101e4e:	3c 2f                	cmp    $0x2f,%al
80101e50:	74 f6                	je     80101e48 <namex+0x48>
  if(*path == 0)
80101e52:	84 c0                	test   %al,%al
80101e54:	0f 84 06 01 00 00    	je     80101f60 <namex+0x160>
  while(*path != '/' && *path != 0)
80101e5a:	0f b6 03             	movzbl (%ebx),%eax
80101e5d:	84 c0                	test   %al,%al
80101e5f:	0f 84 10 01 00 00    	je     80101f75 <namex+0x175>
80101e65:	89 df                	mov    %ebx,%edi
80101e67:	3c 2f                	cmp    $0x2f,%al
80101e69:	0f 84 06 01 00 00    	je     80101f75 <namex+0x175>
80101e6f:	90                   	nop
80101e70:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101e74:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101e77:	3c 2f                	cmp    $0x2f,%al
80101e79:	74 04                	je     80101e7f <namex+0x7f>
80101e7b:	84 c0                	test   %al,%al
80101e7d:	75 f1                	jne    80101e70 <namex+0x70>
  len = path - s;
80101e7f:	89 f8                	mov    %edi,%eax
80101e81:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101e83:	83 f8 0d             	cmp    $0xd,%eax
80101e86:	0f 8e ac 00 00 00    	jle    80101f38 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101e8c:	83 ec 04             	sub    $0x4,%esp
80101e8f:	6a 0e                	push   $0xe
80101e91:	53                   	push   %ebx
    path++;
80101e92:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80101e94:	ff 75 e4             	push   -0x1c(%ebp)
80101e97:	e8 c4 2b 00 00       	call   80104a60 <memmove>
80101e9c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e9f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101ea2:	75 0c                	jne    80101eb0 <namex+0xb0>
80101ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101ea8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101eab:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101eae:	74 f8                	je     80101ea8 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101eb0:	83 ec 0c             	sub    $0xc,%esp
80101eb3:	56                   	push   %esi
80101eb4:	e8 37 f9 ff ff       	call   801017f0 <ilock>
    if(ip->type != T_DIR){
80101eb9:	83 c4 10             	add    $0x10,%esp
80101ebc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101ec1:	0f 85 cd 00 00 00    	jne    80101f94 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101ec7:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101eca:	85 c0                	test   %eax,%eax
80101ecc:	74 09                	je     80101ed7 <namex+0xd7>
80101ece:	80 3b 00             	cmpb   $0x0,(%ebx)
80101ed1:	0f 84 34 01 00 00    	je     8010200b <namex+0x20b>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101ed7:	83 ec 04             	sub    $0x4,%esp
80101eda:	6a 00                	push   $0x0
80101edc:	ff 75 e4             	push   -0x1c(%ebp)
80101edf:	56                   	push   %esi
80101ee0:	e8 6b fe ff ff       	call   80101d50 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ee5:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101ee8:	83 c4 10             	add    $0x10,%esp
80101eeb:	89 c7                	mov    %eax,%edi
80101eed:	85 c0                	test   %eax,%eax
80101eef:	0f 84 e1 00 00 00    	je     80101fd6 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ef5:	83 ec 0c             	sub    $0xc,%esp
80101ef8:	52                   	push   %edx
80101ef9:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101efc:	e8 ef 27 00 00       	call   801046f0 <holdingsleep>
80101f01:	83 c4 10             	add    $0x10,%esp
80101f04:	85 c0                	test   %eax,%eax
80101f06:	0f 84 3f 01 00 00    	je     8010204b <namex+0x24b>
80101f0c:	8b 56 08             	mov    0x8(%esi),%edx
80101f0f:	85 d2                	test   %edx,%edx
80101f11:	0f 8e 34 01 00 00    	jle    8010204b <namex+0x24b>
  releasesleep(&ip->lock);
80101f17:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101f1a:	83 ec 0c             	sub    $0xc,%esp
80101f1d:	52                   	push   %edx
80101f1e:	e8 8d 27 00 00       	call   801046b0 <releasesleep>
  iput(ip);
80101f23:	89 34 24             	mov    %esi,(%esp)
80101f26:	89 fe                	mov    %edi,%esi
80101f28:	e8 f3 f9 ff ff       	call   80101920 <iput>
80101f2d:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f30:	e9 16 ff ff ff       	jmp    80101e4b <namex+0x4b>
80101f35:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101f38:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f3b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80101f3e:	83 ec 04             	sub    $0x4,%esp
80101f41:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101f44:	50                   	push   %eax
80101f45:	53                   	push   %ebx
    name[len] = 0;
80101f46:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101f48:	ff 75 e4             	push   -0x1c(%ebp)
80101f4b:	e8 10 2b 00 00       	call   80104a60 <memmove>
    name[len] = 0;
80101f50:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101f53:	83 c4 10             	add    $0x10,%esp
80101f56:	c6 02 00             	movb   $0x0,(%edx)
80101f59:	e9 41 ff ff ff       	jmp    80101e9f <namex+0x9f>
80101f5e:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101f60:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f63:	85 c0                	test   %eax,%eax
80101f65:	0f 85 d0 00 00 00    	jne    8010203b <namex+0x23b>
    iput(ip);
    return 0;
  }
  return ip;
}
80101f6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f6e:	89 f0                	mov    %esi,%eax
80101f70:	5b                   	pop    %ebx
80101f71:	5e                   	pop    %esi
80101f72:	5f                   	pop    %edi
80101f73:	5d                   	pop    %ebp
80101f74:	c3                   	ret
  while(*path != '/' && *path != 0)
80101f75:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f78:	89 df                	mov    %ebx,%edi
80101f7a:	31 c0                	xor    %eax,%eax
80101f7c:	eb c0                	jmp    80101f3e <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80101f7e:	ba 01 00 00 00       	mov    $0x1,%edx
80101f83:	b8 01 00 00 00       	mov    $0x1,%eax
80101f88:	e8 93 f3 ff ff       	call   80101320 <iget>
80101f8d:	89 c6                	mov    %eax,%esi
80101f8f:	e9 b7 fe ff ff       	jmp    80101e4b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f94:	83 ec 0c             	sub    $0xc,%esp
80101f97:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f9a:	53                   	push   %ebx
80101f9b:	e8 50 27 00 00       	call   801046f0 <holdingsleep>
80101fa0:	83 c4 10             	add    $0x10,%esp
80101fa3:	85 c0                	test   %eax,%eax
80101fa5:	0f 84 a0 00 00 00    	je     8010204b <namex+0x24b>
80101fab:	8b 46 08             	mov    0x8(%esi),%eax
80101fae:	85 c0                	test   %eax,%eax
80101fb0:	0f 8e 95 00 00 00    	jle    8010204b <namex+0x24b>
  releasesleep(&ip->lock);
80101fb6:	83 ec 0c             	sub    $0xc,%esp
80101fb9:	53                   	push   %ebx
80101fba:	e8 f1 26 00 00       	call   801046b0 <releasesleep>
  iput(ip);
80101fbf:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101fc2:	31 f6                	xor    %esi,%esi
  iput(ip);
80101fc4:	e8 57 f9 ff ff       	call   80101920 <iput>
      return 0;
80101fc9:	83 c4 10             	add    $0x10,%esp
}
80101fcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fcf:	89 f0                	mov    %esi,%eax
80101fd1:	5b                   	pop    %ebx
80101fd2:	5e                   	pop    %esi
80101fd3:	5f                   	pop    %edi
80101fd4:	5d                   	pop    %ebp
80101fd5:	c3                   	ret
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fd6:	83 ec 0c             	sub    $0xc,%esp
80101fd9:	52                   	push   %edx
80101fda:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101fdd:	e8 0e 27 00 00       	call   801046f0 <holdingsleep>
80101fe2:	83 c4 10             	add    $0x10,%esp
80101fe5:	85 c0                	test   %eax,%eax
80101fe7:	74 62                	je     8010204b <namex+0x24b>
80101fe9:	8b 4e 08             	mov    0x8(%esi),%ecx
80101fec:	85 c9                	test   %ecx,%ecx
80101fee:	7e 5b                	jle    8010204b <namex+0x24b>
  releasesleep(&ip->lock);
80101ff0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ff3:	83 ec 0c             	sub    $0xc,%esp
80101ff6:	52                   	push   %edx
80101ff7:	e8 b4 26 00 00       	call   801046b0 <releasesleep>
  iput(ip);
80101ffc:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101fff:	31 f6                	xor    %esi,%esi
  iput(ip);
80102001:	e8 1a f9 ff ff       	call   80101920 <iput>
      return 0;
80102006:	83 c4 10             	add    $0x10,%esp
80102009:	eb c1                	jmp    80101fcc <namex+0x1cc>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010200b:	83 ec 0c             	sub    $0xc,%esp
8010200e:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102011:	53                   	push   %ebx
80102012:	e8 d9 26 00 00       	call   801046f0 <holdingsleep>
80102017:	83 c4 10             	add    $0x10,%esp
8010201a:	85 c0                	test   %eax,%eax
8010201c:	74 2d                	je     8010204b <namex+0x24b>
8010201e:	8b 7e 08             	mov    0x8(%esi),%edi
80102021:	85 ff                	test   %edi,%edi
80102023:	7e 26                	jle    8010204b <namex+0x24b>
  releasesleep(&ip->lock);
80102025:	83 ec 0c             	sub    $0xc,%esp
80102028:	53                   	push   %ebx
80102029:	e8 82 26 00 00       	call   801046b0 <releasesleep>
}
8010202e:	83 c4 10             	add    $0x10,%esp
}
80102031:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102034:	89 f0                	mov    %esi,%eax
80102036:	5b                   	pop    %ebx
80102037:	5e                   	pop    %esi
80102038:	5f                   	pop    %edi
80102039:	5d                   	pop    %ebp
8010203a:	c3                   	ret
    iput(ip);
8010203b:	83 ec 0c             	sub    $0xc,%esp
8010203e:	56                   	push   %esi
      return 0;
8010203f:	31 f6                	xor    %esi,%esi
    iput(ip);
80102041:	e8 da f8 ff ff       	call   80101920 <iput>
    return 0;
80102046:	83 c4 10             	add    $0x10,%esp
80102049:	eb 81                	jmp    80101fcc <namex+0x1cc>
    panic("iunlock");
8010204b:	83 ec 0c             	sub    $0xc,%esp
8010204e:	68 9f 77 10 80       	push   $0x8010779f
80102053:	e8 28 e3 ff ff       	call   80100380 <panic>
80102058:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010205f:	90                   	nop

80102060 <dirlink>:
{
80102060:	55                   	push   %ebp
80102061:	89 e5                	mov    %esp,%ebp
80102063:	57                   	push   %edi
80102064:	56                   	push   %esi
80102065:	53                   	push   %ebx
80102066:	83 ec 20             	sub    $0x20,%esp
80102069:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010206c:	6a 00                	push   $0x0
8010206e:	ff 75 0c             	push   0xc(%ebp)
80102071:	53                   	push   %ebx
80102072:	e8 d9 fc ff ff       	call   80101d50 <dirlookup>
80102077:	83 c4 10             	add    $0x10,%esp
8010207a:	85 c0                	test   %eax,%eax
8010207c:	75 67                	jne    801020e5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010207e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102081:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102084:	85 ff                	test   %edi,%edi
80102086:	74 29                	je     801020b1 <dirlink+0x51>
80102088:	31 ff                	xor    %edi,%edi
8010208a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010208d:	eb 09                	jmp    80102098 <dirlink+0x38>
8010208f:	90                   	nop
80102090:	83 c7 10             	add    $0x10,%edi
80102093:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102096:	73 19                	jae    801020b1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102098:	6a 10                	push   $0x10
8010209a:	57                   	push   %edi
8010209b:	56                   	push   %esi
8010209c:	53                   	push   %ebx
8010209d:	e8 5e fa ff ff       	call   80101b00 <readi>
801020a2:	83 c4 10             	add    $0x10,%esp
801020a5:	83 f8 10             	cmp    $0x10,%eax
801020a8:	75 4e                	jne    801020f8 <dirlink+0x98>
    if(de.inum == 0)
801020aa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801020af:	75 df                	jne    80102090 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
801020b1:	83 ec 04             	sub    $0x4,%esp
801020b4:	8d 45 da             	lea    -0x26(%ebp),%eax
801020b7:	6a 0e                	push   $0xe
801020b9:	ff 75 0c             	push   0xc(%ebp)
801020bc:	50                   	push   %eax
801020bd:	e8 5e 2a 00 00       	call   80104b20 <strncpy>
  de.inum = inum;
801020c2:	8b 45 10             	mov    0x10(%ebp),%eax
801020c5:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020c9:	6a 10                	push   $0x10
801020cb:	57                   	push   %edi
801020cc:	56                   	push   %esi
801020cd:	53                   	push   %ebx
801020ce:	e8 2d fb ff ff       	call   80101c00 <writei>
801020d3:	83 c4 20             	add    $0x20,%esp
801020d6:	83 f8 10             	cmp    $0x10,%eax
801020d9:	75 2a                	jne    80102105 <dirlink+0xa5>
  return 0;
801020db:	31 c0                	xor    %eax,%eax
}
801020dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020e0:	5b                   	pop    %ebx
801020e1:	5e                   	pop    %esi
801020e2:	5f                   	pop    %edi
801020e3:	5d                   	pop    %ebp
801020e4:	c3                   	ret
    iput(ip);
801020e5:	83 ec 0c             	sub    $0xc,%esp
801020e8:	50                   	push   %eax
801020e9:	e8 32 f8 ff ff       	call   80101920 <iput>
    return -1;
801020ee:	83 c4 10             	add    $0x10,%esp
801020f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020f6:	eb e5                	jmp    801020dd <dirlink+0x7d>
      panic("dirlink read");
801020f8:	83 ec 0c             	sub    $0xc,%esp
801020fb:	68 c8 77 10 80       	push   $0x801077c8
80102100:	e8 7b e2 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102105:	83 ec 0c             	sub    $0xc,%esp
80102108:	68 1e 7c 10 80       	push   $0x80107c1e
8010210d:	e8 6e e2 ff ff       	call   80100380 <panic>
80102112:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102120 <namei>:

struct inode*
namei(char *path)
{
80102120:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102121:	31 d2                	xor    %edx,%edx
{
80102123:	89 e5                	mov    %esp,%ebp
80102125:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102128:	8b 45 08             	mov    0x8(%ebp),%eax
8010212b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010212e:	e8 cd fc ff ff       	call   80101e00 <namex>
}
80102133:	c9                   	leave
80102134:	c3                   	ret
80102135:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102140 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102140:	55                   	push   %ebp
  return namex(path, 1, name);
80102141:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102146:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102148:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010214b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010214e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010214f:	e9 ac fc ff ff       	jmp    80101e00 <namex>
80102154:	66 90                	xchg   %ax,%ax
80102156:	66 90                	xchg   %ax,%ax
80102158:	66 90                	xchg   %ax,%ax
8010215a:	66 90                	xchg   %ax,%ax
8010215c:	66 90                	xchg   %ax,%ax
8010215e:	66 90                	xchg   %ax,%ax

80102160 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102160:	55                   	push   %ebp
80102161:	89 e5                	mov    %esp,%ebp
80102163:	57                   	push   %edi
80102164:	56                   	push   %esi
80102165:	53                   	push   %ebx
80102166:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102169:	85 c0                	test   %eax,%eax
8010216b:	0f 84 b4 00 00 00    	je     80102225 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102171:	8b 70 08             	mov    0x8(%eax),%esi
80102174:	89 c3                	mov    %eax,%ebx
80102176:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010217c:	0f 87 96 00 00 00    	ja     80102218 <idestart+0xb8>
    panic("incorrect blockno");
  int sector_per_block =  BSIZE/SECTOR_SIZE;
  int sector = b->blockno * sector_per_block;
80102182:	c1 e6 02             	shl    $0x2,%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102185:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
8010218a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102190:	89 ca                	mov    %ecx,%edx
80102192:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102193:	83 e0 c0             	and    $0xffffffc0,%eax
80102196:	3c 40                	cmp    $0x40,%al
80102198:	75 f6                	jne    80102190 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010219a:	31 ff                	xor    %edi,%edi
8010219c:	ba f6 03 00 00       	mov    $0x3f6,%edx
801021a1:	89 f8                	mov    %edi,%eax
801021a3:	ee                   	out    %al,(%dx)
801021a4:	b8 04 00 00 00       	mov    $0x4,%eax
801021a9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801021ae:	ee                   	out    %al,(%dx)
801021af:	ba f3 01 00 00       	mov    $0x1f3,%edx
801021b4:	89 f0                	mov    %esi,%eax
801021b6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801021b7:	89 f0                	mov    %esi,%eax
801021b9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801021be:	c1 f8 08             	sar    $0x8,%eax
801021c1:	ee                   	out    %al,(%dx)
801021c2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801021c7:	89 f8                	mov    %edi,%eax
801021c9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801021ca:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801021ce:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021d3:	c1 e0 04             	shl    $0x4,%eax
801021d6:	83 e0 10             	and    $0x10,%eax
801021d9:	83 c8 e0             	or     $0xffffffe0,%eax
801021dc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801021dd:	f6 03 04             	testb  $0x4,(%ebx)
801021e0:	75 16                	jne    801021f8 <idestart+0x98>
801021e2:	b8 c4 ff ff ff       	mov    $0xffffffc4,%eax
801021e7:	89 ca                	mov    %ecx,%edx
801021e9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801021ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021ed:	5b                   	pop    %ebx
801021ee:	5e                   	pop    %esi
801021ef:	5f                   	pop    %edi
801021f0:	5d                   	pop    %ebp
801021f1:	c3                   	ret
801021f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021f8:	b8 c5 ff ff ff       	mov    $0xffffffc5,%eax
801021fd:	89 ca                	mov    %ecx,%edx
801021ff:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102200:	b9 00 02 00 00       	mov    $0x200,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102205:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102208:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010220d:	fc                   	cld
8010220e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102210:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102213:	5b                   	pop    %ebx
80102214:	5e                   	pop    %esi
80102215:	5f                   	pop    %edi
80102216:	5d                   	pop    %ebp
80102217:	c3                   	ret
    panic("incorrect blockno");
80102218:	83 ec 0c             	sub    $0xc,%esp
8010221b:	68 34 78 10 80       	push   $0x80107834
80102220:	e8 5b e1 ff ff       	call   80100380 <panic>
    panic("idestart");
80102225:	83 ec 0c             	sub    $0xc,%esp
80102228:	68 2b 78 10 80       	push   $0x8010782b
8010222d:	e8 4e e1 ff ff       	call   80100380 <panic>
80102232:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102240 <ideinit>:
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102246:	68 46 78 10 80       	push   $0x80107846
8010224b:	68 00 c0 11 80       	push   $0x8011c000
80102250:	e8 cb 24 00 00       	call   80104720 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102255:	58                   	pop    %eax
80102256:	a1 64 c1 11 80       	mov    0x8011c164,%eax
8010225b:	5a                   	pop    %edx
8010225c:	83 e8 01             	sub    $0x1,%eax
8010225f:	50                   	push   %eax
80102260:	6a 0e                	push   $0xe
80102262:	e8 99 02 00 00       	call   80102500 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102267:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010226a:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
8010226f:	90                   	nop
80102270:	89 ca                	mov    %ecx,%edx
80102272:	ec                   	in     (%dx),%al
80102273:	83 e0 c0             	and    $0xffffffc0,%eax
80102276:	3c 40                	cmp    $0x40,%al
80102278:	75 f6                	jne    80102270 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010227a:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010227f:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102284:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102285:	89 ca                	mov    %ecx,%edx
80102287:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102288:	84 c0                	test   %al,%al
8010228a:	75 1e                	jne    801022aa <ideinit+0x6a>
8010228c:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102291:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010229d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i=0; i<1000; i++){
801022a0:	83 e9 01             	sub    $0x1,%ecx
801022a3:	74 0f                	je     801022b4 <ideinit+0x74>
801022a5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801022a6:	84 c0                	test   %al,%al
801022a8:	74 f6                	je     801022a0 <ideinit+0x60>
      havedisk1 = 1;
801022aa:	c7 05 e0 bf 11 80 01 	movl   $0x1,0x8011bfe0
801022b1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022b4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801022b9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022be:	ee                   	out    %al,(%dx)
}
801022bf:	c9                   	leave
801022c0:	c3                   	ret
801022c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022cf:	90                   	nop

801022d0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801022d0:	55                   	push   %ebp
801022d1:	89 e5                	mov    %esp,%ebp
801022d3:	57                   	push   %edi
801022d4:	56                   	push   %esi
801022d5:	53                   	push   %ebx
801022d6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801022d9:	68 00 c0 11 80       	push   $0x8011c000
801022de:	e8 5d 25 00 00       	call   80104840 <acquire>

  if((b = idequeue) == 0){
801022e3:	8b 1d e4 bf 11 80    	mov    0x8011bfe4,%ebx
801022e9:	83 c4 10             	add    $0x10,%esp
801022ec:	85 db                	test   %ebx,%ebx
801022ee:	74 63                	je     80102353 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801022f0:	8b 43 58             	mov    0x58(%ebx),%eax
801022f3:	a3 e4 bf 11 80       	mov    %eax,0x8011bfe4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801022f8:	8b 33                	mov    (%ebx),%esi
801022fa:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102300:	75 2f                	jne    80102331 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102302:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102307:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010230e:	66 90                	xchg   %ax,%ax
80102310:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102311:	89 c1                	mov    %eax,%ecx
80102313:	83 e1 c0             	and    $0xffffffc0,%ecx
80102316:	80 f9 40             	cmp    $0x40,%cl
80102319:	75 f5                	jne    80102310 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010231b:	a8 21                	test   $0x21,%al
8010231d:	75 12                	jne    80102331 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010231f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102322:	b9 00 02 00 00       	mov    $0x200,%ecx
80102327:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010232c:	fc                   	cld
8010232d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010232f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102331:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102334:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102337:	83 ce 02             	or     $0x2,%esi
8010233a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010233c:	53                   	push   %ebx
8010233d:	e8 ae 1d 00 00       	call   801040f0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102342:	a1 e4 bf 11 80       	mov    0x8011bfe4,%eax
80102347:	83 c4 10             	add    $0x10,%esp
8010234a:	85 c0                	test   %eax,%eax
8010234c:	74 05                	je     80102353 <ideintr+0x83>
    idestart(idequeue);
8010234e:	e8 0d fe ff ff       	call   80102160 <idestart>
    release(&idelock);
80102353:	83 ec 0c             	sub    $0xc,%esp
80102356:	68 00 c0 11 80       	push   $0x8011c000
8010235b:	e8 20 26 00 00       	call   80104980 <release>

  release(&idelock);
}
80102360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102363:	5b                   	pop    %ebx
80102364:	5e                   	pop    %esi
80102365:	5f                   	pop    %edi
80102366:	5d                   	pop    %ebp
80102367:	c3                   	ret
80102368:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010236f:	90                   	nop

80102370 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	53                   	push   %ebx
80102374:	83 ec 10             	sub    $0x10,%esp
80102377:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010237a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010237d:	50                   	push   %eax
8010237e:	e8 6d 23 00 00       	call   801046f0 <holdingsleep>
80102383:	83 c4 10             	add    $0x10,%esp
80102386:	85 c0                	test   %eax,%eax
80102388:	0f 84 c3 00 00 00    	je     80102451 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010238e:	8b 03                	mov    (%ebx),%eax
80102390:	83 e0 06             	and    $0x6,%eax
80102393:	83 f8 02             	cmp    $0x2,%eax
80102396:	0f 84 a8 00 00 00    	je     80102444 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010239c:	8b 53 04             	mov    0x4(%ebx),%edx
8010239f:	85 d2                	test   %edx,%edx
801023a1:	74 0d                	je     801023b0 <iderw+0x40>
801023a3:	a1 e0 bf 11 80       	mov    0x8011bfe0,%eax
801023a8:	85 c0                	test   %eax,%eax
801023aa:	0f 84 87 00 00 00    	je     80102437 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801023b0:	83 ec 0c             	sub    $0xc,%esp
801023b3:	68 00 c0 11 80       	push   $0x8011c000
801023b8:	e8 83 24 00 00       	call   80104840 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023bd:	a1 e4 bf 11 80       	mov    0x8011bfe4,%eax
  b->qnext = 0;
801023c2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023c9:	83 c4 10             	add    $0x10,%esp
801023cc:	85 c0                	test   %eax,%eax
801023ce:	74 60                	je     80102430 <iderw+0xc0>
801023d0:	89 c2                	mov    %eax,%edx
801023d2:	8b 40 58             	mov    0x58(%eax),%eax
801023d5:	85 c0                	test   %eax,%eax
801023d7:	75 f7                	jne    801023d0 <iderw+0x60>
801023d9:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801023dc:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801023de:	39 1d e4 bf 11 80    	cmp    %ebx,0x8011bfe4
801023e4:	74 3a                	je     80102420 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801023e6:	8b 03                	mov    (%ebx),%eax
801023e8:	83 e0 06             	and    $0x6,%eax
801023eb:	83 f8 02             	cmp    $0x2,%eax
801023ee:	74 1b                	je     8010240b <iderw+0x9b>
    sleep(b, &idelock);
801023f0:	83 ec 08             	sub    $0x8,%esp
801023f3:	68 00 c0 11 80       	push   $0x8011c000
801023f8:	53                   	push   %ebx
801023f9:	e8 32 1c 00 00       	call   80104030 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801023fe:	8b 03                	mov    (%ebx),%eax
80102400:	83 c4 10             	add    $0x10,%esp
80102403:	83 e0 06             	and    $0x6,%eax
80102406:	83 f8 02             	cmp    $0x2,%eax
80102409:	75 e5                	jne    801023f0 <iderw+0x80>
  }


  release(&idelock);
8010240b:	c7 45 08 00 c0 11 80 	movl   $0x8011c000,0x8(%ebp)
}
80102412:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102415:	c9                   	leave
  release(&idelock);
80102416:	e9 65 25 00 00       	jmp    80104980 <release>
8010241b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010241f:	90                   	nop
    idestart(b);
80102420:	89 d8                	mov    %ebx,%eax
80102422:	e8 39 fd ff ff       	call   80102160 <idestart>
80102427:	eb bd                	jmp    801023e6 <iderw+0x76>
80102429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102430:	ba e4 bf 11 80       	mov    $0x8011bfe4,%edx
80102435:	eb a5                	jmp    801023dc <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102437:	83 ec 0c             	sub    $0xc,%esp
8010243a:	68 75 78 10 80       	push   $0x80107875
8010243f:	e8 3c df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102444:	83 ec 0c             	sub    $0xc,%esp
80102447:	68 60 78 10 80       	push   $0x80107860
8010244c:	e8 2f df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102451:	83 ec 0c             	sub    $0xc,%esp
80102454:	68 4a 78 10 80       	push   $0x8010784a
80102459:	e8 22 df ff ff       	call   80100380 <panic>
8010245e:	66 90                	xchg   %ax,%ax

80102460 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	56                   	push   %esi
80102464:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102465:	c7 05 34 c0 11 80 00 	movl   $0xfec00000,0x8011c034
8010246c:	00 c0 fe 
  ioapic->reg = reg;
8010246f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102476:	00 00 00 
  return ioapic->data;
80102479:	8b 15 34 c0 11 80    	mov    0x8011c034,%edx
8010247f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102482:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102488:	8b 1d 34 c0 11 80    	mov    0x8011c034,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010248e:	0f b6 15 60 c1 11 80 	movzbl 0x8011c160,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102495:	c1 ee 10             	shr    $0x10,%esi
80102498:	89 f0                	mov    %esi,%eax
8010249a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010249d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
801024a0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801024a3:	39 c2                	cmp    %eax,%edx
801024a5:	74 16                	je     801024bd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801024a7:	83 ec 0c             	sub    $0xc,%esp
801024aa:	68 94 78 10 80       	push   $0x80107894
801024af:	e8 fc e1 ff ff       	call   801006b0 <cprintf>
  ioapic->reg = reg;
801024b4:	8b 1d 34 c0 11 80    	mov    0x8011c034,%ebx
801024ba:	83 c4 10             	add    $0x10,%esp
{
801024bd:	ba 10 00 00 00       	mov    $0x10,%edx
801024c2:	31 c0                	xor    %eax,%eax
801024c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
801024c8:	89 13                	mov    %edx,(%ebx)
801024ca:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
801024cd:	8b 1d 34 c0 11 80    	mov    0x8011c034,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801024d3:	83 c0 01             	add    $0x1,%eax
801024d6:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
801024dc:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
801024df:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
801024e2:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801024e5:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801024e7:	8b 1d 34 c0 11 80    	mov    0x8011c034,%ebx
801024ed:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
801024f4:	39 c6                	cmp    %eax,%esi
801024f6:	7d d0                	jge    801024c8 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801024f8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024fb:	5b                   	pop    %ebx
801024fc:	5e                   	pop    %esi
801024fd:	5d                   	pop    %ebp
801024fe:	c3                   	ret
801024ff:	90                   	nop

80102500 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102500:	55                   	push   %ebp
  ioapic->reg = reg;
80102501:	8b 0d 34 c0 11 80    	mov    0x8011c034,%ecx
{
80102507:	89 e5                	mov    %esp,%ebp
80102509:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010250c:	8d 50 20             	lea    0x20(%eax),%edx
8010250f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102513:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102515:	8b 0d 34 c0 11 80    	mov    0x8011c034,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010251b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010251e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102521:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102524:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102526:	a1 34 c0 11 80       	mov    0x8011c034,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010252b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010252e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102531:	5d                   	pop    %ebp
80102532:	c3                   	ret
80102533:	66 90                	xchg   %ax,%ax
80102535:	66 90                	xchg   %ax,%ax
80102537:	66 90                	xchg   %ax,%ax
80102539:	66 90                	xchg   %ax,%ax
8010253b:	66 90                	xchg   %ax,%ax
8010253d:	66 90                	xchg   %ax,%ax
8010253f:	90                   	nop

80102540 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	53                   	push   %ebx
80102544:	83 ec 04             	sub    $0x4,%esp
80102547:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010254a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102550:	75 76                	jne    801025c8 <kfree+0x88>
80102552:	81 fb b0 00 12 80    	cmp    $0x801200b0,%ebx
80102558:	72 6e                	jb     801025c8 <kfree+0x88>
8010255a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102560:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102565:	77 61                	ja     801025c8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102567:	83 ec 04             	sub    $0x4,%esp
8010256a:	68 00 10 00 00       	push   $0x1000
8010256f:	6a 01                	push   $0x1
80102571:	53                   	push   %ebx
80102572:	e8 59 24 00 00       	call   801049d0 <memset>

  if(kmem.use_lock)
80102577:	8b 15 74 c0 11 80    	mov    0x8011c074,%edx
8010257d:	83 c4 10             	add    $0x10,%esp
80102580:	85 d2                	test   %edx,%edx
80102582:	75 1c                	jne    801025a0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102584:	a1 78 c0 11 80       	mov    0x8011c078,%eax
80102589:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010258b:	a1 74 c0 11 80       	mov    0x8011c074,%eax
  kmem.freelist = r;
80102590:	89 1d 78 c0 11 80    	mov    %ebx,0x8011c078
  if(kmem.use_lock)
80102596:	85 c0                	test   %eax,%eax
80102598:	75 1e                	jne    801025b8 <kfree+0x78>
    release(&kmem.lock);
}
8010259a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010259d:	c9                   	leave
8010259e:	c3                   	ret
8010259f:	90                   	nop
    acquire(&kmem.lock);
801025a0:	83 ec 0c             	sub    $0xc,%esp
801025a3:	68 40 c0 11 80       	push   $0x8011c040
801025a8:	e8 93 22 00 00       	call   80104840 <acquire>
801025ad:	83 c4 10             	add    $0x10,%esp
801025b0:	eb d2                	jmp    80102584 <kfree+0x44>
801025b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801025b8:	c7 45 08 40 c0 11 80 	movl   $0x8011c040,0x8(%ebp)
}
801025bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025c2:	c9                   	leave
    release(&kmem.lock);
801025c3:	e9 b8 23 00 00       	jmp    80104980 <release>
    panic("kfree");
801025c8:	83 ec 0c             	sub    $0xc,%esp
801025cb:	68 c6 78 10 80       	push   $0x801078c6
801025d0:	e8 ab dd ff ff       	call   80100380 <panic>
801025d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801025e0 <freerange>:
{
801025e0:	55                   	push   %ebp
801025e1:	89 e5                	mov    %esp,%ebp
801025e3:	56                   	push   %esi
801025e4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025e5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801025eb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025f1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025fd:	39 de                	cmp    %ebx,%esi
801025ff:	72 23                	jb     80102624 <freerange+0x44>
80102601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102608:	83 ec 0c             	sub    $0xc,%esp
8010260b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102611:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102617:	50                   	push   %eax
80102618:	e8 23 ff ff ff       	call   80102540 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010261d:	83 c4 10             	add    $0x10,%esp
80102620:	39 de                	cmp    %ebx,%esi
80102622:	73 e4                	jae    80102608 <freerange+0x28>
}
80102624:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102627:	5b                   	pop    %ebx
80102628:	5e                   	pop    %esi
80102629:	5d                   	pop    %ebp
8010262a:	c3                   	ret
8010262b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010262f:	90                   	nop

80102630 <kinit2>:
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	56                   	push   %esi
80102634:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102635:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102638:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010263b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102641:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102647:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010264d:	39 de                	cmp    %ebx,%esi
8010264f:	72 23                	jb     80102674 <kinit2+0x44>
80102651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102658:	83 ec 0c             	sub    $0xc,%esp
8010265b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102661:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102667:	50                   	push   %eax
80102668:	e8 d3 fe ff ff       	call   80102540 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010266d:	83 c4 10             	add    $0x10,%esp
80102670:	39 de                	cmp    %ebx,%esi
80102672:	73 e4                	jae    80102658 <kinit2+0x28>
  kmem.use_lock = 1;
80102674:	c7 05 74 c0 11 80 01 	movl   $0x1,0x8011c074
8010267b:	00 00 00 
}
8010267e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102681:	5b                   	pop    %ebx
80102682:	5e                   	pop    %esi
80102683:	5d                   	pop    %ebp
80102684:	c3                   	ret
80102685:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010268c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102690 <kinit1>:
{
80102690:	55                   	push   %ebp
80102691:	89 e5                	mov    %esp,%ebp
80102693:	56                   	push   %esi
80102694:	53                   	push   %ebx
80102695:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102698:	83 ec 08             	sub    $0x8,%esp
8010269b:	68 cc 78 10 80       	push   $0x801078cc
801026a0:	68 40 c0 11 80       	push   $0x8011c040
801026a5:	e8 76 20 00 00       	call   80104720 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801026aa:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026ad:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801026b0:	c7 05 74 c0 11 80 00 	movl   $0x0,0x8011c074
801026b7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801026ba:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026c0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026c6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026cc:	39 de                	cmp    %ebx,%esi
801026ce:	72 1c                	jb     801026ec <kinit1+0x5c>
    kfree(p);
801026d0:	83 ec 0c             	sub    $0xc,%esp
801026d3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026d9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026df:	50                   	push   %eax
801026e0:	e8 5b fe ff ff       	call   80102540 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026e5:	83 c4 10             	add    $0x10,%esp
801026e8:	39 de                	cmp    %ebx,%esi
801026ea:	73 e4                	jae    801026d0 <kinit1+0x40>
}
801026ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026ef:	5b                   	pop    %ebx
801026f0:	5e                   	pop    %esi
801026f1:	5d                   	pop    %ebp
801026f2:	c3                   	ret
801026f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102700 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102700:	55                   	push   %ebp
80102701:	89 e5                	mov    %esp,%ebp
80102703:	53                   	push   %ebx
80102704:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102707:	a1 74 c0 11 80       	mov    0x8011c074,%eax
8010270c:	85 c0                	test   %eax,%eax
8010270e:	75 20                	jne    80102730 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102710:	8b 1d 78 c0 11 80    	mov    0x8011c078,%ebx
  if(r)
80102716:	85 db                	test   %ebx,%ebx
80102718:	74 07                	je     80102721 <kalloc+0x21>
    kmem.freelist = r->next;
8010271a:	8b 03                	mov    (%ebx),%eax
8010271c:	a3 78 c0 11 80       	mov    %eax,0x8011c078
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102721:	89 d8                	mov    %ebx,%eax
80102723:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102726:	c9                   	leave
80102727:	c3                   	ret
80102728:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010272f:	90                   	nop
    acquire(&kmem.lock);
80102730:	83 ec 0c             	sub    $0xc,%esp
80102733:	68 40 c0 11 80       	push   $0x8011c040
80102738:	e8 03 21 00 00       	call   80104840 <acquire>
  r = kmem.freelist;
8010273d:	8b 1d 78 c0 11 80    	mov    0x8011c078,%ebx
  if(kmem.use_lock)
80102743:	a1 74 c0 11 80       	mov    0x8011c074,%eax
  if(r)
80102748:	83 c4 10             	add    $0x10,%esp
8010274b:	85 db                	test   %ebx,%ebx
8010274d:	74 08                	je     80102757 <kalloc+0x57>
    kmem.freelist = r->next;
8010274f:	8b 13                	mov    (%ebx),%edx
80102751:	89 15 78 c0 11 80    	mov    %edx,0x8011c078
  if(kmem.use_lock)
80102757:	85 c0                	test   %eax,%eax
80102759:	74 c6                	je     80102721 <kalloc+0x21>
    release(&kmem.lock);
8010275b:	83 ec 0c             	sub    $0xc,%esp
8010275e:	68 40 c0 11 80       	push   $0x8011c040
80102763:	e8 18 22 00 00       	call   80104980 <release>
}
80102768:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010276a:	83 c4 10             	add    $0x10,%esp
}
8010276d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102770:	c9                   	leave
80102771:	c3                   	ret
80102772:	66 90                	xchg   %ax,%ax
80102774:	66 90                	xchg   %ax,%ax
80102776:	66 90                	xchg   %ax,%ax
80102778:	66 90                	xchg   %ax,%ax
8010277a:	66 90                	xchg   %ax,%ax
8010277c:	66 90                	xchg   %ax,%ax
8010277e:	66 90                	xchg   %ax,%ax

80102780 <kbdgetc>:
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  
  return c;
}
80102780:	b8 05 00 00 00       	mov    $0x5,%eax
80102785:	c3                   	ret
80102786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010278d:	8d 76 00             	lea    0x0(%esi),%esi

80102790 <kbdintr>:

void
kbdintr(void)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
80102793:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102796:	68 80 27 10 80       	push   $0x80102780
8010279b:	e8 20 e1 ff ff       	call   801008c0 <consoleintr>
}
801027a0:	83 c4 10             	add    $0x10,%esp
801027a3:	c9                   	leave
801027a4:	c3                   	ret
801027a5:	66 90                	xchg   %ax,%ax
801027a7:	66 90                	xchg   %ax,%ax
801027a9:	66 90                	xchg   %ax,%ax
801027ab:	66 90                	xchg   %ax,%ax
801027ad:	66 90                	xchg   %ax,%ax
801027af:	90                   	nop

801027b0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027b0:	a1 7c c0 11 80       	mov    0x8011c07c,%eax
801027b5:	85 c0                	test   %eax,%eax
801027b7:	0f 84 cb 00 00 00    	je     80102888 <lapicinit+0xd8>
  lapic[index] = value;
801027bd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027c4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ca:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027d1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027d7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027de:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801027e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027e4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801027eb:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801027ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027f1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801027f8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027fb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027fe:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102805:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102808:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010280b:	8b 50 30             	mov    0x30(%eax),%edx
8010280e:	c1 ea 10             	shr    $0x10,%edx
80102811:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102817:	75 77                	jne    80102890 <lapicinit+0xe0>
  lapic[index] = value;
80102819:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102820:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102823:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102826:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010282d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102830:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102833:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010283a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010283d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102840:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102847:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010284a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010284d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102854:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102857:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010285a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102861:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102864:	8b 50 20             	mov    0x20(%eax),%edx
80102867:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010286e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102870:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102876:	80 e6 10             	and    $0x10,%dh
80102879:	75 f5                	jne    80102870 <lapicinit+0xc0>
  lapic[index] = value;
8010287b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102882:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102885:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102888:	c3                   	ret
80102889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102890:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102897:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010289a:	8b 50 20             	mov    0x20(%eax),%edx
}
8010289d:	e9 77 ff ff ff       	jmp    80102819 <lapicinit+0x69>
801028a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801028b0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801028b0:	a1 7c c0 11 80       	mov    0x8011c07c,%eax
801028b5:	85 c0                	test   %eax,%eax
801028b7:	74 07                	je     801028c0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801028b9:	8b 40 20             	mov    0x20(%eax),%eax
801028bc:	c1 e8 18             	shr    $0x18,%eax
801028bf:	c3                   	ret
    return 0;
801028c0:	31 c0                	xor    %eax,%eax
}
801028c2:	c3                   	ret
801028c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801028d0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801028d0:	a1 7c c0 11 80       	mov    0x8011c07c,%eax
801028d5:	85 c0                	test   %eax,%eax
801028d7:	74 0d                	je     801028e6 <lapiceoi+0x16>
  lapic[index] = value;
801028d9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028e0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028e3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801028e6:	c3                   	ret
801028e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ee:	66 90                	xchg   %ax,%ax

801028f0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
801028f0:	c3                   	ret
801028f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ff:	90                   	nop

80102900 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102900:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102901:	b8 0f 00 00 00       	mov    $0xf,%eax
80102906:	ba 70 00 00 00       	mov    $0x70,%edx
8010290b:	89 e5                	mov    %esp,%ebp
8010290d:	53                   	push   %ebx
8010290e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102911:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102914:	ee                   	out    %al,(%dx)
80102915:	b8 0a 00 00 00       	mov    $0xa,%eax
8010291a:	ba 71 00 00 00       	mov    $0x71,%edx
8010291f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102920:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102922:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102925:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010292b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010292d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102930:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102932:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102935:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102938:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010293e:	a1 7c c0 11 80       	mov    0x8011c07c,%eax
80102943:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102949:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010294c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102953:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102956:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102959:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102960:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102963:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102966:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010296c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010296f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102975:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102978:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010297e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102981:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102987:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010298a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010298d:	c9                   	leave
8010298e:	c3                   	ret
8010298f:	90                   	nop

80102990 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102990:	55                   	push   %ebp
80102991:	b8 0b 00 00 00       	mov    $0xb,%eax
80102996:	ba 70 00 00 00       	mov    $0x70,%edx
8010299b:	89 e5                	mov    %esp,%ebp
8010299d:	57                   	push   %edi
8010299e:	56                   	push   %esi
8010299f:	53                   	push   %ebx
801029a0:	83 ec 4c             	sub    $0x4c,%esp
801029a3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029a4:	ba 71 00 00 00       	mov    $0x71,%edx
801029a9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801029aa:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029ad:	bf 70 00 00 00       	mov    $0x70,%edi
801029b2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029b5:	8d 76 00             	lea    0x0(%esi),%esi
801029b8:	31 c0                	xor    %eax,%eax
801029ba:	89 fa                	mov    %edi,%edx
801029bc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029bd:	b9 71 00 00 00       	mov    $0x71,%ecx
801029c2:	89 ca                	mov    %ecx,%edx
801029c4:	ec                   	in     (%dx),%al
801029c5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c8:	89 fa                	mov    %edi,%edx
801029ca:	b8 02 00 00 00       	mov    $0x2,%eax
801029cf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029d0:	89 ca                	mov    %ecx,%edx
801029d2:	ec                   	in     (%dx),%al
801029d3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d6:	89 fa                	mov    %edi,%edx
801029d8:	b8 04 00 00 00       	mov    $0x4,%eax
801029dd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029de:	89 ca                	mov    %ecx,%edx
801029e0:	ec                   	in     (%dx),%al
801029e1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e4:	89 fa                	mov    %edi,%edx
801029e6:	b8 07 00 00 00       	mov    $0x7,%eax
801029eb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ec:	89 ca                	mov    %ecx,%edx
801029ee:	ec                   	in     (%dx),%al
801029ef:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f2:	89 fa                	mov    %edi,%edx
801029f4:	b8 08 00 00 00       	mov    $0x8,%eax
801029f9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029fa:	89 ca                	mov    %ecx,%edx
801029fc:	ec                   	in     (%dx),%al
801029fd:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029ff:	89 fa                	mov    %edi,%edx
80102a01:	b8 09 00 00 00       	mov    $0x9,%eax
80102a06:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a07:	89 ca                	mov    %ecx,%edx
80102a09:	ec                   	in     (%dx),%al
80102a0a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a0d:	89 fa                	mov    %edi,%edx
80102a0f:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a14:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a15:	89 ca                	mov    %ecx,%edx
80102a17:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a18:	84 c0                	test   %al,%al
80102a1a:	78 9c                	js     801029b8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a1c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a20:	89 f2                	mov    %esi,%edx
80102a22:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102a25:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a28:	89 fa                	mov    %edi,%edx
80102a2a:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a2d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a31:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102a34:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a37:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a3b:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a3e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a42:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a45:	31 c0                	xor    %eax,%eax
80102a47:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a48:	89 ca                	mov    %ecx,%edx
80102a4a:	ec                   	in     (%dx),%al
80102a4b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a4e:	89 fa                	mov    %edi,%edx
80102a50:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a53:	b8 02 00 00 00       	mov    $0x2,%eax
80102a58:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a59:	89 ca                	mov    %ecx,%edx
80102a5b:	ec                   	in     (%dx),%al
80102a5c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a5f:	89 fa                	mov    %edi,%edx
80102a61:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a64:	b8 04 00 00 00       	mov    $0x4,%eax
80102a69:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a6a:	89 ca                	mov    %ecx,%edx
80102a6c:	ec                   	in     (%dx),%al
80102a6d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a70:	89 fa                	mov    %edi,%edx
80102a72:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a75:	b8 07 00 00 00       	mov    $0x7,%eax
80102a7a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a7b:	89 ca                	mov    %ecx,%edx
80102a7d:	ec                   	in     (%dx),%al
80102a7e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a81:	89 fa                	mov    %edi,%edx
80102a83:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a86:	b8 08 00 00 00       	mov    $0x8,%eax
80102a8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a8c:	89 ca                	mov    %ecx,%edx
80102a8e:	ec                   	in     (%dx),%al
80102a8f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a92:	89 fa                	mov    %edi,%edx
80102a94:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a97:	b8 09 00 00 00       	mov    $0x9,%eax
80102a9c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9d:	89 ca                	mov    %ecx,%edx
80102a9f:	ec                   	in     (%dx),%al
80102aa0:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102aa3:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102aa6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102aa9:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102aac:	6a 18                	push   $0x18
80102aae:	50                   	push   %eax
80102aaf:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ab2:	50                   	push   %eax
80102ab3:	e8 58 1f 00 00       	call   80104a10 <memcmp>
80102ab8:	83 c4 10             	add    $0x10,%esp
80102abb:	85 c0                	test   %eax,%eax
80102abd:	0f 85 f5 fe ff ff    	jne    801029b8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102ac3:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80102ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102aca:	89 f0                	mov    %esi,%eax
80102acc:	84 c0                	test   %al,%al
80102ace:	75 78                	jne    80102b48 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102ad0:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ad3:	89 c2                	mov    %eax,%edx
80102ad5:	83 e0 0f             	and    $0xf,%eax
80102ad8:	c1 ea 04             	shr    $0x4,%edx
80102adb:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ade:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ae1:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ae4:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ae7:	89 c2                	mov    %eax,%edx
80102ae9:	83 e0 0f             	and    $0xf,%eax
80102aec:	c1 ea 04             	shr    $0x4,%edx
80102aef:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102af2:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102af5:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102af8:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102afb:	89 c2                	mov    %eax,%edx
80102afd:	83 e0 0f             	and    $0xf,%eax
80102b00:	c1 ea 04             	shr    $0x4,%edx
80102b03:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b06:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b09:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b0c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b0f:	89 c2                	mov    %eax,%edx
80102b11:	83 e0 0f             	and    $0xf,%eax
80102b14:	c1 ea 04             	shr    $0x4,%edx
80102b17:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b1a:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b20:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b23:	89 c2                	mov    %eax,%edx
80102b25:	83 e0 0f             	and    $0xf,%eax
80102b28:	c1 ea 04             	shr    $0x4,%edx
80102b2b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b31:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b34:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b37:	89 c2                	mov    %eax,%edx
80102b39:	83 e0 0f             	and    $0xf,%eax
80102b3c:	c1 ea 04             	shr    $0x4,%edx
80102b3f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b42:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b45:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b48:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b4b:	89 03                	mov    %eax,(%ebx)
80102b4d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b50:	89 43 04             	mov    %eax,0x4(%ebx)
80102b53:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b56:	89 43 08             	mov    %eax,0x8(%ebx)
80102b59:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b5c:	89 43 0c             	mov    %eax,0xc(%ebx)
80102b5f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b62:	89 43 10             	mov    %eax,0x10(%ebx)
80102b65:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b68:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102b6b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102b72:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b75:	5b                   	pop    %ebx
80102b76:	5e                   	pop    %esi
80102b77:	5f                   	pop    %edi
80102b78:	5d                   	pop    %ebp
80102b79:	c3                   	ret
80102b7a:	66 90                	xchg   %ax,%ax
80102b7c:	66 90                	xchg   %ax,%ax
80102b7e:	66 90                	xchg   %ax,%ax

80102b80 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b80:	8b 0d c8 c0 11 80    	mov    0x8011c0c8,%ecx
80102b86:	85 c9                	test   %ecx,%ecx
80102b88:	0f 8e 8a 00 00 00    	jle    80102c18 <install_trans+0x98>
{
80102b8e:	55                   	push   %ebp
80102b8f:	89 e5                	mov    %esp,%ebp
80102b91:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102b92:	31 ff                	xor    %edi,%edi
{
80102b94:	56                   	push   %esi
80102b95:	53                   	push   %ebx
80102b96:	83 ec 0c             	sub    $0xc,%esp
80102b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ba0:	a1 b4 c0 11 80       	mov    0x8011c0b4,%eax
80102ba5:	83 ec 08             	sub    $0x8,%esp
80102ba8:	01 f8                	add    %edi,%eax
80102baa:	83 c0 01             	add    $0x1,%eax
80102bad:	50                   	push   %eax
80102bae:	ff 35 c4 c0 11 80    	push   0x8011c0c4
80102bb4:	e8 17 d5 ff ff       	call   801000d0 <bread>
80102bb9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bbb:	58                   	pop    %eax
80102bbc:	5a                   	pop    %edx
80102bbd:	ff 34 bd cc c0 11 80 	push   -0x7fee3f34(,%edi,4)
80102bc4:	ff 35 c4 c0 11 80    	push   0x8011c0c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102bca:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bcd:	e8 fe d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bd2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bd5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bd7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bda:	68 00 08 00 00       	push   $0x800
80102bdf:	50                   	push   %eax
80102be0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102be3:	50                   	push   %eax
80102be4:	e8 77 1e 00 00       	call   80104a60 <memmove>
    bwrite(dbuf);  // write dst to disk
80102be9:	89 1c 24             	mov    %ebx,(%esp)
80102bec:	e8 bf d5 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102bf1:	89 34 24             	mov    %esi,(%esp)
80102bf4:	e8 f7 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102bf9:	89 1c 24             	mov    %ebx,(%esp)
80102bfc:	e8 ef d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c01:	83 c4 10             	add    $0x10,%esp
80102c04:	39 3d c8 c0 11 80    	cmp    %edi,0x8011c0c8
80102c0a:	7f 94                	jg     80102ba0 <install_trans+0x20>
  }
}
80102c0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c0f:	5b                   	pop    %ebx
80102c10:	5e                   	pop    %esi
80102c11:	5f                   	pop    %edi
80102c12:	5d                   	pop    %ebp
80102c13:	c3                   	ret
80102c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c18:	c3                   	ret
80102c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c20 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c20:	55                   	push   %ebp
80102c21:	89 e5                	mov    %esp,%ebp
80102c23:	53                   	push   %ebx
80102c24:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c27:	ff 35 b4 c0 11 80    	push   0x8011c0b4
80102c2d:	ff 35 c4 c0 11 80    	push   0x8011c0c4
80102c33:	e8 98 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c38:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c3b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102c3d:	a1 c8 c0 11 80       	mov    0x8011c0c8,%eax
80102c42:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102c45:	85 c0                	test   %eax,%eax
80102c47:	7e 19                	jle    80102c62 <write_head+0x42>
80102c49:	31 d2                	xor    %edx,%edx
80102c4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c4f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102c50:	8b 0c 95 cc c0 11 80 	mov    -0x7fee3f34(,%edx,4),%ecx
80102c57:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c5b:	83 c2 01             	add    $0x1,%edx
80102c5e:	39 d0                	cmp    %edx,%eax
80102c60:	75 ee                	jne    80102c50 <write_head+0x30>
  }
  bwrite(buf);
80102c62:	83 ec 0c             	sub    $0xc,%esp
80102c65:	53                   	push   %ebx
80102c66:	e8 45 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102c6b:	89 1c 24             	mov    %ebx,(%esp)
80102c6e:	e8 7d d5 ff ff       	call   801001f0 <brelse>
}
80102c73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c76:	83 c4 10             	add    $0x10,%esp
80102c79:	c9                   	leave
80102c7a:	c3                   	ret
80102c7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c7f:	90                   	nop

80102c80 <initlog>:
{
80102c80:	55                   	push   %ebp
80102c81:	89 e5                	mov    %esp,%ebp
80102c83:	53                   	push   %ebx
80102c84:	83 ec 2c             	sub    $0x2c,%esp
80102c87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102c8a:	68 d1 78 10 80       	push   $0x801078d1
80102c8f:	68 80 c0 11 80       	push   $0x8011c080
80102c94:	e8 87 1a 00 00       	call   80104720 <initlock>
  readsb(dev, &sb);
80102c99:	58                   	pop    %eax
80102c9a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c9d:	5a                   	pop    %edx
80102c9e:	50                   	push   %eax
80102c9f:	53                   	push   %ebx
80102ca0:	e8 eb e8 ff ff       	call   80101590 <readsb>
  log.size = sb.nlog;
80102ca5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102ca8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.dev = dev;
80102cab:	89 1d c4 c0 11 80    	mov    %ebx,0x8011c0c4
  log.start = sb.logstart;
80102cb1:	a3 b4 c0 11 80       	mov    %eax,0x8011c0b4
  log.size = sb.nlog;
80102cb6:	89 15 b8 c0 11 80    	mov    %edx,0x8011c0b8
  struct buf *buf = bread(log.dev, log.start);
80102cbc:	59                   	pop    %ecx
80102cbd:	5a                   	pop    %edx
80102cbe:	50                   	push   %eax
80102cbf:	53                   	push   %ebx
80102cc0:	e8 0b d4 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102cc5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102cc8:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102ccb:	89 1d c8 c0 11 80    	mov    %ebx,0x8011c0c8
  for (i = 0; i < log.lh.n; i++) {
80102cd1:	85 db                	test   %ebx,%ebx
80102cd3:	7e 1d                	jle    80102cf2 <initlog+0x72>
80102cd5:	31 d2                	xor    %edx,%edx
80102cd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cde:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102ce0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102ce4:	89 0c 95 cc c0 11 80 	mov    %ecx,-0x7fee3f34(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102ceb:	83 c2 01             	add    $0x1,%edx
80102cee:	39 d3                	cmp    %edx,%ebx
80102cf0:	75 ee                	jne    80102ce0 <initlog+0x60>
  brelse(buf);
80102cf2:	83 ec 0c             	sub    $0xc,%esp
80102cf5:	50                   	push   %eax
80102cf6:	e8 f5 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102cfb:	e8 80 fe ff ff       	call   80102b80 <install_trans>
  log.lh.n = 0;
80102d00:	c7 05 c8 c0 11 80 00 	movl   $0x0,0x8011c0c8
80102d07:	00 00 00 
  write_head(); // clear the log
80102d0a:	e8 11 ff ff ff       	call   80102c20 <write_head>
}
80102d0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d12:	83 c4 10             	add    $0x10,%esp
80102d15:	c9                   	leave
80102d16:	c3                   	ret
80102d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d1e:	66 90                	xchg   %ax,%ax

80102d20 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d26:	68 80 c0 11 80       	push   $0x8011c080
80102d2b:	e8 10 1b 00 00       	call   80104840 <acquire>
80102d30:	83 c4 10             	add    $0x10,%esp
80102d33:	eb 18                	jmp    80102d4d <begin_op+0x2d>
80102d35:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d38:	83 ec 08             	sub    $0x8,%esp
80102d3b:	68 80 c0 11 80       	push   $0x8011c080
80102d40:	68 80 c0 11 80       	push   $0x8011c080
80102d45:	e8 e6 12 00 00       	call   80104030 <sleep>
80102d4a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d4d:	a1 c0 c0 11 80       	mov    0x8011c0c0,%eax
80102d52:	85 c0                	test   %eax,%eax
80102d54:	75 e2                	jne    80102d38 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d56:	a1 bc c0 11 80       	mov    0x8011c0bc,%eax
80102d5b:	8b 15 c8 c0 11 80    	mov    0x8011c0c8,%edx
80102d61:	83 c0 01             	add    $0x1,%eax
80102d64:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d67:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d6a:	83 fa 1e             	cmp    $0x1e,%edx
80102d6d:	7f c9                	jg     80102d38 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d6f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102d72:	a3 bc c0 11 80       	mov    %eax,0x8011c0bc
      release(&log.lock);
80102d77:	68 80 c0 11 80       	push   $0x8011c080
80102d7c:	e8 ff 1b 00 00       	call   80104980 <release>
      break;
    }
  }
}
80102d81:	83 c4 10             	add    $0x10,%esp
80102d84:	c9                   	leave
80102d85:	c3                   	ret
80102d86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d8d:	8d 76 00             	lea    0x0(%esi),%esi

80102d90 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d90:	55                   	push   %ebp
80102d91:	89 e5                	mov    %esp,%ebp
80102d93:	57                   	push   %edi
80102d94:	56                   	push   %esi
80102d95:	53                   	push   %ebx
80102d96:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d99:	68 80 c0 11 80       	push   $0x8011c080
80102d9e:	e8 9d 1a 00 00       	call   80104840 <acquire>
  log.outstanding -= 1;
80102da3:	a1 bc c0 11 80       	mov    0x8011c0bc,%eax
  if(log.committing)
80102da8:	8b 35 c0 c0 11 80    	mov    0x8011c0c0,%esi
80102dae:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102db1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102db4:	89 1d bc c0 11 80    	mov    %ebx,0x8011c0bc
  if(log.committing)
80102dba:	85 f6                	test   %esi,%esi
80102dbc:	0f 85 22 01 00 00    	jne    80102ee4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102dc2:	85 db                	test   %ebx,%ebx
80102dc4:	0f 85 f6 00 00 00    	jne    80102ec0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102dca:	c7 05 c0 c0 11 80 01 	movl   $0x1,0x8011c0c0
80102dd1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102dd4:	83 ec 0c             	sub    $0xc,%esp
80102dd7:	68 80 c0 11 80       	push   $0x8011c080
80102ddc:	e8 9f 1b 00 00       	call   80104980 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102de1:	8b 0d c8 c0 11 80    	mov    0x8011c0c8,%ecx
80102de7:	83 c4 10             	add    $0x10,%esp
80102dea:	85 c9                	test   %ecx,%ecx
80102dec:	7f 42                	jg     80102e30 <end_op+0xa0>
    acquire(&log.lock);
80102dee:	83 ec 0c             	sub    $0xc,%esp
80102df1:	68 80 c0 11 80       	push   $0x8011c080
80102df6:	e8 45 1a 00 00       	call   80104840 <acquire>
    log.committing = 0;
80102dfb:	c7 05 c0 c0 11 80 00 	movl   $0x0,0x8011c0c0
80102e02:	00 00 00 
    wakeup(&log);
80102e05:	c7 04 24 80 c0 11 80 	movl   $0x8011c080,(%esp)
80102e0c:	e8 df 12 00 00       	call   801040f0 <wakeup>
    release(&log.lock);
80102e11:	c7 04 24 80 c0 11 80 	movl   $0x8011c080,(%esp)
80102e18:	e8 63 1b 00 00       	call   80104980 <release>
80102e1d:	83 c4 10             	add    $0x10,%esp
}
80102e20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e23:	5b                   	pop    %ebx
80102e24:	5e                   	pop    %esi
80102e25:	5f                   	pop    %edi
80102e26:	5d                   	pop    %ebp
80102e27:	c3                   	ret
80102e28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e2f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e30:	a1 b4 c0 11 80       	mov    0x8011c0b4,%eax
80102e35:	83 ec 08             	sub    $0x8,%esp
80102e38:	01 d8                	add    %ebx,%eax
80102e3a:	83 c0 01             	add    $0x1,%eax
80102e3d:	50                   	push   %eax
80102e3e:	ff 35 c4 c0 11 80    	push   0x8011c0c4
80102e44:	e8 87 d2 ff ff       	call   801000d0 <bread>
80102e49:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e4b:	58                   	pop    %eax
80102e4c:	5a                   	pop    %edx
80102e4d:	ff 34 9d cc c0 11 80 	push   -0x7fee3f34(,%ebx,4)
80102e54:	ff 35 c4 c0 11 80    	push   0x8011c0c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e5a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e5d:	e8 6e d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102e62:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e65:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e67:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e6a:	68 00 08 00 00       	push   $0x800
80102e6f:	50                   	push   %eax
80102e70:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e73:	50                   	push   %eax
80102e74:	e8 e7 1b 00 00       	call   80104a60 <memmove>
    bwrite(to);  // write the log
80102e79:	89 34 24             	mov    %esi,(%esp)
80102e7c:	e8 2f d3 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102e81:	89 3c 24             	mov    %edi,(%esp)
80102e84:	e8 67 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102e89:	89 34 24             	mov    %esi,(%esp)
80102e8c:	e8 5f d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e91:	83 c4 10             	add    $0x10,%esp
80102e94:	3b 1d c8 c0 11 80    	cmp    0x8011c0c8,%ebx
80102e9a:	7c 94                	jl     80102e30 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e9c:	e8 7f fd ff ff       	call   80102c20 <write_head>
    install_trans(); // Now install writes to home locations
80102ea1:	e8 da fc ff ff       	call   80102b80 <install_trans>
    log.lh.n = 0;
80102ea6:	c7 05 c8 c0 11 80 00 	movl   $0x0,0x8011c0c8
80102ead:	00 00 00 
    write_head();    // Erase the transaction from the log
80102eb0:	e8 6b fd ff ff       	call   80102c20 <write_head>
80102eb5:	e9 34 ff ff ff       	jmp    80102dee <end_op+0x5e>
80102eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102ec0:	83 ec 0c             	sub    $0xc,%esp
80102ec3:	68 80 c0 11 80       	push   $0x8011c080
80102ec8:	e8 23 12 00 00       	call   801040f0 <wakeup>
  release(&log.lock);
80102ecd:	c7 04 24 80 c0 11 80 	movl   $0x8011c080,(%esp)
80102ed4:	e8 a7 1a 00 00       	call   80104980 <release>
80102ed9:	83 c4 10             	add    $0x10,%esp
}
80102edc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102edf:	5b                   	pop    %ebx
80102ee0:	5e                   	pop    %esi
80102ee1:	5f                   	pop    %edi
80102ee2:	5d                   	pop    %ebp
80102ee3:	c3                   	ret
    panic("log.committing");
80102ee4:	83 ec 0c             	sub    $0xc,%esp
80102ee7:	68 d5 78 10 80       	push   $0x801078d5
80102eec:	e8 8f d4 ff ff       	call   80100380 <panic>
80102ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102eff:	90                   	nop

80102f00 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	53                   	push   %ebx
80102f04:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f07:	8b 15 c8 c0 11 80    	mov    0x8011c0c8,%edx
{
80102f0d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f10:	83 fa 1d             	cmp    $0x1d,%edx
80102f13:	7f 7d                	jg     80102f92 <log_write+0x92>
80102f15:	a1 b8 c0 11 80       	mov    0x8011c0b8,%eax
80102f1a:	83 e8 01             	sub    $0x1,%eax
80102f1d:	39 c2                	cmp    %eax,%edx
80102f1f:	7d 71                	jge    80102f92 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f21:	a1 bc c0 11 80       	mov    0x8011c0bc,%eax
80102f26:	85 c0                	test   %eax,%eax
80102f28:	7e 75                	jle    80102f9f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f2a:	83 ec 0c             	sub    $0xc,%esp
80102f2d:	68 80 c0 11 80       	push   $0x8011c080
80102f32:	e8 09 19 00 00       	call   80104840 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f37:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102f3a:	83 c4 10             	add    $0x10,%esp
80102f3d:	31 c0                	xor    %eax,%eax
80102f3f:	8b 15 c8 c0 11 80    	mov    0x8011c0c8,%edx
80102f45:	85 d2                	test   %edx,%edx
80102f47:	7f 0e                	jg     80102f57 <log_write+0x57>
80102f49:	eb 15                	jmp    80102f60 <log_write+0x60>
80102f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f4f:	90                   	nop
80102f50:	83 c0 01             	add    $0x1,%eax
80102f53:	39 c2                	cmp    %eax,%edx
80102f55:	74 29                	je     80102f80 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f57:	39 0c 85 cc c0 11 80 	cmp    %ecx,-0x7fee3f34(,%eax,4)
80102f5e:	75 f0                	jne    80102f50 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102f60:	89 0c 85 cc c0 11 80 	mov    %ecx,-0x7fee3f34(,%eax,4)
  if (i == log.lh.n)
80102f67:	39 c2                	cmp    %eax,%edx
80102f69:	74 1c                	je     80102f87 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102f6b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102f6e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102f71:	c7 45 08 80 c0 11 80 	movl   $0x8011c080,0x8(%ebp)
}
80102f78:	c9                   	leave
  release(&log.lock);
80102f79:	e9 02 1a 00 00       	jmp    80104980 <release>
80102f7e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80102f80:	89 0c 95 cc c0 11 80 	mov    %ecx,-0x7fee3f34(,%edx,4)
    log.lh.n++;
80102f87:	83 c2 01             	add    $0x1,%edx
80102f8a:	89 15 c8 c0 11 80    	mov    %edx,0x8011c0c8
80102f90:	eb d9                	jmp    80102f6b <log_write+0x6b>
    panic("too big a transaction");
80102f92:	83 ec 0c             	sub    $0xc,%esp
80102f95:	68 e4 78 10 80       	push   $0x801078e4
80102f9a:	e8 e1 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80102f9f:	83 ec 0c             	sub    $0xc,%esp
80102fa2:	68 fa 78 10 80       	push   $0x801078fa
80102fa7:	e8 d4 d3 ff ff       	call   80100380 <panic>
80102fac:	66 90                	xchg   %ax,%ax
80102fae:	66 90                	xchg   %ax,%ax

80102fb0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	53                   	push   %ebx
80102fb4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102fb7:	e8 84 09 00 00       	call   80103940 <cpuid>
80102fbc:	89 c3                	mov    %eax,%ebx
80102fbe:	e8 7d 09 00 00       	call   80103940 <cpuid>
80102fc3:	83 ec 04             	sub    $0x4,%esp
80102fc6:	53                   	push   %ebx
80102fc7:	50                   	push   %eax
80102fc8:	68 15 79 10 80       	push   $0x80107915
80102fcd:	e8 de d6 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
80102fd2:	e8 f9 2d 00 00       	call   80105dd0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102fd7:	e8 04 09 00 00       	call   801038e0 <mycpu>
80102fdc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102fde:	b8 01 00 00 00       	mov    $0x1,%eax
80102fe3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102fea:	e8 21 0c 00 00       	call   80103c10 <scheduler>
80102fef:	90                   	nop

80102ff0 <mpenter>:
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ff6:	e8 e5 3e 00 00       	call   80106ee0 <switchkvm>
  seginit();
80102ffb:	e8 50 3e 00 00       	call   80106e50 <seginit>
  lapicinit();
80103000:	e8 ab f7 ff ff       	call   801027b0 <lapicinit>
  mpmain();
80103005:	e8 a6 ff ff ff       	call   80102fb0 <mpmain>
8010300a:	66 90                	xchg   %ax,%ax
8010300c:	66 90                	xchg   %ax,%ax
8010300e:	66 90                	xchg   %ax,%ax

80103010 <main>:
{
80103010:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103014:	83 e4 f0             	and    $0xfffffff0,%esp
80103017:	ff 71 fc             	push   -0x4(%ecx)
8010301a:	55                   	push   %ebp
8010301b:	89 e5                	mov    %esp,%ebp
8010301d:	53                   	push   %ebx
8010301e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010301f:	83 ec 08             	sub    $0x8,%esp
80103022:	68 00 00 40 80       	push   $0x80400000
80103027:	68 b0 00 12 80       	push   $0x801200b0
8010302c:	e8 5f f6 ff ff       	call   80102690 <kinit1>
  kvmalloc();      // kernel page table
80103031:	e8 6a 43 00 00       	call   801073a0 <kvmalloc>
  mpinit();        // detect other processors
80103036:	e8 85 01 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
8010303b:	e8 70 f7 ff ff       	call   801027b0 <lapicinit>
  seginit();       // segment descriptors
80103040:	e8 0b 3e 00 00       	call   80106e50 <seginit>
  picinit();       // disable pic
80103045:	e8 86 03 00 00       	call   801033d0 <picinit>
  ioapicinit();    // another interrupt controller
8010304a:	e8 11 f4 ff ff       	call   80102460 <ioapicinit>
  consoleinit();   // console hardware
8010304f:	e8 3c da ff ff       	call   80100a90 <consoleinit>
  uartinit();      // serial port
80103054:	e8 67 30 00 00       	call   801060c0 <uartinit>
  pinit();         // process table
80103059:	e8 62 08 00 00       	call   801038c0 <pinit>
  tvinit();        // trap vectors
8010305e:	e8 ed 2c 00 00       	call   80105d50 <tvinit>
  binit();         // buffer cache
80103063:	e8 d8 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103068:	e8 f3 dd ff ff       	call   80100e60 <fileinit>
  ideinit();       // disk 
8010306d:	e8 ce f1 ff ff       	call   80102240 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103072:	83 c4 0c             	add    $0xc,%esp
80103075:	68 8a 00 00 00       	push   $0x8a
8010307a:	68 8c 94 10 80       	push   $0x8010948c
8010307f:	68 00 70 00 80       	push   $0x80007000
80103084:	e8 d7 19 00 00       	call   80104a60 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103089:	83 c4 10             	add    $0x10,%esp
8010308c:	69 05 64 c1 11 80 b0 	imul   $0xb0,0x8011c164,%eax
80103093:	00 00 00 
80103096:	05 80 c1 11 80       	add    $0x8011c180,%eax
8010309b:	3d 80 c1 11 80       	cmp    $0x8011c180,%eax
801030a0:	76 7e                	jbe    80103120 <main+0x110>
801030a2:	bb 80 c1 11 80       	mov    $0x8011c180,%ebx
801030a7:	eb 20                	jmp    801030c9 <main+0xb9>
801030a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030b0:	69 05 64 c1 11 80 b0 	imul   $0xb0,0x8011c164,%eax
801030b7:	00 00 00 
801030ba:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801030c0:	05 80 c1 11 80       	add    $0x8011c180,%eax
801030c5:	39 c3                	cmp    %eax,%ebx
801030c7:	73 57                	jae    80103120 <main+0x110>
    if(c == mycpu())  // We've started already.
801030c9:	e8 12 08 00 00       	call   801038e0 <mycpu>
801030ce:	39 c3                	cmp    %eax,%ebx
801030d0:	74 de                	je     801030b0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801030d2:	e8 29 f6 ff ff       	call   80102700 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801030d7:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-8) = mpenter;
801030da:	c7 05 f8 6f 00 80 f0 	movl   $0x80102ff0,0x80006ff8
801030e1:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801030e4:	c7 05 f4 6f 00 80 00 	movl   $0x108000,0x80006ff4
801030eb:	80 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801030ee:	05 00 10 00 00       	add    $0x1000,%eax
801030f3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801030f8:	0f b6 03             	movzbl (%ebx),%eax
801030fb:	68 00 70 00 00       	push   $0x7000
80103100:	50                   	push   %eax
80103101:	e8 fa f7 ff ff       	call   80102900 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103106:	83 c4 10             	add    $0x10,%esp
80103109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103110:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103116:	85 c0                	test   %eax,%eax
80103118:	74 f6                	je     80103110 <main+0x100>
8010311a:	eb 94                	jmp    801030b0 <main+0xa0>
8010311c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103120:	83 ec 08             	sub    $0x8,%esp
80103123:	68 00 00 00 8e       	push   $0x8e000000
80103128:	68 00 00 40 80       	push   $0x80400000
8010312d:	e8 fe f4 ff ff       	call   80102630 <kinit2>
  userinit();      // first user process
80103132:	e8 59 08 00 00       	call   80103990 <userinit>
  mpmain();        // finish this processor's setup
80103137:	e8 74 fe ff ff       	call   80102fb0 <mpmain>
8010313c:	66 90                	xchg   %ax,%ax
8010313e:	66 90                	xchg   %ax,%ax

80103140 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103140:	55                   	push   %ebp
80103141:	89 e5                	mov    %esp,%ebp
80103143:	57                   	push   %edi
80103144:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103145:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010314b:	53                   	push   %ebx
  e = addr+len;
8010314c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010314f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103152:	39 de                	cmp    %ebx,%esi
80103154:	72 10                	jb     80103166 <mpsearch1+0x26>
80103156:	eb 50                	jmp    801031a8 <mpsearch1+0x68>
80103158:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010315f:	90                   	nop
80103160:	89 fe                	mov    %edi,%esi
80103162:	39 df                	cmp    %ebx,%edi
80103164:	73 42                	jae    801031a8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103166:	83 ec 04             	sub    $0x4,%esp
80103169:	8d 7e 10             	lea    0x10(%esi),%edi
8010316c:	6a 04                	push   $0x4
8010316e:	68 29 79 10 80       	push   $0x80107929
80103173:	56                   	push   %esi
80103174:	e8 97 18 00 00       	call   80104a10 <memcmp>
80103179:	83 c4 10             	add    $0x10,%esp
8010317c:	85 c0                	test   %eax,%eax
8010317e:	75 e0                	jne    80103160 <mpsearch1+0x20>
80103180:	89 f2                	mov    %esi,%edx
80103182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103188:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
8010318b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010318e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103190:	39 fa                	cmp    %edi,%edx
80103192:	75 f4                	jne    80103188 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103194:	84 c0                	test   %al,%al
80103196:	75 c8                	jne    80103160 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103198:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010319b:	89 f0                	mov    %esi,%eax
8010319d:	5b                   	pop    %ebx
8010319e:	5e                   	pop    %esi
8010319f:	5f                   	pop    %edi
801031a0:	5d                   	pop    %ebp
801031a1:	c3                   	ret
801031a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801031ab:	31 f6                	xor    %esi,%esi
}
801031ad:	5b                   	pop    %ebx
801031ae:	89 f0                	mov    %esi,%eax
801031b0:	5e                   	pop    %esi
801031b1:	5f                   	pop    %edi
801031b2:	5d                   	pop    %ebp
801031b3:	c3                   	ret
801031b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031bf:	90                   	nop

801031c0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	57                   	push   %edi
801031c4:	56                   	push   %esi
801031c5:	53                   	push   %ebx
801031c6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031c9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031d0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031d7:	c1 e0 08             	shl    $0x8,%eax
801031da:	09 d0                	or     %edx,%eax
801031dc:	c1 e0 04             	shl    $0x4,%eax
801031df:	75 1b                	jne    801031fc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801031e1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031e8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031ef:	c1 e0 08             	shl    $0x8,%eax
801031f2:	09 d0                	or     %edx,%eax
801031f4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801031f7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801031fc:	ba 00 04 00 00       	mov    $0x400,%edx
80103201:	e8 3a ff ff ff       	call   80103140 <mpsearch1>
80103206:	89 c3                	mov    %eax,%ebx
80103208:	85 c0                	test   %eax,%eax
8010320a:	0f 84 50 01 00 00    	je     80103360 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103210:	8b 73 04             	mov    0x4(%ebx),%esi
80103213:	85 f6                	test   %esi,%esi
80103215:	0f 84 35 01 00 00    	je     80103350 <mpinit+0x190>
  if(memcmp(conf, "PCMP", 4) != 0)
8010321b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010321e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103224:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103227:	6a 04                	push   $0x4
80103229:	68 2e 79 10 80       	push   $0x8010792e
8010322e:	50                   	push   %eax
8010322f:	e8 dc 17 00 00       	call   80104a10 <memcmp>
80103234:	83 c4 10             	add    $0x10,%esp
80103237:	85 c0                	test   %eax,%eax
80103239:	0f 85 11 01 00 00    	jne    80103350 <mpinit+0x190>
  if(conf->version != 1 && conf->version != 4)
8010323f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103246:	3c 01                	cmp    $0x1,%al
80103248:	74 08                	je     80103252 <mpinit+0x92>
8010324a:	3c 04                	cmp    $0x4,%al
8010324c:	0f 85 fe 00 00 00    	jne    80103350 <mpinit+0x190>
  if(sum((uchar*)conf, conf->length) != 0)
80103252:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103259:	66 85 d2             	test   %dx,%dx
8010325c:	74 22                	je     80103280 <mpinit+0xc0>
8010325e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103261:	89 f0                	mov    %esi,%eax
  sum = 0;
80103263:	31 d2                	xor    %edx,%edx
80103265:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103268:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010326f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103272:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103274:	39 c7                	cmp    %eax,%edi
80103276:	75 f0                	jne    80103268 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103278:	84 d2                	test   %dl,%dl
8010327a:	0f 85 d0 00 00 00    	jne    80103350 <mpinit+0x190>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103280:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103286:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103289:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
8010328c:	a3 7c c0 11 80       	mov    %eax,0x8011c07c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103291:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103298:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
8010329e:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032a3:	01 d7                	add    %edx,%edi
801032a5:	89 fa                	mov    %edi,%edx
801032a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032ae:	66 90                	xchg   %ax,%ax
801032b0:	39 d0                	cmp    %edx,%eax
801032b2:	73 15                	jae    801032c9 <mpinit+0x109>
    switch(*p){
801032b4:	0f b6 08             	movzbl (%eax),%ecx
801032b7:	80 f9 02             	cmp    $0x2,%cl
801032ba:	74 54                	je     80103310 <mpinit+0x150>
801032bc:	77 42                	ja     80103300 <mpinit+0x140>
801032be:	84 c9                	test   %cl,%cl
801032c0:	74 5e                	je     80103320 <mpinit+0x160>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032c2:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032c5:	39 d0                	cmp    %edx,%eax
801032c7:	72 eb                	jb     801032b4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032c9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801032cc:	85 f6                	test   %esi,%esi
801032ce:	0f 84 e1 00 00 00    	je     801033b5 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032d4:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801032d8:	74 15                	je     801032ef <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032da:	b8 70 00 00 00       	mov    $0x70,%eax
801032df:	ba 22 00 00 00       	mov    $0x22,%edx
801032e4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032e5:	ba 23 00 00 00       	mov    $0x23,%edx
801032ea:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801032eb:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032ee:	ee                   	out    %al,(%dx)
  }
}
801032ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032f2:	5b                   	pop    %ebx
801032f3:	5e                   	pop    %esi
801032f4:	5f                   	pop    %edi
801032f5:	5d                   	pop    %ebp
801032f6:	c3                   	ret
801032f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032fe:	66 90                	xchg   %ax,%ax
    switch(*p){
80103300:	83 e9 03             	sub    $0x3,%ecx
80103303:	80 f9 01             	cmp    $0x1,%cl
80103306:	76 ba                	jbe    801032c2 <mpinit+0x102>
80103308:	31 f6                	xor    %esi,%esi
8010330a:	eb a4                	jmp    801032b0 <mpinit+0xf0>
8010330c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103310:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103314:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103317:	88 0d 60 c1 11 80    	mov    %cl,0x8011c160
      continue;
8010331d:	eb 91                	jmp    801032b0 <mpinit+0xf0>
8010331f:	90                   	nop
      if(ncpu < NCPU) {
80103320:	8b 0d 64 c1 11 80    	mov    0x8011c164,%ecx
80103326:	83 f9 07             	cmp    $0x7,%ecx
80103329:	7f 19                	jg     80103344 <mpinit+0x184>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010332b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103331:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103335:	83 c1 01             	add    $0x1,%ecx
80103338:	89 0d 64 c1 11 80    	mov    %ecx,0x8011c164
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010333e:	88 9f 80 c1 11 80    	mov    %bl,-0x7fee3e80(%edi)
      p += sizeof(struct mpproc);
80103344:	83 c0 14             	add    $0x14,%eax
      continue;
80103347:	e9 64 ff ff ff       	jmp    801032b0 <mpinit+0xf0>
8010334c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103350:	83 ec 0c             	sub    $0xc,%esp
80103353:	68 33 79 10 80       	push   $0x80107933
80103358:	e8 23 d0 ff ff       	call   80100380 <panic>
8010335d:	8d 76 00             	lea    0x0(%esi),%esi
{
80103360:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103365:	eb 13                	jmp    8010337a <mpinit+0x1ba>
80103367:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010336e:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80103370:	89 f3                	mov    %esi,%ebx
80103372:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103378:	74 d6                	je     80103350 <mpinit+0x190>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010337a:	83 ec 04             	sub    $0x4,%esp
8010337d:	8d 73 10             	lea    0x10(%ebx),%esi
80103380:	6a 04                	push   $0x4
80103382:	68 29 79 10 80       	push   $0x80107929
80103387:	53                   	push   %ebx
80103388:	e8 83 16 00 00       	call   80104a10 <memcmp>
8010338d:	83 c4 10             	add    $0x10,%esp
80103390:	85 c0                	test   %eax,%eax
80103392:	75 dc                	jne    80103370 <mpinit+0x1b0>
80103394:	89 da                	mov    %ebx,%edx
80103396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010339d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801033a0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801033a3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801033a6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801033a8:	39 f2                	cmp    %esi,%edx
801033aa:	75 f4                	jne    801033a0 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033ac:	84 c0                	test   %al,%al
801033ae:	75 c0                	jne    80103370 <mpinit+0x1b0>
801033b0:	e9 5b fe ff ff       	jmp    80103210 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801033b5:	83 ec 0c             	sub    $0xc,%esp
801033b8:	68 4c 79 10 80       	push   $0x8010794c
801033bd:	e8 be cf ff ff       	call   80100380 <panic>
801033c2:	66 90                	xchg   %ax,%ax
801033c4:	66 90                	xchg   %ax,%ax
801033c6:	66 90                	xchg   %ax,%ax
801033c8:	66 90                	xchg   %ax,%ax
801033ca:	66 90                	xchg   %ax,%ax
801033cc:	66 90                	xchg   %ax,%ax
801033ce:	66 90                	xchg   %ax,%ax

801033d0 <picinit>:
801033d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801033d5:	ba 21 00 00 00       	mov    $0x21,%edx
801033da:	ee                   	out    %al,(%dx)
801033db:	ba a1 00 00 00       	mov    $0xa1,%edx
801033e0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801033e1:	c3                   	ret
801033e2:	66 90                	xchg   %ax,%ax
801033e4:	66 90                	xchg   %ax,%ax
801033e6:	66 90                	xchg   %ax,%ax
801033e8:	66 90                	xchg   %ax,%ax
801033ea:	66 90                	xchg   %ax,%ax
801033ec:	66 90                	xchg   %ax,%ax
801033ee:	66 90                	xchg   %ax,%ax

801033f0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033f0:	55                   	push   %ebp
801033f1:	89 e5                	mov    %esp,%ebp
801033f3:	57                   	push   %edi
801033f4:	56                   	push   %esi
801033f5:	53                   	push   %ebx
801033f6:	83 ec 0c             	sub    $0xc,%esp
801033f9:	8b 75 08             	mov    0x8(%ebp),%esi
801033fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033ff:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103405:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010340b:	e8 70 da ff ff       	call   80100e80 <filealloc>
80103410:	89 06                	mov    %eax,(%esi)
80103412:	85 c0                	test   %eax,%eax
80103414:	0f 84 a5 00 00 00    	je     801034bf <pipealloc+0xcf>
8010341a:	e8 61 da ff ff       	call   80100e80 <filealloc>
8010341f:	89 07                	mov    %eax,(%edi)
80103421:	85 c0                	test   %eax,%eax
80103423:	0f 84 84 00 00 00    	je     801034ad <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103429:	e8 d2 f2 ff ff       	call   80102700 <kalloc>
8010342e:	89 c3                	mov    %eax,%ebx
80103430:	85 c0                	test   %eax,%eax
80103432:	0f 84 a0 00 00 00    	je     801034d8 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80103438:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010343f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103442:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103445:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010344c:	00 00 00 
  p->nwrite = 0;
8010344f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103456:	00 00 00 
  p->nread = 0;
80103459:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103460:	00 00 00 
  initlock(&p->lock, "pipe");
80103463:	68 6b 79 10 80       	push   $0x8010796b
80103468:	50                   	push   %eax
80103469:	e8 b2 12 00 00       	call   80104720 <initlock>
  (*f0)->type = FD_PIPE;
8010346e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103470:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103473:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103479:	8b 06                	mov    (%esi),%eax
8010347b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010347f:	8b 06                	mov    (%esi),%eax
80103481:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103485:	8b 06                	mov    (%esi),%eax
80103487:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010348a:	8b 07                	mov    (%edi),%eax
8010348c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103492:	8b 07                	mov    (%edi),%eax
80103494:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103498:	8b 07                	mov    (%edi),%eax
8010349a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010349e:	8b 07                	mov    (%edi),%eax
801034a0:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
801034a3:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034a8:	5b                   	pop    %ebx
801034a9:	5e                   	pop    %esi
801034aa:	5f                   	pop    %edi
801034ab:	5d                   	pop    %ebp
801034ac:	c3                   	ret
  if(*f0)
801034ad:	8b 06                	mov    (%esi),%eax
801034af:	85 c0                	test   %eax,%eax
801034b1:	74 1e                	je     801034d1 <pipealloc+0xe1>
    fileclose(*f0);
801034b3:	83 ec 0c             	sub    $0xc,%esp
801034b6:	50                   	push   %eax
801034b7:	e8 84 da ff ff       	call   80100f40 <fileclose>
801034bc:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801034bf:	8b 07                	mov    (%edi),%eax
801034c1:	85 c0                	test   %eax,%eax
801034c3:	74 0c                	je     801034d1 <pipealloc+0xe1>
    fileclose(*f1);
801034c5:	83 ec 0c             	sub    $0xc,%esp
801034c8:	50                   	push   %eax
801034c9:	e8 72 da ff ff       	call   80100f40 <fileclose>
801034ce:	83 c4 10             	add    $0x10,%esp
  return -1;
801034d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801034d6:	eb cd                	jmp    801034a5 <pipealloc+0xb5>
  if(*f0)
801034d8:	8b 06                	mov    (%esi),%eax
801034da:	85 c0                	test   %eax,%eax
801034dc:	75 d5                	jne    801034b3 <pipealloc+0xc3>
801034de:	eb df                	jmp    801034bf <pipealloc+0xcf>

801034e0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801034e0:	55                   	push   %ebp
801034e1:	89 e5                	mov    %esp,%ebp
801034e3:	56                   	push   %esi
801034e4:	53                   	push   %ebx
801034e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034eb:	83 ec 0c             	sub    $0xc,%esp
801034ee:	53                   	push   %ebx
801034ef:	e8 4c 13 00 00       	call   80104840 <acquire>
  if(writable){
801034f4:	83 c4 10             	add    $0x10,%esp
801034f7:	85 f6                	test   %esi,%esi
801034f9:	74 65                	je     80103560 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801034fb:	83 ec 0c             	sub    $0xc,%esp
801034fe:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103504:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010350b:	00 00 00 
    wakeup(&p->nread);
8010350e:	50                   	push   %eax
8010350f:	e8 dc 0b 00 00       	call   801040f0 <wakeup>
80103514:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103517:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010351d:	85 d2                	test   %edx,%edx
8010351f:	75 0a                	jne    8010352b <pipeclose+0x4b>
80103521:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103527:	85 c0                	test   %eax,%eax
80103529:	74 15                	je     80103540 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010352b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010352e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103531:	5b                   	pop    %ebx
80103532:	5e                   	pop    %esi
80103533:	5d                   	pop    %ebp
    release(&p->lock);
80103534:	e9 47 14 00 00       	jmp    80104980 <release>
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103540:	83 ec 0c             	sub    $0xc,%esp
80103543:	53                   	push   %ebx
80103544:	e8 37 14 00 00       	call   80104980 <release>
    kfree((char*)p);
80103549:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010354c:	83 c4 10             	add    $0x10,%esp
}
8010354f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103552:	5b                   	pop    %ebx
80103553:	5e                   	pop    %esi
80103554:	5d                   	pop    %ebp
    kfree((char*)p);
80103555:	e9 e6 ef ff ff       	jmp    80102540 <kfree>
8010355a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103560:	83 ec 0c             	sub    $0xc,%esp
80103563:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103569:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103570:	00 00 00 
    wakeup(&p->nwrite);
80103573:	50                   	push   %eax
80103574:	e8 77 0b 00 00       	call   801040f0 <wakeup>
80103579:	83 c4 10             	add    $0x10,%esp
8010357c:	eb 99                	jmp    80103517 <pipeclose+0x37>
8010357e:	66 90                	xchg   %ax,%ax

80103580 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103580:	55                   	push   %ebp
80103581:	89 e5                	mov    %esp,%ebp
80103583:	57                   	push   %edi
80103584:	56                   	push   %esi
80103585:	53                   	push   %ebx
80103586:	83 ec 28             	sub    $0x28,%esp
80103589:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010358c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010358f:	53                   	push   %ebx
80103590:	e8 ab 12 00 00       	call   80104840 <acquire>
  for(i = 0; i < n; i++){
80103595:	83 c4 10             	add    $0x10,%esp
80103598:	85 ff                	test   %edi,%edi
8010359a:	0f 8e ce 00 00 00    	jle    8010366e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035a0:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801035a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801035a9:	89 7d 10             	mov    %edi,0x10(%ebp)
801035ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801035af:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801035b2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035b5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035bb:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c1:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035c7:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801035cd:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801035d0:	0f 85 b6 00 00 00    	jne    8010368c <pipewrite+0x10c>
801035d6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801035d9:	eb 3b                	jmp    80103616 <pipewrite+0x96>
801035db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035df:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
801035e0:	e8 7b 03 00 00       	call   80103960 <myproc>
801035e5:	8b 48 24             	mov    0x24(%eax),%ecx
801035e8:	85 c9                	test   %ecx,%ecx
801035ea:	75 34                	jne    80103620 <pipewrite+0xa0>
      wakeup(&p->nread);
801035ec:	83 ec 0c             	sub    $0xc,%esp
801035ef:	56                   	push   %esi
801035f0:	e8 fb 0a 00 00       	call   801040f0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035f5:	58                   	pop    %eax
801035f6:	5a                   	pop    %edx
801035f7:	53                   	push   %ebx
801035f8:	57                   	push   %edi
801035f9:	e8 32 0a 00 00       	call   80104030 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035fe:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103604:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010360a:	83 c4 10             	add    $0x10,%esp
8010360d:	05 00 02 00 00       	add    $0x200,%eax
80103612:	39 c2                	cmp    %eax,%edx
80103614:	75 2a                	jne    80103640 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103616:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010361c:	85 c0                	test   %eax,%eax
8010361e:	75 c0                	jne    801035e0 <pipewrite+0x60>
        release(&p->lock);
80103620:	83 ec 0c             	sub    $0xc,%esp
80103623:	53                   	push   %ebx
80103624:	e8 57 13 00 00       	call   80104980 <release>
        return -1;
80103629:	83 c4 10             	add    $0x10,%esp
8010362c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103631:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103634:	5b                   	pop    %ebx
80103635:	5e                   	pop    %esi
80103636:	5f                   	pop    %edi
80103637:	5d                   	pop    %ebp
80103638:	c3                   	ret
80103639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103640:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103643:	8d 42 01             	lea    0x1(%edx),%eax
80103646:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010364c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010364f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103655:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103658:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010365c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103660:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103663:	39 c1                	cmp    %eax,%ecx
80103665:	0f 85 50 ff ff ff    	jne    801035bb <pipewrite+0x3b>
8010366b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010366e:	83 ec 0c             	sub    $0xc,%esp
80103671:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103677:	50                   	push   %eax
80103678:	e8 73 0a 00 00       	call   801040f0 <wakeup>
  release(&p->lock);
8010367d:	89 1c 24             	mov    %ebx,(%esp)
80103680:	e8 fb 12 00 00       	call   80104980 <release>
  return n;
80103685:	83 c4 10             	add    $0x10,%esp
80103688:	89 f8                	mov    %edi,%eax
8010368a:	eb a5                	jmp    80103631 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010368c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010368f:	eb b2                	jmp    80103643 <pipewrite+0xc3>
80103691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103698:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010369f:	90                   	nop

801036a0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801036a0:	55                   	push   %ebp
801036a1:	89 e5                	mov    %esp,%ebp
801036a3:	57                   	push   %edi
801036a4:	56                   	push   %esi
801036a5:	53                   	push   %ebx
801036a6:	83 ec 18             	sub    $0x18,%esp
801036a9:	8b 75 08             	mov    0x8(%ebp),%esi
801036ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036af:	56                   	push   %esi
801036b0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036b6:	e8 85 11 00 00       	call   80104840 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036bb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801036c1:	83 c4 10             	add    $0x10,%esp
801036c4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801036ca:	74 2f                	je     801036fb <piperead+0x5b>
801036cc:	eb 37                	jmp    80103705 <piperead+0x65>
801036ce:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801036d0:	e8 8b 02 00 00       	call   80103960 <myproc>
801036d5:	8b 48 24             	mov    0x24(%eax),%ecx
801036d8:	85 c9                	test   %ecx,%ecx
801036da:	0f 85 80 00 00 00    	jne    80103760 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036e0:	83 ec 08             	sub    $0x8,%esp
801036e3:	56                   	push   %esi
801036e4:	53                   	push   %ebx
801036e5:	e8 46 09 00 00       	call   80104030 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036ea:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
801036f0:	83 c4 10             	add    $0x10,%esp
801036f3:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
801036f9:	75 0a                	jne    80103705 <piperead+0x65>
801036fb:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103701:	85 c0                	test   %eax,%eax
80103703:	75 cb                	jne    801036d0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103705:	8b 55 10             	mov    0x10(%ebp),%edx
80103708:	31 db                	xor    %ebx,%ebx
8010370a:	85 d2                	test   %edx,%edx
8010370c:	7f 20                	jg     8010372e <piperead+0x8e>
8010370e:	eb 2c                	jmp    8010373c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103710:	8d 48 01             	lea    0x1(%eax),%ecx
80103713:	25 ff 01 00 00       	and    $0x1ff,%eax
80103718:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010371e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103723:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103726:	83 c3 01             	add    $0x1,%ebx
80103729:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010372c:	74 0e                	je     8010373c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010372e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103734:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010373a:	75 d4                	jne    80103710 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010373c:	83 ec 0c             	sub    $0xc,%esp
8010373f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103745:	50                   	push   %eax
80103746:	e8 a5 09 00 00       	call   801040f0 <wakeup>
  release(&p->lock);
8010374b:	89 34 24             	mov    %esi,(%esp)
8010374e:	e8 2d 12 00 00       	call   80104980 <release>
  return i;
80103753:	83 c4 10             	add    $0x10,%esp
}
80103756:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103759:	89 d8                	mov    %ebx,%eax
8010375b:	5b                   	pop    %ebx
8010375c:	5e                   	pop    %esi
8010375d:	5f                   	pop    %edi
8010375e:	5d                   	pop    %ebp
8010375f:	c3                   	ret
      release(&p->lock);
80103760:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103763:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103768:	56                   	push   %esi
80103769:	e8 12 12 00 00       	call   80104980 <release>
      return -1;
8010376e:	83 c4 10             	add    $0x10,%esp
}
80103771:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103774:	89 d8                	mov    %ebx,%eax
80103776:	5b                   	pop    %ebx
80103777:	5e                   	pop    %esi
80103778:	5f                   	pop    %edi
80103779:	5d                   	pop    %ebp
8010377a:	c3                   	ret
8010377b:	66 90                	xchg   %ax,%ax
8010377d:	66 90                	xchg   %ax,%ax
8010377f:	90                   	nop

80103780 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103780:	55                   	push   %ebp
80103781:	89 e5                	mov    %esp,%ebp
80103783:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103784:	bb 34 c7 11 80       	mov    $0x8011c734,%ebx
{
80103789:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010378c:	68 00 c7 11 80       	push   $0x8011c700
80103791:	e8 aa 10 00 00       	call   80104840 <acquire>
80103796:	83 c4 10             	add    $0x10,%esp
80103799:	eb 17                	jmp    801037b2 <allocproc+0x32>
8010379b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010379f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037a0:	81 c3 84 00 00 00    	add    $0x84,%ebx
801037a6:	81 fb 34 e8 11 80    	cmp    $0x8011e834,%ebx
801037ac:	0f 84 8e 00 00 00    	je     80103840 <allocproc+0xc0>
    if(p->state == UNUSED)
801037b2:	8b 43 0c             	mov    0xc(%ebx),%eax
801037b5:	85 c0                	test   %eax,%eax
801037b7:	75 e7                	jne    801037a0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037b9:	a1 04 90 10 80       	mov    0x80109004,%eax
  p->priority = 10;
  p->sigmask = 0;
  release(&ptable.lock);
801037be:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037c1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->priority = 10;
801037c8:	c7 43 7c 0a 00 00 00 	movl   $0xa,0x7c(%ebx)
  p->pid = nextpid++;
801037cf:	8d 50 01             	lea    0x1(%eax),%edx
801037d2:	89 43 10             	mov    %eax,0x10(%ebx)
801037d5:	89 15 04 90 10 80    	mov    %edx,0x80109004
  p->sigmask = 0;
801037db:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
801037e2:	00 00 00 
  release(&ptable.lock);
801037e5:	68 00 c7 11 80       	push   $0x8011c700
801037ea:	e8 91 11 00 00       	call   80104980 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037ef:	e8 0c ef ff ff       	call   80102700 <kalloc>
801037f4:	83 c4 10             	add    $0x10,%esp
801037f7:	89 43 08             	mov    %eax,0x8(%ebx)
801037fa:	85 c0                	test   %eax,%eax
801037fc:	74 5b                	je     80103859 <allocproc+0xd9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037fe:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103804:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103807:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010380c:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010380f:	c7 40 14 3f 5d 10 80 	movl   $0x80105d3f,0x14(%eax)
  p->context = (struct context*)sp;
80103816:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103819:	6a 14                	push   $0x14
8010381b:	6a 00                	push   $0x0
8010381d:	50                   	push   %eax
8010381e:	e8 ad 11 00 00       	call   801049d0 <memset>
  p->context->eip = (uint)forkret;
80103823:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103826:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103829:	c7 40 10 70 38 10 80 	movl   $0x80103870,0x10(%eax)
}
80103830:	89 d8                	mov    %ebx,%eax
80103832:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103835:	c9                   	leave
80103836:	c3                   	ret
80103837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010383e:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
80103840:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103843:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103845:	68 00 c7 11 80       	push   $0x8011c700
8010384a:	e8 31 11 00 00       	call   80104980 <release>
  return 0;
8010384f:	83 c4 10             	add    $0x10,%esp
}
80103852:	89 d8                	mov    %ebx,%eax
80103854:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103857:	c9                   	leave
80103858:	c3                   	ret
    p->state = UNUSED;
80103859:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103860:	31 db                	xor    %ebx,%ebx
80103862:	eb ee                	jmp    80103852 <allocproc+0xd2>
80103864:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010386b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010386f:	90                   	nop

80103870 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103876:	68 00 c7 11 80       	push   $0x8011c700
8010387b:	e8 00 11 00 00       	call   80104980 <release>

  if (first) {
80103880:	a1 00 90 10 80       	mov    0x80109000,%eax
80103885:	83 c4 10             	add    $0x10,%esp
80103888:	85 c0                	test   %eax,%eax
8010388a:	75 04                	jne    80103890 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010388c:	c9                   	leave
8010388d:	c3                   	ret
8010388e:	66 90                	xchg   %ax,%ax
    first = 0;
80103890:	c7 05 00 90 10 80 00 	movl   $0x0,0x80109000
80103897:	00 00 00 
    iinit(ROOTDEV);
8010389a:	83 ec 0c             	sub    $0xc,%esp
8010389d:	6a 01                	push   $0x1
8010389f:	e8 2c dd ff ff       	call   801015d0 <iinit>
    initlog(ROOTDEV);
801038a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801038ab:	e8 d0 f3 ff ff       	call   80102c80 <initlog>
}
801038b0:	83 c4 10             	add    $0x10,%esp
801038b3:	c9                   	leave
801038b4:	c3                   	ret
801038b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038c0 <pinit>:
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801038c6:	68 70 79 10 80       	push   $0x80107970
801038cb:	68 00 c7 11 80       	push   $0x8011c700
801038d0:	e8 4b 0e 00 00       	call   80104720 <initlock>
}
801038d5:	83 c4 10             	add    $0x10,%esp
801038d8:	c9                   	leave
801038d9:	c3                   	ret
801038da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038e0 <mycpu>:
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	56                   	push   %esi
801038e4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038e5:	9c                   	pushf
801038e6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801038e7:	f6 c4 02             	test   $0x2,%ah
801038ea:	75 46                	jne    80103932 <mycpu+0x52>
  apicid = lapicid();
801038ec:	e8 bf ef ff ff       	call   801028b0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801038f1:	8b 35 64 c1 11 80    	mov    0x8011c164,%esi
801038f7:	85 f6                	test   %esi,%esi
801038f9:	7e 2a                	jle    80103925 <mycpu+0x45>
801038fb:	31 d2                	xor    %edx,%edx
801038fd:	eb 08                	jmp    80103907 <mycpu+0x27>
801038ff:	90                   	nop
80103900:	83 c2 01             	add    $0x1,%edx
80103903:	39 f2                	cmp    %esi,%edx
80103905:	74 1e                	je     80103925 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103907:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010390d:	0f b6 99 80 c1 11 80 	movzbl -0x7fee3e80(%ecx),%ebx
80103914:	39 c3                	cmp    %eax,%ebx
80103916:	75 e8                	jne    80103900 <mycpu+0x20>
}
80103918:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010391b:	8d 81 80 c1 11 80    	lea    -0x7fee3e80(%ecx),%eax
}
80103921:	5b                   	pop    %ebx
80103922:	5e                   	pop    %esi
80103923:	5d                   	pop    %ebp
80103924:	c3                   	ret
  panic("unknown apicid\n");
80103925:	83 ec 0c             	sub    $0xc,%esp
80103928:	68 77 79 10 80       	push   $0x80107977
8010392d:	e8 4e ca ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103932:	83 ec 0c             	sub    $0xc,%esp
80103935:	68 ac 7a 10 80       	push   $0x80107aac
8010393a:	e8 41 ca ff ff       	call   80100380 <panic>
8010393f:	90                   	nop

80103940 <cpuid>:
cpuid() {
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103946:	e8 95 ff ff ff       	call   801038e0 <mycpu>
}
8010394b:	c9                   	leave
  return mycpu()-cpus;
8010394c:	2d 80 c1 11 80       	sub    $0x8011c180,%eax
80103951:	c1 f8 04             	sar    $0x4,%eax
80103954:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010395a:	c3                   	ret
8010395b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010395f:	90                   	nop

80103960 <myproc>:
myproc(void) {
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	53                   	push   %ebx
80103964:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103967:	e8 84 0e 00 00       	call   801047f0 <pushcli>
  c = mycpu();
8010396c:	e8 6f ff ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103971:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103977:	e8 a4 0f 00 00       	call   80104920 <popcli>
}
8010397c:	89 d8                	mov    %ebx,%eax
8010397e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103981:	c9                   	leave
80103982:	c3                   	ret
80103983:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010398a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103990 <userinit>:
{
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	53                   	push   %ebx
80103994:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103997:	e8 e4 fd ff ff       	call   80103780 <allocproc>
8010399c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010399e:	a3 34 e8 11 80       	mov    %eax,0x8011e834
  if((p->pgdir = setupkvm()) == 0)
801039a3:	e8 78 39 00 00       	call   80107320 <setupkvm>
801039a8:	89 43 04             	mov    %eax,0x4(%ebx)
801039ab:	85 c0                	test   %eax,%eax
801039ad:	0f 84 bd 00 00 00    	je     80103a70 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039b3:	83 ec 04             	sub    $0x4,%esp
801039b6:	68 2c 00 00 00       	push   $0x2c
801039bb:	68 60 94 10 80       	push   $0x80109460
801039c0:	50                   	push   %eax
801039c1:	e8 3a 36 00 00       	call   80107000 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801039c6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801039c9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039cf:	6a 4c                	push   $0x4c
801039d1:	6a 00                	push   $0x0
801039d3:	ff 73 18             	push   0x18(%ebx)
801039d6:	e8 f5 0f 00 00       	call   801049d0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039db:	8b 43 18             	mov    0x18(%ebx),%eax
801039de:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039e3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039e6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039eb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039ef:	8b 43 18             	mov    0x18(%ebx),%eax
801039f2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801039f6:	8b 43 18             	mov    0x18(%ebx),%eax
801039f9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039fd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a01:	8b 43 18             	mov    0x18(%ebx),%eax
80103a04:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a08:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a0c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a0f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a16:	8b 43 18             	mov    0x18(%ebx),%eax
80103a19:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a20:	8b 43 18             	mov    0x18(%ebx),%eax
80103a23:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a2a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a2d:	6a 10                	push   $0x10
80103a2f:	68 a0 79 10 80       	push   $0x801079a0
80103a34:	50                   	push   %eax
80103a35:	e8 46 11 00 00       	call   80104b80 <safestrcpy>
  p->cwd = namei("/");
80103a3a:	c7 04 24 a9 79 10 80 	movl   $0x801079a9,(%esp)
80103a41:	e8 da e6 ff ff       	call   80102120 <namei>
80103a46:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103a49:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103a50:	e8 eb 0d 00 00       	call   80104840 <acquire>
  p->state = RUNNABLE;
80103a55:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103a5c:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103a63:	e8 18 0f 00 00       	call   80104980 <release>
}
80103a68:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a6b:	83 c4 10             	add    $0x10,%esp
80103a6e:	c9                   	leave
80103a6f:	c3                   	ret
    panic("userinit: out of memory?");
80103a70:	83 ec 0c             	sub    $0xc,%esp
80103a73:	68 87 79 10 80       	push   $0x80107987
80103a78:	e8 03 c9 ff ff       	call   80100380 <panic>
80103a7d:	8d 76 00             	lea    0x0(%esi),%esi

80103a80 <growproc>:
{
80103a80:	55                   	push   %ebp
80103a81:	89 e5                	mov    %esp,%ebp
80103a83:	56                   	push   %esi
80103a84:	53                   	push   %ebx
80103a85:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103a88:	e8 63 0d 00 00       	call   801047f0 <pushcli>
  c = mycpu();
80103a8d:	e8 4e fe ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103a92:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a98:	e8 83 0e 00 00       	call   80104920 <popcli>
  sz = curproc->sz;
80103a9d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a9f:	85 f6                	test   %esi,%esi
80103aa1:	7f 1d                	jg     80103ac0 <growproc+0x40>
  } else if(n < 0){
80103aa3:	75 3b                	jne    80103ae0 <growproc+0x60>
  switchuvm(curproc);
80103aa5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103aa8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103aaa:	53                   	push   %ebx
80103aab:	e8 40 34 00 00       	call   80106ef0 <switchuvm>
  return 0;
80103ab0:	83 c4 10             	add    $0x10,%esp
80103ab3:	31 c0                	xor    %eax,%eax
}
80103ab5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ab8:	5b                   	pop    %ebx
80103ab9:	5e                   	pop    %esi
80103aba:	5d                   	pop    %ebp
80103abb:	c3                   	ret
80103abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ac0:	83 ec 04             	sub    $0x4,%esp
80103ac3:	01 c6                	add    %eax,%esi
80103ac5:	56                   	push   %esi
80103ac6:	50                   	push   %eax
80103ac7:	ff 73 04             	push   0x4(%ebx)
80103aca:	e8 81 36 00 00       	call   80107150 <allocuvm>
80103acf:	83 c4 10             	add    $0x10,%esp
80103ad2:	85 c0                	test   %eax,%eax
80103ad4:	75 cf                	jne    80103aa5 <growproc+0x25>
      return -1;
80103ad6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103adb:	eb d8                	jmp    80103ab5 <growproc+0x35>
80103add:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ae0:	83 ec 04             	sub    $0x4,%esp
80103ae3:	01 c6                	add    %eax,%esi
80103ae5:	56                   	push   %esi
80103ae6:	50                   	push   %eax
80103ae7:	ff 73 04             	push   0x4(%ebx)
80103aea:	e8 81 37 00 00       	call   80107270 <deallocuvm>
80103aef:	83 c4 10             	add    $0x10,%esp
80103af2:	85 c0                	test   %eax,%eax
80103af4:	75 af                	jne    80103aa5 <growproc+0x25>
80103af6:	eb de                	jmp    80103ad6 <growproc+0x56>
80103af8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103aff:	90                   	nop

80103b00 <fork>:
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	57                   	push   %edi
80103b04:	56                   	push   %esi
80103b05:	53                   	push   %ebx
80103b06:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b09:	e8 e2 0c 00 00       	call   801047f0 <pushcli>
  c = mycpu();
80103b0e:	e8 cd fd ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103b13:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b19:	e8 02 0e 00 00       	call   80104920 <popcli>
  if((np = allocproc()) == 0){
80103b1e:	e8 5d fc ff ff       	call   80103780 <allocproc>
80103b23:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b26:	85 c0                	test   %eax,%eax
80103b28:	0f 84 d6 00 00 00    	je     80103c04 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b2e:	83 ec 08             	sub    $0x8,%esp
80103b31:	ff 33                	push   (%ebx)
80103b33:	89 c7                	mov    %eax,%edi
80103b35:	ff 73 04             	push   0x4(%ebx)
80103b38:	e8 d3 38 00 00       	call   80107410 <copyuvm>
80103b3d:	83 c4 10             	add    $0x10,%esp
80103b40:	89 47 04             	mov    %eax,0x4(%edi)
80103b43:	85 c0                	test   %eax,%eax
80103b45:	0f 84 9a 00 00 00    	je     80103be5 <fork+0xe5>
  np->sz = curproc->sz;
80103b4b:	8b 03                	mov    (%ebx),%eax
80103b4d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b50:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103b52:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103b55:	89 c8                	mov    %ecx,%eax
80103b57:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103b5a:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b5f:	8b 73 18             	mov    0x18(%ebx),%esi
80103b62:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b64:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103b66:	8b 40 18             	mov    0x18(%eax),%eax
80103b69:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103b70:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b74:	85 c0                	test   %eax,%eax
80103b76:	74 13                	je     80103b8b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b78:	83 ec 0c             	sub    $0xc,%esp
80103b7b:	50                   	push   %eax
80103b7c:	e8 6f d3 ff ff       	call   80100ef0 <filedup>
80103b81:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b84:	83 c4 10             	add    $0x10,%esp
80103b87:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b8b:	83 c6 01             	add    $0x1,%esi
80103b8e:	83 fe 10             	cmp    $0x10,%esi
80103b91:	75 dd                	jne    80103b70 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103b93:	83 ec 0c             	sub    $0xc,%esp
80103b96:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b99:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103b9c:	e8 1f dc ff ff       	call   801017c0 <idup>
80103ba1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ba4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103ba7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103baa:	8d 47 6c             	lea    0x6c(%edi),%eax
80103bad:	6a 10                	push   $0x10
80103baf:	53                   	push   %ebx
80103bb0:	50                   	push   %eax
80103bb1:	e8 ca 0f 00 00       	call   80104b80 <safestrcpy>
  pid = np->pid;
80103bb6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103bb9:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103bc0:	e8 7b 0c 00 00       	call   80104840 <acquire>
  np->state = RUNNABLE;
80103bc5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103bcc:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103bd3:	e8 a8 0d 00 00       	call   80104980 <release>
  return pid;
80103bd8:	83 c4 10             	add    $0x10,%esp
}
80103bdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bde:	89 d8                	mov    %ebx,%eax
80103be0:	5b                   	pop    %ebx
80103be1:	5e                   	pop    %esi
80103be2:	5f                   	pop    %edi
80103be3:	5d                   	pop    %ebp
80103be4:	c3                   	ret
    kfree(np->kstack);
80103be5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103be8:	83 ec 0c             	sub    $0xc,%esp
80103beb:	ff 73 08             	push   0x8(%ebx)
80103bee:	e8 4d e9 ff ff       	call   80102540 <kfree>
    np->kstack = 0;
80103bf3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103bfa:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103bfd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103c04:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c09:	eb d0                	jmp    80103bdb <fork+0xdb>
80103c0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c0f:	90                   	nop

80103c10 <scheduler>:
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	57                   	push   %edi
80103c14:	56                   	push   %esi
80103c15:	53                   	push   %ebx
80103c16:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103c19:	e8 c2 fc ff ff       	call   801038e0 <mycpu>
  c->proc = 0;
80103c1e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c25:	00 00 00 
  struct cpu *c = mycpu();
80103c28:	89 c6                	mov    %eax,%esi
  int ran = 0; // CS 350/550: to solve the 100%-CPU-utilization-when-idling problem
80103c2a:	8d 78 04             	lea    0x4(%eax),%edi
80103c2d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103c30:	fb                   	sti
        acquire(&ptable.lock);
80103c31:	83 ec 0c             	sub    $0xc,%esp
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c34:	bb 34 c7 11 80       	mov    $0x8011c734,%ebx
        acquire(&ptable.lock);
80103c39:	68 00 c7 11 80       	push   $0x8011c700
80103c3e:	e8 fd 0b 00 00       	call   80104840 <acquire>
80103c43:	83 c4 10             	add    $0x10,%esp
        ran = 0;
80103c46:	31 c0                	xor    %eax,%eax
80103c48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c4f:	90                   	nop
          if(p->state != RUNNABLE)
80103c50:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c54:	75 38                	jne    80103c8e <scheduler+0x7e>
          switchuvm(p);
80103c56:	83 ec 0c             	sub    $0xc,%esp
          c->proc = p;
80103c59:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
          switchuvm(p);
80103c5f:	53                   	push   %ebx
80103c60:	e8 8b 32 00 00       	call   80106ef0 <switchuvm>
          swtch(&(c->scheduler), p->context);
80103c65:	58                   	pop    %eax
80103c66:	5a                   	pop    %edx
80103c67:	ff 73 1c             	push   0x1c(%ebx)
80103c6a:	57                   	push   %edi
          p->state = RUNNING;
80103c6b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
          swtch(&(c->scheduler), p->context);
80103c72:	e8 64 0f 00 00       	call   80104bdb <swtch>
          switchkvm();
80103c77:	e8 64 32 00 00       	call   80106ee0 <switchkvm>
          c->proc = 0;
80103c7c:	83 c4 10             	add    $0x10,%esp
          ran = 1;
80103c7f:	b8 01 00 00 00       	mov    $0x1,%eax
          c->proc = 0;
80103c84:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103c8b:	00 00 00 
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c8e:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103c94:	81 fb 34 e8 11 80    	cmp    $0x8011e834,%ebx
80103c9a:	75 b4                	jne    80103c50 <scheduler+0x40>
    release(&ptable.lock);
80103c9c:	83 ec 0c             	sub    $0xc,%esp
80103c9f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ca2:	68 00 c7 11 80       	push   $0x8011c700
80103ca7:	e8 d4 0c 00 00       	call   80104980 <release>
    if (ran == 0){
80103cac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103caf:	83 c4 10             	add    $0x10,%esp
80103cb2:	85 c0                	test   %eax,%eax
80103cb4:	0f 85 76 ff ff ff    	jne    80103c30 <scheduler+0x20>

// CS 350/550: to solve the 100%-CPU-utilization-when-idling problem - "hlt" instruction puts CPU to sleep
static inline void
halt()
{
    asm volatile("hlt" : : :"memory");
80103cba:	f4                   	hlt
}
80103cbb:	e9 70 ff ff ff       	jmp    80103c30 <scheduler+0x20>

80103cc0 <sched>:
{
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	56                   	push   %esi
80103cc4:	53                   	push   %ebx
  pushcli();
80103cc5:	e8 26 0b 00 00       	call   801047f0 <pushcli>
  c = mycpu();
80103cca:	e8 11 fc ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103ccf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cd5:	e8 46 0c 00 00       	call   80104920 <popcli>
  if(!holding(&ptable.lock))
80103cda:	83 ec 0c             	sub    $0xc,%esp
80103cdd:	68 00 c7 11 80       	push   $0x8011c700
80103ce2:	e8 c9 0a 00 00       	call   801047b0 <holding>
80103ce7:	83 c4 10             	add    $0x10,%esp
80103cea:	85 c0                	test   %eax,%eax
80103cec:	74 4f                	je     80103d3d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103cee:	e8 ed fb ff ff       	call   801038e0 <mycpu>
80103cf3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103cfa:	75 68                	jne    80103d64 <sched+0xa4>
  if(p->state == RUNNING)
80103cfc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103d00:	74 55                	je     80103d57 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d02:	9c                   	pushf
80103d03:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103d04:	f6 c4 02             	test   $0x2,%ah
80103d07:	75 41                	jne    80103d4a <sched+0x8a>
  intena = mycpu()->intena;
80103d09:	e8 d2 fb ff ff       	call   801038e0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103d0e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103d11:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d17:	e8 c4 fb ff ff       	call   801038e0 <mycpu>
80103d1c:	83 ec 08             	sub    $0x8,%esp
80103d1f:	ff 70 04             	push   0x4(%eax)
80103d22:	53                   	push   %ebx
80103d23:	e8 b3 0e 00 00       	call   80104bdb <swtch>
  mycpu()->intena = intena;
80103d28:	e8 b3 fb ff ff       	call   801038e0 <mycpu>
}
80103d2d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d30:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d36:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d39:	5b                   	pop    %ebx
80103d3a:	5e                   	pop    %esi
80103d3b:	5d                   	pop    %ebp
80103d3c:	c3                   	ret
    panic("sched ptable.lock");
80103d3d:	83 ec 0c             	sub    $0xc,%esp
80103d40:	68 ab 79 10 80       	push   $0x801079ab
80103d45:	e8 36 c6 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103d4a:	83 ec 0c             	sub    $0xc,%esp
80103d4d:	68 d7 79 10 80       	push   $0x801079d7
80103d52:	e8 29 c6 ff ff       	call   80100380 <panic>
    panic("sched running");
80103d57:	83 ec 0c             	sub    $0xc,%esp
80103d5a:	68 c9 79 10 80       	push   $0x801079c9
80103d5f:	e8 1c c6 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103d64:	83 ec 0c             	sub    $0xc,%esp
80103d67:	68 bd 79 10 80       	push   $0x801079bd
80103d6c:	e8 0f c6 ff ff       	call   80100380 <panic>
80103d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d7f:	90                   	nop

80103d80 <exit>:
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	57                   	push   %edi
80103d84:	56                   	push   %esi
80103d85:	53                   	push   %ebx
80103d86:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103d89:	e8 d2 fb ff ff       	call   80103960 <myproc>
  if(curproc == initproc)
80103d8e:	39 05 34 e8 11 80    	cmp    %eax,0x8011e834
80103d94:	0f 84 07 01 00 00    	je     80103ea1 <exit+0x121>
80103d9a:	89 c3                	mov    %eax,%ebx
80103d9c:	8d 70 28             	lea    0x28(%eax),%esi
80103d9f:	8d 78 68             	lea    0x68(%eax),%edi
80103da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103da8:	8b 06                	mov    (%esi),%eax
80103daa:	85 c0                	test   %eax,%eax
80103dac:	74 12                	je     80103dc0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103dae:	83 ec 0c             	sub    $0xc,%esp
80103db1:	50                   	push   %eax
80103db2:	e8 89 d1 ff ff       	call   80100f40 <fileclose>
      curproc->ofile[fd] = 0;
80103db7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103dbd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103dc0:	83 c6 04             	add    $0x4,%esi
80103dc3:	39 f7                	cmp    %esi,%edi
80103dc5:	75 e1                	jne    80103da8 <exit+0x28>
  begin_op();
80103dc7:	e8 54 ef ff ff       	call   80102d20 <begin_op>
  iput(curproc->cwd);
80103dcc:	83 ec 0c             	sub    $0xc,%esp
80103dcf:	ff 73 68             	push   0x68(%ebx)
80103dd2:	e8 49 db ff ff       	call   80101920 <iput>
  end_op();
80103dd7:	e8 b4 ef ff ff       	call   80102d90 <end_op>
  curproc->cwd = 0;
80103ddc:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103de3:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103dea:	e8 51 0a 00 00       	call   80104840 <acquire>
  wakeup1(curproc->parent);
80103def:	8b 53 14             	mov    0x14(%ebx),%edx
80103df2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103df5:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
80103dfa:	eb 10                	jmp    80103e0c <exit+0x8c>
80103dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e00:	05 84 00 00 00       	add    $0x84,%eax
80103e05:	3d 34 e8 11 80       	cmp    $0x8011e834,%eax
80103e0a:	74 1e                	je     80103e2a <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
80103e0c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e10:	75 ee                	jne    80103e00 <exit+0x80>
80103e12:	3b 50 20             	cmp    0x20(%eax),%edx
80103e15:	75 e9                	jne    80103e00 <exit+0x80>
      p->state = RUNNABLE;
80103e17:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e1e:	05 84 00 00 00       	add    $0x84,%eax
80103e23:	3d 34 e8 11 80       	cmp    $0x8011e834,%eax
80103e28:	75 e2                	jne    80103e0c <exit+0x8c>
      p->parent = initproc;
80103e2a:	8b 0d 34 e8 11 80    	mov    0x8011e834,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e30:	ba 34 c7 11 80       	mov    $0x8011c734,%edx
80103e35:	eb 17                	jmp    80103e4e <exit+0xce>
80103e37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e3e:	66 90                	xchg   %ax,%ax
80103e40:	81 c2 84 00 00 00    	add    $0x84,%edx
80103e46:	81 fa 34 e8 11 80    	cmp    $0x8011e834,%edx
80103e4c:	74 3a                	je     80103e88 <exit+0x108>
    if(p->parent == curproc){
80103e4e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103e51:	75 ed                	jne    80103e40 <exit+0xc0>
      if(p->state == ZOMBIE)
80103e53:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e57:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e5a:	75 e4                	jne    80103e40 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e5c:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
80103e61:	eb 11                	jmp    80103e74 <exit+0xf4>
80103e63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e67:	90                   	nop
80103e68:	05 84 00 00 00       	add    $0x84,%eax
80103e6d:	3d 34 e8 11 80       	cmp    $0x8011e834,%eax
80103e72:	74 cc                	je     80103e40 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103e74:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e78:	75 ee                	jne    80103e68 <exit+0xe8>
80103e7a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e7d:	75 e9                	jne    80103e68 <exit+0xe8>
      p->state = RUNNABLE;
80103e7f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e86:	eb e0                	jmp    80103e68 <exit+0xe8>
  curproc->state = ZOMBIE;
80103e88:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103e8f:	e8 2c fe ff ff       	call   80103cc0 <sched>
  panic("zombie exit");
80103e94:	83 ec 0c             	sub    $0xc,%esp
80103e97:	68 f8 79 10 80       	push   $0x801079f8
80103e9c:	e8 df c4 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103ea1:	83 ec 0c             	sub    $0xc,%esp
80103ea4:	68 eb 79 10 80       	push   $0x801079eb
80103ea9:	e8 d2 c4 ff ff       	call   80100380 <panic>
80103eae:	66 90                	xchg   %ax,%ax

80103eb0 <wait>:
{
80103eb0:	55                   	push   %ebp
80103eb1:	89 e5                	mov    %esp,%ebp
80103eb3:	56                   	push   %esi
80103eb4:	53                   	push   %ebx
  pushcli();
80103eb5:	e8 36 09 00 00       	call   801047f0 <pushcli>
  c = mycpu();
80103eba:	e8 21 fa ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103ebf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ec5:	e8 56 0a 00 00       	call   80104920 <popcli>
  acquire(&ptable.lock);
80103eca:	83 ec 0c             	sub    $0xc,%esp
80103ecd:	68 00 c7 11 80       	push   $0x8011c700
80103ed2:	e8 69 09 00 00       	call   80104840 <acquire>
80103ed7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103eda:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103edc:	bb 34 c7 11 80       	mov    $0x8011c734,%ebx
80103ee1:	eb 13                	jmp    80103ef6 <wait+0x46>
80103ee3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ee7:	90                   	nop
80103ee8:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103eee:	81 fb 34 e8 11 80    	cmp    $0x8011e834,%ebx
80103ef4:	74 1e                	je     80103f14 <wait+0x64>
      if(p->parent != curproc)
80103ef6:	39 73 14             	cmp    %esi,0x14(%ebx)
80103ef9:	75 ed                	jne    80103ee8 <wait+0x38>
      if(p->state == ZOMBIE){
80103efb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103eff:	74 5f                	je     80103f60 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f01:	81 c3 84 00 00 00    	add    $0x84,%ebx
      havekids = 1;
80103f07:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f0c:	81 fb 34 e8 11 80    	cmp    $0x8011e834,%ebx
80103f12:	75 e2                	jne    80103ef6 <wait+0x46>
    if(!havekids || curproc->killed){
80103f14:	85 c0                	test   %eax,%eax
80103f16:	0f 84 9a 00 00 00    	je     80103fb6 <wait+0x106>
80103f1c:	8b 46 24             	mov    0x24(%esi),%eax
80103f1f:	85 c0                	test   %eax,%eax
80103f21:	0f 85 8f 00 00 00    	jne    80103fb6 <wait+0x106>
  pushcli();
80103f27:	e8 c4 08 00 00       	call   801047f0 <pushcli>
  c = mycpu();
80103f2c:	e8 af f9 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103f31:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f37:	e8 e4 09 00 00       	call   80104920 <popcli>
  if(p == 0)
80103f3c:	85 db                	test   %ebx,%ebx
80103f3e:	0f 84 89 00 00 00    	je     80103fcd <wait+0x11d>
  p->chan = chan;
80103f44:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80103f47:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f4e:	e8 6d fd ff ff       	call   80103cc0 <sched>
  p->chan = 0;
80103f53:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f5a:	e9 7b ff ff ff       	jmp    80103eda <wait+0x2a>
80103f5f:	90                   	nop
        kfree(p->kstack);
80103f60:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80103f63:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f66:	ff 73 08             	push   0x8(%ebx)
80103f69:	e8 d2 e5 ff ff       	call   80102540 <kfree>
        p->kstack = 0;
80103f6e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f75:	5a                   	pop    %edx
80103f76:	ff 73 04             	push   0x4(%ebx)
80103f79:	e8 22 33 00 00       	call   801072a0 <freevm>
        p->pid = 0;
80103f7e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f85:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f8c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103f90:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103f97:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103f9e:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103fa5:	e8 d6 09 00 00       	call   80104980 <release>
        return pid;
80103faa:	83 c4 10             	add    $0x10,%esp
}
80103fad:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fb0:	89 f0                	mov    %esi,%eax
80103fb2:	5b                   	pop    %ebx
80103fb3:	5e                   	pop    %esi
80103fb4:	5d                   	pop    %ebp
80103fb5:	c3                   	ret
      release(&ptable.lock);
80103fb6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103fb9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103fbe:	68 00 c7 11 80       	push   $0x8011c700
80103fc3:	e8 b8 09 00 00       	call   80104980 <release>
      return -1;
80103fc8:	83 c4 10             	add    $0x10,%esp
80103fcb:	eb e0                	jmp    80103fad <wait+0xfd>
    panic("sleep");
80103fcd:	83 ec 0c             	sub    $0xc,%esp
80103fd0:	68 04 7a 10 80       	push   $0x80107a04
80103fd5:	e8 a6 c3 ff ff       	call   80100380 <panic>
80103fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103fe0 <yield>:
{   
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	53                   	push   %ebx
80103fe4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103fe7:	68 00 c7 11 80       	push   $0x8011c700
80103fec:	e8 4f 08 00 00       	call   80104840 <acquire>
  pushcli();
80103ff1:	e8 fa 07 00 00       	call   801047f0 <pushcli>
  c = mycpu();
80103ff6:	e8 e5 f8 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103ffb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104001:	e8 1a 09 00 00       	call   80104920 <popcli>
  myproc()->state = RUNNABLE;
80104006:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010400d:	e8 ae fc ff ff       	call   80103cc0 <sched>
  release(&ptable.lock);
80104012:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80104019:	e8 62 09 00 00       	call   80104980 <release>
}
8010401e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104021:	83 c4 10             	add    $0x10,%esp
80104024:	c9                   	leave
80104025:	c3                   	ret
80104026:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010402d:	8d 76 00             	lea    0x0(%esi),%esi

80104030 <sleep>:
{
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	57                   	push   %edi
80104034:	56                   	push   %esi
80104035:	53                   	push   %ebx
80104036:	83 ec 0c             	sub    $0xc,%esp
80104039:	8b 7d 08             	mov    0x8(%ebp),%edi
8010403c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010403f:	e8 ac 07 00 00       	call   801047f0 <pushcli>
  c = mycpu();
80104044:	e8 97 f8 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80104049:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010404f:	e8 cc 08 00 00       	call   80104920 <popcli>
  if(p == 0)
80104054:	85 db                	test   %ebx,%ebx
80104056:	0f 84 87 00 00 00    	je     801040e3 <sleep+0xb3>
  if(lk == 0)
8010405c:	85 f6                	test   %esi,%esi
8010405e:	74 76                	je     801040d6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104060:	81 fe 00 c7 11 80    	cmp    $0x8011c700,%esi
80104066:	74 50                	je     801040b8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104068:	83 ec 0c             	sub    $0xc,%esp
8010406b:	68 00 c7 11 80       	push   $0x8011c700
80104070:	e8 cb 07 00 00       	call   80104840 <acquire>
    release(lk);
80104075:	89 34 24             	mov    %esi,(%esp)
80104078:	e8 03 09 00 00       	call   80104980 <release>
  p->chan = chan;
8010407d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104080:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104087:	e8 34 fc ff ff       	call   80103cc0 <sched>
  p->chan = 0;
8010408c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104093:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
8010409a:	e8 e1 08 00 00       	call   80104980 <release>
    acquire(lk);
8010409f:	89 75 08             	mov    %esi,0x8(%ebp)
801040a2:	83 c4 10             	add    $0x10,%esp
}
801040a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040a8:	5b                   	pop    %ebx
801040a9:	5e                   	pop    %esi
801040aa:	5f                   	pop    %edi
801040ab:	5d                   	pop    %ebp
    acquire(lk);
801040ac:	e9 8f 07 00 00       	jmp    80104840 <acquire>
801040b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801040b8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040bb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801040c2:	e8 f9 fb ff ff       	call   80103cc0 <sched>
  p->chan = 0;
801040c7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801040ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040d1:	5b                   	pop    %ebx
801040d2:	5e                   	pop    %esi
801040d3:	5f                   	pop    %edi
801040d4:	5d                   	pop    %ebp
801040d5:	c3                   	ret
    panic("sleep without lk");
801040d6:	83 ec 0c             	sub    $0xc,%esp
801040d9:	68 0a 7a 10 80       	push   $0x80107a0a
801040de:	e8 9d c2 ff ff       	call   80100380 <panic>
    panic("sleep");
801040e3:	83 ec 0c             	sub    $0xc,%esp
801040e6:	68 04 7a 10 80       	push   $0x80107a04
801040eb:	e8 90 c2 ff ff       	call   80100380 <panic>

801040f0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	53                   	push   %ebx
801040f4:	83 ec 10             	sub    $0x10,%esp
801040f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040fa:	68 00 c7 11 80       	push   $0x8011c700
801040ff:	e8 3c 07 00 00       	call   80104840 <acquire>
80104104:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104107:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
8010410c:	eb 0e                	jmp    8010411c <wakeup+0x2c>
8010410e:	66 90                	xchg   %ax,%ax
80104110:	05 84 00 00 00       	add    $0x84,%eax
80104115:	3d 34 e8 11 80       	cmp    $0x8011e834,%eax
8010411a:	74 1e                	je     8010413a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010411c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104120:	75 ee                	jne    80104110 <wakeup+0x20>
80104122:	3b 58 20             	cmp    0x20(%eax),%ebx
80104125:	75 e9                	jne    80104110 <wakeup+0x20>
      p->state = RUNNABLE;
80104127:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010412e:	05 84 00 00 00       	add    $0x84,%eax
80104133:	3d 34 e8 11 80       	cmp    $0x8011e834,%eax
80104138:	75 e2                	jne    8010411c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010413a:	c7 45 08 00 c7 11 80 	movl   $0x8011c700,0x8(%ebp)
}
80104141:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104144:	c9                   	leave
  release(&ptable.lock);
80104145:	e9 36 08 00 00       	jmp    80104980 <release>
8010414a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104150 <kill>:

int
kill(int pid)
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	53                   	push   %ebx
80104154:	83 ec 10             	sub    $0x10,%esp
80104157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010415a:	68 00 c7 11 80       	push   $0x8011c700
8010415f:	e8 dc 06 00 00       	call   80104840 <acquire>
80104164:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104167:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
8010416c:	eb 0e                	jmp    8010417c <kill+0x2c>
8010416e:	66 90                	xchg   %ax,%ax
80104170:	05 84 00 00 00       	add    $0x84,%eax
80104175:	3d 34 e8 11 80       	cmp    $0x8011e834,%eax
8010417a:	74 44                	je     801041c0 <kill+0x70>
    if(p->pid == pid){
8010417c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010417f:	75 ef                	jne    80104170 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING || p->state == BLOCKED)
80104181:	8b 50 0c             	mov    0xc(%eax),%edx
      p->killed = 1;
80104184:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING || p->state == BLOCKED)
8010418b:	83 e2 fb             	and    $0xfffffffb,%edx
8010418e:	83 fa 02             	cmp    $0x2,%edx
80104191:	74 1d                	je     801041b0 <kill+0x60>
        p->state = RUNNABLE;
      release(&ptable.lock);
80104193:	83 ec 0c             	sub    $0xc,%esp
80104196:	68 00 c7 11 80       	push   $0x8011c700
8010419b:	e8 e0 07 00 00       	call   80104980 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801041a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801041a3:	83 c4 10             	add    $0x10,%esp
801041a6:	31 c0                	xor    %eax,%eax
}
801041a8:	c9                   	leave
801041a9:	c3                   	ret
801041aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        p->state = RUNNABLE;
801041b0:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801041b7:	eb da                	jmp    80104193 <kill+0x43>
801041b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801041c0:	83 ec 0c             	sub    $0xc,%esp
801041c3:	68 00 c7 11 80       	push   $0x8011c700
801041c8:	e8 b3 07 00 00       	call   80104980 <release>
}
801041cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801041d0:	83 c4 10             	add    $0x10,%esp
801041d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041d8:	c9                   	leave
801041d9:	c3                   	ret
801041da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	57                   	push   %edi
801041e4:	56                   	push   %esi
801041e5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801041e8:	53                   	push   %ebx
801041e9:	bb a0 c7 11 80       	mov    $0x8011c7a0,%ebx
801041ee:	83 ec 3c             	sub    $0x3c,%esp
801041f1:	eb 27                	jmp    8010421a <procdump+0x3a>
801041f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801041f7:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801041f8:	83 ec 0c             	sub    $0xc,%esp
801041fb:	68 37 7e 10 80       	push   $0x80107e37
80104200:	e8 ab c4 ff ff       	call   801006b0 <cprintf>
80104205:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104208:	81 c3 84 00 00 00    	add    $0x84,%ebx
8010420e:	81 fb a0 e8 11 80    	cmp    $0x8011e8a0,%ebx
80104214:	0f 84 7e 00 00 00    	je     80104298 <procdump+0xb8>
    if(p->state == UNUSED)
8010421a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010421d:	85 c0                	test   %eax,%eax
8010421f:	74 e7                	je     80104208 <procdump+0x28>
      state = "???";
80104221:	ba 1b 7a 10 80       	mov    $0x80107a1b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104226:	83 f8 06             	cmp    $0x6,%eax
80104229:	77 11                	ja     8010423c <procdump+0x5c>
8010422b:	8b 14 85 f4 7a 10 80 	mov    -0x7fef850c(,%eax,4),%edx
      state = "???";
80104232:	b8 1b 7a 10 80       	mov    $0x80107a1b,%eax
80104237:	85 d2                	test   %edx,%edx
80104239:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010423c:	53                   	push   %ebx
8010423d:	52                   	push   %edx
8010423e:	ff 73 a4             	push   -0x5c(%ebx)
80104241:	68 1f 7a 10 80       	push   $0x80107a1f
80104246:	e8 65 c4 ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
8010424b:	83 c4 10             	add    $0x10,%esp
8010424e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104252:	75 a4                	jne    801041f8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104254:	83 ec 08             	sub    $0x8,%esp
80104257:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010425a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010425d:	50                   	push   %eax
8010425e:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104261:	8b 40 0c             	mov    0xc(%eax),%eax
80104264:	83 c0 08             	add    $0x8,%eax
80104267:	50                   	push   %eax
80104268:	e8 d3 04 00 00       	call   80104740 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010426d:	83 c4 10             	add    $0x10,%esp
80104270:	8b 17                	mov    (%edi),%edx
80104272:	85 d2                	test   %edx,%edx
80104274:	74 82                	je     801041f8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104276:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104279:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010427c:	52                   	push   %edx
8010427d:	68 a1 76 10 80       	push   $0x801076a1
80104282:	e8 29 c4 ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104287:	83 c4 10             	add    $0x10,%esp
8010428a:	39 f7                	cmp    %esi,%edi
8010428c:	75 e2                	jne    80104270 <procdump+0x90>
8010428e:	e9 65 ff ff ff       	jmp    801041f8 <procdump+0x18>
80104293:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104297:	90                   	nop
  }
}
80104298:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010429b:	5b                   	pop    %ebx
8010429c:	5e                   	pop    %esi
8010429d:	5f                   	pop    %edi
8010429e:	5d                   	pop    %ebp
8010429f:	c3                   	ret

801042a0 <cps>:


int
cps()
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	83 ec 10             	sub    $0x10,%esp
  asm volatile("sti");
801042a7:	fb                   	sti
struct proc *p;
//Enables interrupts on this processor.
sti();

//Loop over process table looking for process with pid.
acquire(&ptable.lock);
801042a8:	68 00 c7 11 80       	push   $0x8011c700
801042ad:	bb a0 c7 11 80       	mov    $0x8011c7a0,%ebx
801042b2:	e8 89 05 00 00       	call   80104840 <acquire>
cprintf("name \t pid \t state \t priority \n");
801042b7:	c7 04 24 d4 7a 10 80 	movl   $0x80107ad4,(%esp)
801042be:	e8 ed c3 ff ff       	call   801006b0 <cprintf>
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042c3:	83 c4 10             	add    $0x10,%esp
801042c6:	eb 20                	jmp    801042e8 <cps+0x48>
801042c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042cf:	90                   	nop
  if(p->state == SLEEPING)
	  cprintf("%s \t %d \t SLEEPING \t %d \n ", p->name,p->pid,p->priority);
	else if(p->state == RUNNING)
801042d0:	83 f8 04             	cmp    $0x4,%eax
801042d3:	74 5b                	je     80104330 <cps+0x90>
 	  cprintf("%s \t %d \t RUNNING \t %d \n ", p->name,p->pid,p->priority);
	else if(p->state == RUNNABLE)
801042d5:	83 f8 03             	cmp    $0x3,%eax
801042d8:	74 76                	je     80104350 <cps+0xb0>
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042da:	81 c3 84 00 00 00    	add    $0x84,%ebx
801042e0:	81 fb a0 e8 11 80    	cmp    $0x8011e8a0,%ebx
801042e6:	74 2a                	je     80104312 <cps+0x72>
  if(p->state == SLEEPING)
801042e8:	8b 43 a0             	mov    -0x60(%ebx),%eax
801042eb:	83 f8 02             	cmp    $0x2,%eax
801042ee:	75 e0                	jne    801042d0 <cps+0x30>
	  cprintf("%s \t %d \t SLEEPING \t %d \n ", p->name,p->pid,p->priority);
801042f0:	ff 73 10             	push   0x10(%ebx)
801042f3:	ff 73 a4             	push   -0x5c(%ebx)
801042f6:	53                   	push   %ebx
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042f7:	81 c3 84 00 00 00    	add    $0x84,%ebx
	  cprintf("%s \t %d \t SLEEPING \t %d \n ", p->name,p->pid,p->priority);
801042fd:	68 28 7a 10 80       	push   $0x80107a28
80104302:	e8 a9 c3 ff ff       	call   801006b0 <cprintf>
80104307:	83 c4 10             	add    $0x10,%esp
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010430a:	81 fb a0 e8 11 80    	cmp    $0x8011e8a0,%ebx
80104310:	75 d6                	jne    801042e8 <cps+0x48>
 	  cprintf("%s \t %d \t RUNNABLE \t %d \n ", p->name,p->pid,p->priority);
}
release(&ptable.lock);
80104312:	83 ec 0c             	sub    $0xc,%esp
80104315:	68 00 c7 11 80       	push   $0x8011c700
8010431a:	e8 61 06 00 00       	call   80104980 <release>
return 22;
}
8010431f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104322:	b8 16 00 00 00       	mov    $0x16,%eax
80104327:	c9                   	leave
80104328:	c3                   	ret
80104329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 	  cprintf("%s \t %d \t RUNNING \t %d \n ", p->name,p->pid,p->priority);
80104330:	ff 73 10             	push   0x10(%ebx)
80104333:	ff 73 a4             	push   -0x5c(%ebx)
80104336:	53                   	push   %ebx
80104337:	68 43 7a 10 80       	push   $0x80107a43
8010433c:	e8 6f c3 ff ff       	call   801006b0 <cprintf>
80104341:	83 c4 10             	add    $0x10,%esp
80104344:	eb 94                	jmp    801042da <cps+0x3a>
80104346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010434d:	8d 76 00             	lea    0x0(%esi),%esi
 	  cprintf("%s \t %d \t RUNNABLE \t %d \n ", p->name,p->pid,p->priority);
80104350:	ff 73 10             	push   0x10(%ebx)
80104353:	ff 73 a4             	push   -0x5c(%ebx)
80104356:	53                   	push   %ebx
80104357:	68 5d 7a 10 80       	push   $0x80107a5d
8010435c:	e8 4f c3 ff ff       	call   801006b0 <cprintf>
80104361:	83 c4 10             	add    $0x10,%esp
80104364:	e9 71 ff ff ff       	jmp    801042da <cps+0x3a>
80104369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104370 <chpr>:

int
chpr(int pid, int priority)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	53                   	push   %ebx
80104374:	83 ec 10             	sub    $0x10,%esp
80104377:	8b 5d 08             	mov    0x8(%ebp),%ebx
	struct proc *p;
	acquire(&ptable.lock);
8010437a:	68 00 c7 11 80       	push   $0x8011c700
8010437f:	e8 bc 04 00 00       	call   80104840 <acquire>
80104384:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104387:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
8010438c:	eb 0e                	jmp    8010439c <chpr+0x2c>
8010438e:	66 90                	xchg   %ax,%ax
80104390:	05 84 00 00 00       	add    $0x84,%eax
80104395:	3d 34 e8 11 80       	cmp    $0x8011e834,%eax
8010439a:	74 0b                	je     801043a7 <chpr+0x37>
	  if(p->pid == pid){
8010439c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010439f:	75 ef                	jne    80104390 <chpr+0x20>
			p->priority = priority;
801043a1:	8b 55 0c             	mov    0xc(%ebp),%edx
801043a4:	89 50 7c             	mov    %edx,0x7c(%eax)
			break;
		}
	}
	release(&ptable.lock);
801043a7:	83 ec 0c             	sub    $0xc,%esp
801043aa:	68 00 c7 11 80       	push   $0x8011c700
801043af:	e8 cc 05 00 00       	call   80104980 <release>
	return pid;
}
801043b4:	89 d8                	mov    %ebx,%eax
801043b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043b9:	c9                   	leave
801043ba:	c3                   	ret
801043bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043bf:	90                   	nop

801043c0 <p_stat>:

int
p_stat(int pid)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	53                   	push   %ebx
801043c4:	83 ec 10             	sub    $0x10,%esp
801043c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
	struct proc *p;
	int ret = -1;
  acquire(&ptable.lock);
801043ca:	68 00 c7 11 80       	push   $0x8011c700
801043cf:	e8 6c 04 00 00       	call   80104840 <acquire>
801043d4:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043d7:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
801043dc:	eb 0e                	jmp    801043ec <p_stat+0x2c>
801043de:	66 90                	xchg   %ax,%ax
801043e0:	05 84 00 00 00       	add    $0x84,%eax
801043e5:	3d 34 e8 11 80       	cmp    $0x8011e834,%eax
801043ea:	74 34                	je     80104420 <p_stat+0x60>
    if(p->pid == pid){
801043ec:	39 58 10             	cmp    %ebx,0x10(%eax)
801043ef:	75 ef                	jne    801043e0 <p_stat+0x20>
			if(p->state == SLEEPING)
801043f1:	8b 40 0c             	mov    0xc(%eax),%eax
        ret = 2;
801043f4:	bb 02 00 00 00       	mov    $0x2,%ebx
			if(p->state == SLEEPING)
801043f9:	83 f8 02             	cmp    $0x2,%eax
801043fc:	74 0d                	je     8010440b <p_stat+0x4b>
      if(p->state == RUNNING || p->state == RUNNABLE)
801043fe:	8d 50 fd             	lea    -0x3(%eax),%edx
        ret = 1;
80104401:	bb 01 00 00 00       	mov    $0x1,%ebx
      if(p->state == RUNNING || p->state == RUNNABLE)
80104406:	83 fa 01             	cmp    $0x1,%edx
80104409:	77 1c                	ja     80104427 <p_stat+0x67>
      if(p->state == BLOCKED)
        ret = 5;
			break;
		}
	}
	release(&ptable.lock);
8010440b:	83 ec 0c             	sub    $0xc,%esp
8010440e:	68 00 c7 11 80       	push   $0x8011c700
80104413:	e8 68 05 00 00       	call   80104980 <release>
	return ret;
}
80104418:	89 d8                	mov    %ebx,%eax
8010441a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010441d:	c9                   	leave
8010441e:	c3                   	ret
8010441f:	90                   	nop
	int ret = -1;
80104420:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104425:	eb e4                	jmp    8010440b <p_stat+0x4b>
      if(p->state == UNUSED || p->state == ZOMBIE)
80104427:	85 c0                	test   %eax,%eax
80104429:	74 05                	je     80104430 <p_stat+0x70>
8010442b:	83 f8 05             	cmp    $0x5,%eax
8010442e:	75 07                	jne    80104437 <p_stat+0x77>
        ret = 3;
80104430:	bb 03 00 00 00       	mov    $0x3,%ebx
80104435:	eb d4                	jmp    8010440b <p_stat+0x4b>
      if(p->state == EMBRYO)
80104437:	83 f8 01             	cmp    $0x1,%eax
8010443a:	75 07                	jne    80104443 <p_stat+0x83>
        ret = 4;
8010443c:	bb 04 00 00 00       	mov    $0x4,%ebx
80104441:	eb c8                	jmp    8010440b <p_stat+0x4b>
	int ret = -1;
80104443:	83 f8 06             	cmp    $0x6,%eax
80104446:	bb 05 00 00 00       	mov    $0x5,%ebx
8010444b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104450:	0f 45 d8             	cmovne %eax,%ebx
80104453:	eb b6                	jmp    8010440b <p_stat+0x4b>
80104455:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010445c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104460 <mask>:

int
mask(int bin_mask)
{
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	53                   	push   %ebx
80104464:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104467:	e8 84 03 00 00       	call   801047f0 <pushcli>
  c = mycpu();
8010446c:	e8 6f f4 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80104471:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104477:	e8 a4 04 00 00       	call   80104920 <popcli>
  myproc()->sigmask = bin_mask;
8010447c:	8b 45 08             	mov    0x8(%ebp),%eax
8010447f:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  return 0;
}
80104485:	31 c0                	xor    %eax,%eax
80104487:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010448a:	c9                   	leave
8010448b:	c3                   	ret
8010448c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104490 <term>:

int
term(int pid)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	53                   	push   %ebx
80104494:	83 ec 10             	sub    $0x10,%esp
80104497:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010449a:	68 00 c7 11 80       	push   $0x8011c700
8010449f:	e8 9c 03 00 00       	call   80104840 <acquire>
801044a4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044a7:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
801044ac:	eb 0e                	jmp    801044bc <term+0x2c>
801044ae:	66 90                	xchg   %ax,%ax
801044b0:	05 84 00 00 00       	add    $0x84,%eax
801044b5:	3d 34 e8 11 80       	cmp    $0x8011e834,%eax
801044ba:	74 4c                	je     80104508 <term+0x78>
    if(p->pid == pid){
801044bc:	39 58 10             	cmp    %ebx,0x10(%eax)
801044bf:	75 ef                	jne    801044b0 <term+0x20>
      if((p->sigmask & 0b001) != 0){
801044c1:	8b 98 80 00 00 00    	mov    0x80(%eax),%ebx
801044c7:	83 e3 01             	and    $0x1,%ebx
801044ca:	75 3c                	jne    80104508 <term+0x78>
	      return -1;
      }
      
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING || p->state == BLOCKED)
801044cc:	8b 50 0c             	mov    0xc(%eax),%edx
      p->killed = 1;
801044cf:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING || p->state == BLOCKED)
801044d6:	83 e2 fb             	and    $0xfffffffb,%edx
801044d9:	83 fa 02             	cmp    $0x2,%edx
801044dc:	74 1a                	je     801044f8 <term+0x68>
        p->state = RUNNABLE;
      release(&ptable.lock);
801044de:	83 ec 0c             	sub    $0xc,%esp
801044e1:	68 00 c7 11 80       	push   $0x8011c700
801044e6:	e8 95 04 00 00       	call   80104980 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801044eb:	89 d8                	mov    %ebx,%eax
      return 0;
801044ed:	83 c4 10             	add    $0x10,%esp
}
801044f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044f3:	c9                   	leave
801044f4:	c3                   	ret
801044f5:	8d 76 00             	lea    0x0(%esi),%esi
        p->state = RUNNABLE;
801044f8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801044ff:	eb dd                	jmp    801044de <term+0x4e>
80104501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	      release(&ptable.lock);
80104508:	83 ec 0c             	sub    $0xc,%esp
	      return -1;
8010450b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
	      release(&ptable.lock);
80104510:	68 00 c7 11 80       	push   $0x8011c700
80104515:	e8 66 04 00 00       	call   80104980 <release>
}
8010451a:	89 d8                	mov    %ebx,%eax
	      return -1;
8010451c:	83 c4 10             	add    $0x10,%esp
}
8010451f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104522:	c9                   	leave
80104523:	c3                   	ret
80104524:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010452b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010452f:	90                   	nop

80104530 <stop>:

int stop(int pid){
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	53                   	push   %ebx
80104534:	83 ec 10             	sub    $0x10,%esp
80104537:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010453a:	68 00 c7 11 80       	push   $0x8011c700
8010453f:	e8 fc 02 00 00       	call   80104840 <acquire>
80104544:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104547:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
8010454c:	eb 0e                	jmp    8010455c <stop+0x2c>
8010454e:	66 90                	xchg   %ax,%ax
80104550:	05 84 00 00 00       	add    $0x84,%eax
80104555:	3d 34 e8 11 80       	cmp    $0x8011e834,%eax
8010455a:	74 19                	je     80104575 <stop+0x45>
    if(p->pid == pid){
8010455c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010455f:	75 ef                	jne    80104550 <stop+0x20>
      if((p->sigmask & 0b010)!=0){
80104561:	f6 80 80 00 00 00 02 	testb  $0x2,0x80(%eax)
80104568:	75 2f                	jne    80104599 <stop+0x69>
        release(&ptable.lock);
	      return -1;
      }
      if(p->state == RUNNABLE || p->state ==RUNNING){
8010456a:	8b 48 0c             	mov    0xc(%eax),%ecx
8010456d:	8d 51 fd             	lea    -0x3(%ecx),%edx
80104570:	83 fa 01             	cmp    $0x1,%edx
80104573:	76 1b                	jbe    80104590 <stop+0x60>
        p->state = BLOCKED;
      }
      break;
    }
  }
  release(&ptable.lock);
80104575:	83 ec 0c             	sub    $0xc,%esp
80104578:	68 00 c7 11 80       	push   $0x8011c700
8010457d:	e8 fe 03 00 00       	call   80104980 <release>
  return 0;
80104582:	83 c4 10             	add    $0x10,%esp
80104585:	31 c0                	xor    %eax,%eax
}
80104587:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010458a:	c9                   	leave
8010458b:	c3                   	ret
8010458c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->state = BLOCKED;
80104590:	c7 40 0c 06 00 00 00 	movl   $0x6,0xc(%eax)
80104597:	eb dc                	jmp    80104575 <stop+0x45>
        release(&ptable.lock);
80104599:	83 ec 0c             	sub    $0xc,%esp
8010459c:	68 00 c7 11 80       	push   $0x8011c700
801045a1:	e8 da 03 00 00       	call   80104980 <release>
	      return -1;
801045a6:	83 c4 10             	add    $0x10,%esp
801045a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045ae:	eb d7                	jmp    80104587 <stop+0x57>

801045b0 <cont>:

int cont(int pid){
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	53                   	push   %ebx
801045b4:	83 ec 10             	sub    $0x10,%esp
801045b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801045ba:	68 00 c7 11 80       	push   $0x8011c700
801045bf:	e8 7c 02 00 00       	call   80104840 <acquire>
801045c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045c7:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
801045cc:	eb 0e                	jmp    801045dc <cont+0x2c>
801045ce:	66 90                	xchg   %ax,%ax
801045d0:	05 84 00 00 00       	add    $0x84,%eax
801045d5:	3d 34 e8 11 80       	cmp    $0x8011e834,%eax
801045da:	74 12                	je     801045ee <cont+0x3e>
    if(p->pid == pid){
801045dc:	39 58 10             	cmp    %ebx,0x10(%eax)
801045df:	75 ef                	jne    801045d0 <cont+0x20>
      if(p->state == BLOCKED){
801045e1:	83 78 0c 06          	cmpl   $0x6,0xc(%eax)
801045e5:	75 07                	jne    801045ee <cont+0x3e>
        p->state = RUNNABLE;
801045e7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      }
      break;
    }
  }
  release(&ptable.lock);
801045ee:	83 ec 0c             	sub    $0xc,%esp
801045f1:	68 00 c7 11 80       	push   $0x8011c700
801045f6:	e8 85 03 00 00       	call   80104980 <release>
  return 0;
801045fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045fe:	31 c0                	xor    %eax,%eax
80104600:	c9                   	leave
80104601:	c3                   	ret
80104602:	66 90                	xchg   %ax,%ax
80104604:	66 90                	xchg   %ax,%ax
80104606:	66 90                	xchg   %ax,%ax
80104608:	66 90                	xchg   %ax,%ax
8010460a:	66 90                	xchg   %ax,%ax
8010460c:	66 90                	xchg   %ax,%ax
8010460e:	66 90                	xchg   %ax,%ax

80104610 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	53                   	push   %ebx
80104614:	83 ec 0c             	sub    $0xc,%esp
80104617:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010461a:	68 10 7b 10 80       	push   $0x80107b10
8010461f:	8d 43 04             	lea    0x4(%ebx),%eax
80104622:	50                   	push   %eax
80104623:	e8 f8 00 00 00       	call   80104720 <initlock>
  lk->name = name;
80104628:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010462b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104631:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104634:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010463b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010463e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104641:	c9                   	leave
80104642:	c3                   	ret
80104643:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010464a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104650 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	53                   	push   %ebx
80104655:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104658:	8d 73 04             	lea    0x4(%ebx),%esi
8010465b:	83 ec 0c             	sub    $0xc,%esp
8010465e:	56                   	push   %esi
8010465f:	e8 dc 01 00 00       	call   80104840 <acquire>
  while (lk->locked) {
80104664:	8b 13                	mov    (%ebx),%edx
80104666:	83 c4 10             	add    $0x10,%esp
80104669:	85 d2                	test   %edx,%edx
8010466b:	74 16                	je     80104683 <acquiresleep+0x33>
8010466d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104670:	83 ec 08             	sub    $0x8,%esp
80104673:	56                   	push   %esi
80104674:	53                   	push   %ebx
80104675:	e8 b6 f9 ff ff       	call   80104030 <sleep>
  while (lk->locked) {
8010467a:	8b 03                	mov    (%ebx),%eax
8010467c:	83 c4 10             	add    $0x10,%esp
8010467f:	85 c0                	test   %eax,%eax
80104681:	75 ed                	jne    80104670 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104683:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104689:	e8 d2 f2 ff ff       	call   80103960 <myproc>
8010468e:	8b 40 10             	mov    0x10(%eax),%eax
80104691:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104694:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104697:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010469a:	5b                   	pop    %ebx
8010469b:	5e                   	pop    %esi
8010469c:	5d                   	pop    %ebp
  release(&lk->lk);
8010469d:	e9 de 02 00 00       	jmp    80104980 <release>
801046a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046b0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	56                   	push   %esi
801046b4:	53                   	push   %ebx
801046b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801046b8:	8d 73 04             	lea    0x4(%ebx),%esi
801046bb:	83 ec 0c             	sub    $0xc,%esp
801046be:	56                   	push   %esi
801046bf:	e8 7c 01 00 00       	call   80104840 <acquire>
  lk->locked = 0;
801046c4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801046ca:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801046d1:	89 1c 24             	mov    %ebx,(%esp)
801046d4:	e8 17 fa ff ff       	call   801040f0 <wakeup>
  release(&lk->lk);
801046d9:	89 75 08             	mov    %esi,0x8(%ebp)
801046dc:	83 c4 10             	add    $0x10,%esp
}
801046df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046e2:	5b                   	pop    %ebx
801046e3:	5e                   	pop    %esi
801046e4:	5d                   	pop    %ebp
  release(&lk->lk);
801046e5:	e9 96 02 00 00       	jmp    80104980 <release>
801046ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046f0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	56                   	push   %esi
801046f4:	53                   	push   %ebx
801046f5:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
801046f8:	8d 5e 04             	lea    0x4(%esi),%ebx
801046fb:	83 ec 0c             	sub    $0xc,%esp
801046fe:	53                   	push   %ebx
801046ff:	e8 3c 01 00 00       	call   80104840 <acquire>
  r = lk->locked;
80104704:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104706:	89 1c 24             	mov    %ebx,(%esp)
80104709:	e8 72 02 00 00       	call   80104980 <release>
  return r;
}
8010470e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104711:	89 f0                	mov    %esi,%eax
80104713:	5b                   	pop    %ebx
80104714:	5e                   	pop    %esi
80104715:	5d                   	pop    %ebp
80104716:	c3                   	ret
80104717:	66 90                	xchg   %ax,%ax
80104719:	66 90                	xchg   %ax,%ax
8010471b:	66 90                	xchg   %ax,%ax
8010471d:	66 90                	xchg   %ax,%ax
8010471f:	90                   	nop

80104720 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104726:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104729:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010472f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104732:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104739:	5d                   	pop    %ebp
8010473a:	c3                   	ret
8010473b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010473f:	90                   	nop

80104740 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	53                   	push   %ebx
80104744:	8b 45 08             	mov    0x8(%ebp),%eax
80104747:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010474a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010474d:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80104752:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80104757:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010475c:	76 10                	jbe    8010476e <getcallerpcs+0x2e>
8010475e:	eb 28                	jmp    80104788 <getcallerpcs+0x48>
80104760:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104766:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010476c:	77 1a                	ja     80104788 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010476e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104771:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104774:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104777:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104779:	83 f8 0a             	cmp    $0xa,%eax
8010477c:	75 e2                	jne    80104760 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010477e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104781:	c9                   	leave
80104782:	c3                   	ret
80104783:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104787:	90                   	nop
80104788:	8d 04 81             	lea    (%ecx,%eax,4),%eax
8010478b:	8d 51 28             	lea    0x28(%ecx),%edx
8010478e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104790:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104796:	83 c0 04             	add    $0x4,%eax
80104799:	39 d0                	cmp    %edx,%eax
8010479b:	75 f3                	jne    80104790 <getcallerpcs+0x50>
}
8010479d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047a0:	c9                   	leave
801047a1:	c3                   	ret
801047a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047b0 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	53                   	push   %ebx
801047b4:	83 ec 04             	sub    $0x4,%esp
801047b7:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
801047ba:	8b 02                	mov    (%edx),%eax
801047bc:	85 c0                	test   %eax,%eax
801047be:	75 10                	jne    801047d0 <holding+0x20>
}
801047c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047c3:	31 c0                	xor    %eax,%eax
801047c5:	c9                   	leave
801047c6:	c3                   	ret
801047c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047ce:	66 90                	xchg   %ax,%ax
  return lock->locked && lock->cpu == mycpu();
801047d0:	8b 5a 08             	mov    0x8(%edx),%ebx
801047d3:	e8 08 f1 ff ff       	call   801038e0 <mycpu>
801047d8:	39 c3                	cmp    %eax,%ebx
}
801047da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047dd:	c9                   	leave
  return lock->locked && lock->cpu == mycpu();
801047de:	0f 94 c0             	sete   %al
801047e1:	0f b6 c0             	movzbl %al,%eax
}
801047e4:	c3                   	ret
801047e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047f0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	53                   	push   %ebx
801047f4:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801047f7:	9c                   	pushf
801047f8:	5b                   	pop    %ebx
  asm volatile("cli");
801047f9:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801047fa:	e8 e1 f0 ff ff       	call   801038e0 <mycpu>
801047ff:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104805:	85 c0                	test   %eax,%eax
80104807:	74 17                	je     80104820 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104809:	e8 d2 f0 ff ff       	call   801038e0 <mycpu>
8010480e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104815:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104818:	c9                   	leave
80104819:	c3                   	ret
8010481a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104820:	e8 bb f0 ff ff       	call   801038e0 <mycpu>
80104825:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010482b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104831:	eb d6                	jmp    80104809 <pushcli+0x19>
80104833:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010483a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104840 <acquire>:
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	53                   	push   %ebx
80104844:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104847:	e8 a4 ff ff ff       	call   801047f0 <pushcli>
  if(holding(lk))
8010484c:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010484f:	8b 02                	mov    (%edx),%eax
80104851:	85 c0                	test   %eax,%eax
80104853:	0f 85 9f 00 00 00    	jne    801048f8 <acquire+0xb8>
  asm volatile("lock; xchgl %0, %1" :
80104859:	b8 01 00 00 00       	mov    $0x1,%eax
8010485e:	f0 87 02             	lock xchg %eax,(%edx)
80104861:	b9 01 00 00 00       	mov    $0x1,%ecx
  while(xchg(&lk->locked, 1) != 0)
80104866:	85 c0                	test   %eax,%eax
80104868:	74 12                	je     8010487c <acquire+0x3c>
8010486a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104870:	8b 55 08             	mov    0x8(%ebp),%edx
80104873:	89 c8                	mov    %ecx,%eax
80104875:	f0 87 02             	lock xchg %eax,(%edx)
80104878:	85 c0                	test   %eax,%eax
8010487a:	75 f4                	jne    80104870 <acquire+0x30>
  __sync_synchronize();
8010487c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104881:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104884:	e8 57 f0 ff ff       	call   801038e0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104889:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
8010488c:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
8010488e:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104891:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80104897:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
8010489c:	77 32                	ja     801048d0 <acquire+0x90>
  ebp = (uint*)v - 2;
8010489e:	89 e8                	mov    %ebp,%eax
801048a0:	eb 14                	jmp    801048b6 <acquire+0x76>
801048a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801048a8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801048ae:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801048b4:	77 1a                	ja     801048d0 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
801048b6:	8b 58 04             	mov    0x4(%eax),%ebx
801048b9:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801048bd:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801048c0:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801048c2:	83 fa 0a             	cmp    $0xa,%edx
801048c5:	75 e1                	jne    801048a8 <acquire+0x68>
}
801048c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048ca:	c9                   	leave
801048cb:	c3                   	ret
801048cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048d0:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
801048d4:	8d 51 34             	lea    0x34(%ecx),%edx
801048d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048de:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801048e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801048e6:	83 c0 04             	add    $0x4,%eax
801048e9:	39 d0                	cmp    %edx,%eax
801048eb:	75 f3                	jne    801048e0 <acquire+0xa0>
}
801048ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048f0:	c9                   	leave
801048f1:	c3                   	ret
801048f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return lock->locked && lock->cpu == mycpu();
801048f8:	8b 5a 08             	mov    0x8(%edx),%ebx
801048fb:	e8 e0 ef ff ff       	call   801038e0 <mycpu>
80104900:	39 c3                	cmp    %eax,%ebx
80104902:	74 0c                	je     80104910 <acquire+0xd0>
  while(xchg(&lk->locked, 1) != 0)
80104904:	8b 55 08             	mov    0x8(%ebp),%edx
80104907:	e9 4d ff ff ff       	jmp    80104859 <acquire+0x19>
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("acquire");
80104910:	83 ec 0c             	sub    $0xc,%esp
80104913:	68 1b 7b 10 80       	push   $0x80107b1b
80104918:	e8 63 ba ff ff       	call   80100380 <panic>
8010491d:	8d 76 00             	lea    0x0(%esi),%esi

80104920 <popcli>:

void
popcli(void)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104926:	9c                   	pushf
80104927:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104928:	f6 c4 02             	test   $0x2,%ah
8010492b:	75 35                	jne    80104962 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010492d:	e8 ae ef ff ff       	call   801038e0 <mycpu>
80104932:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104939:	78 34                	js     8010496f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010493b:	e8 a0 ef ff ff       	call   801038e0 <mycpu>
80104940:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104946:	85 d2                	test   %edx,%edx
80104948:	74 06                	je     80104950 <popcli+0x30>
    sti();
}
8010494a:	c9                   	leave
8010494b:	c3                   	ret
8010494c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104950:	e8 8b ef ff ff       	call   801038e0 <mycpu>
80104955:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010495b:	85 c0                	test   %eax,%eax
8010495d:	74 eb                	je     8010494a <popcli+0x2a>
  asm volatile("sti");
8010495f:	fb                   	sti
}
80104960:	c9                   	leave
80104961:	c3                   	ret
    panic("popcli - interruptible");
80104962:	83 ec 0c             	sub    $0xc,%esp
80104965:	68 23 7b 10 80       	push   $0x80107b23
8010496a:	e8 11 ba ff ff       	call   80100380 <panic>
    panic("popcli");
8010496f:	83 ec 0c             	sub    $0xc,%esp
80104972:	68 3a 7b 10 80       	push   $0x80107b3a
80104977:	e8 04 ba ff ff       	call   80100380 <panic>
8010497c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104980 <release>:
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	56                   	push   %esi
80104984:	53                   	push   %ebx
80104985:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
80104988:	8b 03                	mov    (%ebx),%eax
8010498a:	85 c0                	test   %eax,%eax
8010498c:	75 12                	jne    801049a0 <release+0x20>
    panic("release");
8010498e:	83 ec 0c             	sub    $0xc,%esp
80104991:	68 41 7b 10 80       	push   $0x80107b41
80104996:	e8 e5 b9 ff ff       	call   80100380 <panic>
8010499b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010499f:	90                   	nop
  return lock->locked && lock->cpu == mycpu();
801049a0:	8b 73 08             	mov    0x8(%ebx),%esi
801049a3:	e8 38 ef ff ff       	call   801038e0 <mycpu>
801049a8:	39 c6                	cmp    %eax,%esi
801049aa:	75 e2                	jne    8010498e <release+0xe>
  lk->pcs[0] = 0;
801049ac:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801049b3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801049ba:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801049bf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801049c5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049c8:	5b                   	pop    %ebx
801049c9:	5e                   	pop    %esi
801049ca:	5d                   	pop    %ebp
  popcli();
801049cb:	e9 50 ff ff ff       	jmp    80104920 <popcli>

801049d0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	57                   	push   %edi
801049d4:	8b 55 08             	mov    0x8(%ebp),%edx
801049d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801049da:	89 d0                	mov    %edx,%eax
801049dc:	09 c8                	or     %ecx,%eax
801049de:	a8 03                	test   $0x3,%al
801049e0:	75 1e                	jne    80104a00 <memset+0x30>
    c &= 0xFF;
801049e2:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801049e6:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
801049e9:	89 d7                	mov    %edx,%edi
801049eb:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
801049f1:	fc                   	cld
801049f2:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801049f4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801049f7:	89 d0                	mov    %edx,%eax
801049f9:	c9                   	leave
801049fa:	c3                   	ret
801049fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049ff:	90                   	nop
  asm volatile("cld; rep stosb" :
80104a00:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a03:	89 d7                	mov    %edx,%edi
80104a05:	fc                   	cld
80104a06:	f3 aa                	rep stos %al,%es:(%edi)
80104a08:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104a0b:	89 d0                	mov    %edx,%eax
80104a0d:	c9                   	leave
80104a0e:	c3                   	ret
80104a0f:	90                   	nop

80104a10 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	56                   	push   %esi
80104a14:	53                   	push   %ebx
80104a15:	8b 75 10             	mov    0x10(%ebp),%esi
80104a18:	8b 55 08             	mov    0x8(%ebp),%edx
80104a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104a1e:	85 f6                	test   %esi,%esi
80104a20:	74 2e                	je     80104a50 <memcmp+0x40>
80104a22:	01 c6                	add    %eax,%esi
80104a24:	eb 14                	jmp    80104a3a <memcmp+0x2a>
80104a26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a2d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104a30:	83 c0 01             	add    $0x1,%eax
80104a33:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104a36:	39 f0                	cmp    %esi,%eax
80104a38:	74 16                	je     80104a50 <memcmp+0x40>
    if(*s1 != *s2)
80104a3a:	0f b6 0a             	movzbl (%edx),%ecx
80104a3d:	0f b6 18             	movzbl (%eax),%ebx
80104a40:	38 d9                	cmp    %bl,%cl
80104a42:	74 ec                	je     80104a30 <memcmp+0x20>
      return *s1 - *s2;
80104a44:	0f b6 c1             	movzbl %cl,%eax
80104a47:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104a49:	5b                   	pop    %ebx
80104a4a:	5e                   	pop    %esi
80104a4b:	5d                   	pop    %ebp
80104a4c:	c3                   	ret
80104a4d:	8d 76 00             	lea    0x0(%esi),%esi
80104a50:	5b                   	pop    %ebx
  return 0;
80104a51:	31 c0                	xor    %eax,%eax
}
80104a53:	5e                   	pop    %esi
80104a54:	5d                   	pop    %ebp
80104a55:	c3                   	ret
80104a56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi

80104a60 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	57                   	push   %edi
80104a64:	56                   	push   %esi
80104a65:	8b 55 08             	mov    0x8(%ebp),%edx
80104a68:	8b 75 0c             	mov    0xc(%ebp),%esi
80104a6b:	8b 45 10             	mov    0x10(%ebp),%eax
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104a6e:	39 d6                	cmp    %edx,%esi
80104a70:	73 26                	jae    80104a98 <memmove+0x38>
80104a72:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104a75:	39 ca                	cmp    %ecx,%edx
80104a77:	73 1f                	jae    80104a98 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104a79:	85 c0                	test   %eax,%eax
80104a7b:	74 0f                	je     80104a8c <memmove+0x2c>
80104a7d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80104a80:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104a84:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104a87:	83 e8 01             	sub    $0x1,%eax
80104a8a:	73 f4                	jae    80104a80 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104a8c:	5e                   	pop    %esi
80104a8d:	89 d0                	mov    %edx,%eax
80104a8f:	5f                   	pop    %edi
80104a90:	5d                   	pop    %ebp
80104a91:	c3                   	ret
80104a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104a98:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104a9b:	89 d7                	mov    %edx,%edi
80104a9d:	85 c0                	test   %eax,%eax
80104a9f:	74 eb                	je     80104a8c <memmove+0x2c>
80104aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104aa8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104aa9:	39 ce                	cmp    %ecx,%esi
80104aab:	75 fb                	jne    80104aa8 <memmove+0x48>
}
80104aad:	5e                   	pop    %esi
80104aae:	89 d0                	mov    %edx,%eax
80104ab0:	5f                   	pop    %edi
80104ab1:	5d                   	pop    %ebp
80104ab2:	c3                   	ret
80104ab3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ac0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104ac0:	eb 9e                	jmp    80104a60 <memmove>
80104ac2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ad0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	53                   	push   %ebx
80104ad4:	8b 55 10             	mov    0x10(%ebp),%edx
80104ad7:	8b 45 08             	mov    0x8(%ebp),%eax
80104ada:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
80104add:	85 d2                	test   %edx,%edx
80104adf:	75 16                	jne    80104af7 <strncmp+0x27>
80104ae1:	eb 2d                	jmp    80104b10 <strncmp+0x40>
80104ae3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ae7:	90                   	nop
80104ae8:	3a 19                	cmp    (%ecx),%bl
80104aea:	75 12                	jne    80104afe <strncmp+0x2e>
    n--, p++, q++;
80104aec:	83 c0 01             	add    $0x1,%eax
80104aef:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104af2:	83 ea 01             	sub    $0x1,%edx
80104af5:	74 19                	je     80104b10 <strncmp+0x40>
80104af7:	0f b6 18             	movzbl (%eax),%ebx
80104afa:	84 db                	test   %bl,%bl
80104afc:	75 ea                	jne    80104ae8 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104afe:	0f b6 00             	movzbl (%eax),%eax
80104b01:	0f b6 11             	movzbl (%ecx),%edx
}
80104b04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b07:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80104b08:	29 d0                	sub    %edx,%eax
}
80104b0a:	c3                   	ret
80104b0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b0f:	90                   	nop
80104b10:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80104b13:	31 c0                	xor    %eax,%eax
}
80104b15:	c9                   	leave
80104b16:	c3                   	ret
80104b17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b1e:	66 90                	xchg   %ax,%ax

80104b20 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	57                   	push   %edi
80104b24:	56                   	push   %esi
80104b25:	53                   	push   %ebx
80104b26:	8b 75 08             	mov    0x8(%ebp),%esi
80104b29:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104b2c:	89 f0                	mov    %esi,%eax
80104b2e:	eb 15                	jmp    80104b45 <strncpy+0x25>
80104b30:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104b34:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104b37:	83 c0 01             	add    $0x1,%eax
80104b3a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
80104b3e:	88 48 ff             	mov    %cl,-0x1(%eax)
80104b41:	84 c9                	test   %cl,%cl
80104b43:	74 13                	je     80104b58 <strncpy+0x38>
80104b45:	89 d3                	mov    %edx,%ebx
80104b47:	83 ea 01             	sub    $0x1,%edx
80104b4a:	85 db                	test   %ebx,%ebx
80104b4c:	7f e2                	jg     80104b30 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
80104b4e:	5b                   	pop    %ebx
80104b4f:	89 f0                	mov    %esi,%eax
80104b51:	5e                   	pop    %esi
80104b52:	5f                   	pop    %edi
80104b53:	5d                   	pop    %ebp
80104b54:	c3                   	ret
80104b55:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80104b58:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104b5b:	83 e9 01             	sub    $0x1,%ecx
80104b5e:	85 d2                	test   %edx,%edx
80104b60:	74 ec                	je     80104b4e <strncpy+0x2e>
80104b62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80104b68:	83 c0 01             	add    $0x1,%eax
80104b6b:	89 ca                	mov    %ecx,%edx
80104b6d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104b71:	29 c2                	sub    %eax,%edx
80104b73:	85 d2                	test   %edx,%edx
80104b75:	7f f1                	jg     80104b68 <strncpy+0x48>
}
80104b77:	5b                   	pop    %ebx
80104b78:	89 f0                	mov    %esi,%eax
80104b7a:	5e                   	pop    %esi
80104b7b:	5f                   	pop    %edi
80104b7c:	5d                   	pop    %ebp
80104b7d:	c3                   	ret
80104b7e:	66 90                	xchg   %ax,%ax

80104b80 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	56                   	push   %esi
80104b84:	53                   	push   %ebx
80104b85:	8b 55 10             	mov    0x10(%ebp),%edx
80104b88:	8b 75 08             	mov    0x8(%ebp),%esi
80104b8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104b8e:	85 d2                	test   %edx,%edx
80104b90:	7e 25                	jle    80104bb7 <safestrcpy+0x37>
80104b92:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104b96:	89 f2                	mov    %esi,%edx
80104b98:	eb 16                	jmp    80104bb0 <safestrcpy+0x30>
80104b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104ba0:	0f b6 08             	movzbl (%eax),%ecx
80104ba3:	83 c0 01             	add    $0x1,%eax
80104ba6:	83 c2 01             	add    $0x1,%edx
80104ba9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104bac:	84 c9                	test   %cl,%cl
80104bae:	74 04                	je     80104bb4 <safestrcpy+0x34>
80104bb0:	39 d8                	cmp    %ebx,%eax
80104bb2:	75 ec                	jne    80104ba0 <safestrcpy+0x20>
    ;
  *s = 0;
80104bb4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104bb7:	89 f0                	mov    %esi,%eax
80104bb9:	5b                   	pop    %ebx
80104bba:	5e                   	pop    %esi
80104bbb:	5d                   	pop    %ebp
80104bbc:	c3                   	ret
80104bbd:	8d 76 00             	lea    0x0(%esi),%esi

80104bc0 <strlen>:

int
strlen(const char *s)
{
80104bc0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104bc1:	31 c0                	xor    %eax,%eax
{
80104bc3:	89 e5                	mov    %esp,%ebp
80104bc5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104bc8:	80 3a 00             	cmpb   $0x0,(%edx)
80104bcb:	74 0c                	je     80104bd9 <strlen+0x19>
80104bcd:	8d 76 00             	lea    0x0(%esi),%esi
80104bd0:	83 c0 01             	add    $0x1,%eax
80104bd3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104bd7:	75 f7                	jne    80104bd0 <strlen+0x10>
    ;
  return n;
}
80104bd9:	5d                   	pop    %ebp
80104bda:	c3                   	ret

80104bdb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104bdb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104bdf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104be3:	55                   	push   %ebp
  pushl %ebx
80104be4:	53                   	push   %ebx
  pushl %esi
80104be5:	56                   	push   %esi
  pushl %edi
80104be6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104be7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104be9:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80104beb:	5f                   	pop    %edi
  popl %esi
80104bec:	5e                   	pop    %esi
  popl %ebx
80104bed:	5b                   	pop    %ebx
  popl %ebp
80104bee:	5d                   	pop    %ebp
  ret
80104bef:	c3                   	ret

80104bf0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	53                   	push   %ebx
80104bf4:	83 ec 04             	sub    $0x4,%esp
80104bf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104bfa:	e8 61 ed ff ff       	call   80103960 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104bff:	8b 00                	mov    (%eax),%eax
80104c01:	39 c3                	cmp    %eax,%ebx
80104c03:	73 1b                	jae    80104c20 <fetchint+0x30>
80104c05:	8d 53 04             	lea    0x4(%ebx),%edx
80104c08:	39 d0                	cmp    %edx,%eax
80104c0a:	72 14                	jb     80104c20 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104c0c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c0f:	8b 13                	mov    (%ebx),%edx
80104c11:	89 10                	mov    %edx,(%eax)
  return 0;
80104c13:	31 c0                	xor    %eax,%eax
}
80104c15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c18:	c9                   	leave
80104c19:	c3                   	ret
80104c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c25:	eb ee                	jmp    80104c15 <fetchint+0x25>
80104c27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c2e:	66 90                	xchg   %ax,%ax

80104c30 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	53                   	push   %ebx
80104c34:	83 ec 04             	sub    $0x4,%esp
80104c37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104c3a:	e8 21 ed ff ff       	call   80103960 <myproc>

  if(addr >= curproc->sz)
80104c3f:	3b 18                	cmp    (%eax),%ebx
80104c41:	73 2d                	jae    80104c70 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104c43:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c46:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104c48:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104c4a:	39 d3                	cmp    %edx,%ebx
80104c4c:	73 22                	jae    80104c70 <fetchstr+0x40>
80104c4e:	89 d8                	mov    %ebx,%eax
80104c50:	eb 0d                	jmp    80104c5f <fetchstr+0x2f>
80104c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c58:	83 c0 01             	add    $0x1,%eax
80104c5b:	39 d0                	cmp    %edx,%eax
80104c5d:	73 11                	jae    80104c70 <fetchstr+0x40>
    if(*s == 0)
80104c5f:	80 38 00             	cmpb   $0x0,(%eax)
80104c62:	75 f4                	jne    80104c58 <fetchstr+0x28>
      return s - *pp;
80104c64:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104c66:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c69:	c9                   	leave
80104c6a:	c3                   	ret
80104c6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c6f:	90                   	nop
80104c70:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104c73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c78:	c9                   	leave
80104c79:	c3                   	ret
80104c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104c80 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104c80:	55                   	push   %ebp
80104c81:	89 e5                	mov    %esp,%ebp
80104c83:	56                   	push   %esi
80104c84:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c85:	e8 d6 ec ff ff       	call   80103960 <myproc>
80104c8a:	8b 55 08             	mov    0x8(%ebp),%edx
80104c8d:	8b 40 18             	mov    0x18(%eax),%eax
80104c90:	8b 40 44             	mov    0x44(%eax),%eax
80104c93:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104c96:	e8 c5 ec ff ff       	call   80103960 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c9b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c9e:	8b 00                	mov    (%eax),%eax
80104ca0:	39 c6                	cmp    %eax,%esi
80104ca2:	73 1c                	jae    80104cc0 <argint+0x40>
80104ca4:	8d 53 08             	lea    0x8(%ebx),%edx
80104ca7:	39 d0                	cmp    %edx,%eax
80104ca9:	72 15                	jb     80104cc0 <argint+0x40>
  *ip = *(int*)(addr);
80104cab:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cae:	8b 53 04             	mov    0x4(%ebx),%edx
80104cb1:	89 10                	mov    %edx,(%eax)
  return 0;
80104cb3:	31 c0                	xor    %eax,%eax
}
80104cb5:	5b                   	pop    %ebx
80104cb6:	5e                   	pop    %esi
80104cb7:	5d                   	pop    %ebp
80104cb8:	c3                   	ret
80104cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104cc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cc5:	eb ee                	jmp    80104cb5 <argint+0x35>
80104cc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cce:	66 90                	xchg   %ax,%ax

80104cd0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
80104cd3:	57                   	push   %edi
80104cd4:	56                   	push   %esi
80104cd5:	53                   	push   %ebx
80104cd6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104cd9:	e8 82 ec ff ff       	call   80103960 <myproc>
80104cde:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ce0:	e8 7b ec ff ff       	call   80103960 <myproc>
80104ce5:	8b 55 08             	mov    0x8(%ebp),%edx
80104ce8:	8b 40 18             	mov    0x18(%eax),%eax
80104ceb:	8b 40 44             	mov    0x44(%eax),%eax
80104cee:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104cf1:	e8 6a ec ff ff       	call   80103960 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cf6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104cf9:	8b 00                	mov    (%eax),%eax
80104cfb:	39 c7                	cmp    %eax,%edi
80104cfd:	73 31                	jae    80104d30 <argptr+0x60>
80104cff:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104d02:	39 c8                	cmp    %ecx,%eax
80104d04:	72 2a                	jb     80104d30 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d06:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104d09:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d0c:	85 d2                	test   %edx,%edx
80104d0e:	78 20                	js     80104d30 <argptr+0x60>
80104d10:	8b 16                	mov    (%esi),%edx
80104d12:	39 d0                	cmp    %edx,%eax
80104d14:	73 1a                	jae    80104d30 <argptr+0x60>
80104d16:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104d19:	01 c3                	add    %eax,%ebx
80104d1b:	39 da                	cmp    %ebx,%edx
80104d1d:	72 11                	jb     80104d30 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104d1f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d22:	89 02                	mov    %eax,(%edx)
  return 0;
80104d24:	31 c0                	xor    %eax,%eax
}
80104d26:	83 c4 0c             	add    $0xc,%esp
80104d29:	5b                   	pop    %ebx
80104d2a:	5e                   	pop    %esi
80104d2b:	5f                   	pop    %edi
80104d2c:	5d                   	pop    %ebp
80104d2d:	c3                   	ret
80104d2e:	66 90                	xchg   %ax,%ax
    return -1;
80104d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d35:	eb ef                	jmp    80104d26 <argptr+0x56>
80104d37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d3e:	66 90                	xchg   %ax,%ax

80104d40 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	56                   	push   %esi
80104d44:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d45:	e8 16 ec ff ff       	call   80103960 <myproc>
80104d4a:	8b 55 08             	mov    0x8(%ebp),%edx
80104d4d:	8b 40 18             	mov    0x18(%eax),%eax
80104d50:	8b 40 44             	mov    0x44(%eax),%eax
80104d53:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d56:	e8 05 ec ff ff       	call   80103960 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d5b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d5e:	8b 00                	mov    (%eax),%eax
80104d60:	39 c6                	cmp    %eax,%esi
80104d62:	73 44                	jae    80104da8 <argstr+0x68>
80104d64:	8d 53 08             	lea    0x8(%ebx),%edx
80104d67:	39 d0                	cmp    %edx,%eax
80104d69:	72 3d                	jb     80104da8 <argstr+0x68>
  *ip = *(int*)(addr);
80104d6b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104d6e:	e8 ed eb ff ff       	call   80103960 <myproc>
  if(addr >= curproc->sz)
80104d73:	3b 18                	cmp    (%eax),%ebx
80104d75:	73 31                	jae    80104da8 <argstr+0x68>
  *pp = (char*)addr;
80104d77:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d7a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104d7c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104d7e:	39 d3                	cmp    %edx,%ebx
80104d80:	73 26                	jae    80104da8 <argstr+0x68>
80104d82:	89 d8                	mov    %ebx,%eax
80104d84:	eb 11                	jmp    80104d97 <argstr+0x57>
80104d86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d8d:	8d 76 00             	lea    0x0(%esi),%esi
80104d90:	83 c0 01             	add    $0x1,%eax
80104d93:	39 d0                	cmp    %edx,%eax
80104d95:	73 11                	jae    80104da8 <argstr+0x68>
    if(*s == 0)
80104d97:	80 38 00             	cmpb   $0x0,(%eax)
80104d9a:	75 f4                	jne    80104d90 <argstr+0x50>
      return s - *pp;
80104d9c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104d9e:	5b                   	pop    %ebx
80104d9f:	5e                   	pop    %esi
80104da0:	5d                   	pop    %ebp
80104da1:	c3                   	ret
80104da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104da8:	5b                   	pop    %ebx
    return -1;
80104da9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104dae:	5e                   	pop    %esi
80104daf:	5d                   	pop    %ebp
80104db0:	c3                   	ret
80104db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104db8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dbf:	90                   	nop

80104dc0 <syscall>:
[SYS_cont]    sys_cont,
};

void
syscall(void)
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	53                   	push   %ebx
80104dc4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104dc7:	e8 94 eb ff ff       	call   80103960 <myproc>
80104dcc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104dce:	8b 40 18             	mov    0x18(%eax),%eax
80104dd1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104dd4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104dd7:	83 fa 1c             	cmp    $0x1c,%edx
80104dda:	77 24                	ja     80104e00 <syscall+0x40>
80104ddc:	8b 14 85 80 7b 10 80 	mov    -0x7fef8480(,%eax,4),%edx
80104de3:	85 d2                	test   %edx,%edx
80104de5:	74 19                	je     80104e00 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104de7:	ff d2                	call   *%edx
80104de9:	89 c2                	mov    %eax,%edx
80104deb:	8b 43 18             	mov    0x18(%ebx),%eax
80104dee:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104df1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104df4:	c9                   	leave
80104df5:	c3                   	ret
80104df6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dfd:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104e00:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104e01:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104e04:	50                   	push   %eax
80104e05:	ff 73 10             	push   0x10(%ebx)
80104e08:	68 49 7b 10 80       	push   $0x80107b49
80104e0d:	e8 9e b8 ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
80104e12:	8b 43 18             	mov    0x18(%ebx),%eax
80104e15:	83 c4 10             	add    $0x10,%esp
80104e18:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104e1f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e22:	c9                   	leave
80104e23:	c3                   	ret
80104e24:	66 90                	xchg   %ax,%ax
80104e26:	66 90                	xchg   %ax,%ax
80104e28:	66 90                	xchg   %ax,%ax
80104e2a:	66 90                	xchg   %ax,%ax
80104e2c:	66 90                	xchg   %ax,%ax
80104e2e:	66 90                	xchg   %ax,%ax

80104e30 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	57                   	push   %edi
80104e34:	56                   	push   %esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104e35:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104e38:	53                   	push   %ebx
80104e39:	83 ec 44             	sub    $0x44,%esp
80104e3c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104e3f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e42:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104e45:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104e48:	57                   	push   %edi
80104e49:	50                   	push   %eax
80104e4a:	e8 f1 d2 ff ff       	call   80102140 <nameiparent>
80104e4f:	83 c4 10             	add    $0x10,%esp
80104e52:	85 c0                	test   %eax,%eax
80104e54:	74 5e                	je     80104eb4 <create+0x84>
    return 0;
  ilock(dp);
80104e56:	83 ec 0c             	sub    $0xc,%esp
80104e59:	89 c3                	mov    %eax,%ebx
80104e5b:	50                   	push   %eax
80104e5c:	e8 8f c9 ff ff       	call   801017f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104e61:	83 c4 0c             	add    $0xc,%esp
80104e64:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104e67:	50                   	push   %eax
80104e68:	57                   	push   %edi
80104e69:	53                   	push   %ebx
80104e6a:	e8 e1 ce ff ff       	call   80101d50 <dirlookup>
80104e6f:	83 c4 10             	add    $0x10,%esp
80104e72:	89 c6                	mov    %eax,%esi
80104e74:	85 c0                	test   %eax,%eax
80104e76:	74 48                	je     80104ec0 <create+0x90>
    iunlockput(dp);
80104e78:	83 ec 0c             	sub    $0xc,%esp
80104e7b:	53                   	push   %ebx
80104e7c:	e8 ff cb ff ff       	call   80101a80 <iunlockput>
    ilock(ip);
80104e81:	89 34 24             	mov    %esi,(%esp)
80104e84:	e8 67 c9 ff ff       	call   801017f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104e89:	83 c4 10             	add    $0x10,%esp
80104e8c:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104e91:	75 15                	jne    80104ea8 <create+0x78>
80104e93:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104e98:	75 0e                	jne    80104ea8 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104e9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e9d:	89 f0                	mov    %esi,%eax
80104e9f:	5b                   	pop    %ebx
80104ea0:	5e                   	pop    %esi
80104ea1:	5f                   	pop    %edi
80104ea2:	5d                   	pop    %ebp
80104ea3:	c3                   	ret
80104ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80104ea8:	83 ec 0c             	sub    $0xc,%esp
80104eab:	56                   	push   %esi
80104eac:	e8 cf cb ff ff       	call   80101a80 <iunlockput>
    return 0;
80104eb1:	83 c4 10             	add    $0x10,%esp
}
80104eb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104eb7:	31 f6                	xor    %esi,%esi
}
80104eb9:	5b                   	pop    %ebx
80104eba:	89 f0                	mov    %esi,%eax
80104ebc:	5e                   	pop    %esi
80104ebd:	5f                   	pop    %edi
80104ebe:	5d                   	pop    %ebp
80104ebf:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80104ec0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104ec4:	83 ec 08             	sub    $0x8,%esp
80104ec7:	50                   	push   %eax
80104ec8:	ff 33                	push   (%ebx)
80104eca:	e8 b1 c7 ff ff       	call   80101680 <ialloc>
80104ecf:	83 c4 10             	add    $0x10,%esp
80104ed2:	89 c6                	mov    %eax,%esi
80104ed4:	85 c0                	test   %eax,%eax
80104ed6:	0f 84 bc 00 00 00    	je     80104f98 <create+0x168>
  ilock(ip);
80104edc:	83 ec 0c             	sub    $0xc,%esp
80104edf:	50                   	push   %eax
80104ee0:	e8 0b c9 ff ff       	call   801017f0 <ilock>
  ip->major = major;
80104ee5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104ee9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104eed:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104ef1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104ef5:	b8 01 00 00 00       	mov    $0x1,%eax
80104efa:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104efe:	89 34 24             	mov    %esi,(%esp)
80104f01:	e8 3a c8 ff ff       	call   80101740 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104f06:	83 c4 10             	add    $0x10,%esp
80104f09:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104f0e:	74 30                	je     80104f40 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104f10:	83 ec 04             	sub    $0x4,%esp
80104f13:	ff 76 04             	push   0x4(%esi)
80104f16:	57                   	push   %edi
80104f17:	53                   	push   %ebx
80104f18:	e8 43 d1 ff ff       	call   80102060 <dirlink>
80104f1d:	83 c4 10             	add    $0x10,%esp
80104f20:	85 c0                	test   %eax,%eax
80104f22:	78 67                	js     80104f8b <create+0x15b>
  iunlockput(dp);
80104f24:	83 ec 0c             	sub    $0xc,%esp
80104f27:	53                   	push   %ebx
80104f28:	e8 53 cb ff ff       	call   80101a80 <iunlockput>
  return ip;
80104f2d:	83 c4 10             	add    $0x10,%esp
}
80104f30:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f33:	89 f0                	mov    %esi,%eax
80104f35:	5b                   	pop    %ebx
80104f36:	5e                   	pop    %esi
80104f37:	5f                   	pop    %edi
80104f38:	5d                   	pop    %ebp
80104f39:	c3                   	ret
80104f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104f40:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104f43:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104f48:	53                   	push   %ebx
80104f49:	e8 f2 c7 ff ff       	call   80101740 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104f4e:	83 c4 0c             	add    $0xc,%esp
80104f51:	ff 76 04             	push   0x4(%esi)
80104f54:	68 14 7c 10 80       	push   $0x80107c14
80104f59:	56                   	push   %esi
80104f5a:	e8 01 d1 ff ff       	call   80102060 <dirlink>
80104f5f:	83 c4 10             	add    $0x10,%esp
80104f62:	85 c0                	test   %eax,%eax
80104f64:	78 18                	js     80104f7e <create+0x14e>
80104f66:	83 ec 04             	sub    $0x4,%esp
80104f69:	ff 73 04             	push   0x4(%ebx)
80104f6c:	68 13 7c 10 80       	push   $0x80107c13
80104f71:	56                   	push   %esi
80104f72:	e8 e9 d0 ff ff       	call   80102060 <dirlink>
80104f77:	83 c4 10             	add    $0x10,%esp
80104f7a:	85 c0                	test   %eax,%eax
80104f7c:	79 92                	jns    80104f10 <create+0xe0>
      panic("create dots");
80104f7e:	83 ec 0c             	sub    $0xc,%esp
80104f81:	68 07 7c 10 80       	push   $0x80107c07
80104f86:	e8 f5 b3 ff ff       	call   80100380 <panic>
    panic("create: dirlink");
80104f8b:	83 ec 0c             	sub    $0xc,%esp
80104f8e:	68 16 7c 10 80       	push   $0x80107c16
80104f93:	e8 e8 b3 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104f98:	83 ec 0c             	sub    $0xc,%esp
80104f9b:	68 f8 7b 10 80       	push   $0x80107bf8
80104fa0:	e8 db b3 ff ff       	call   80100380 <panic>
80104fa5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fb0 <sys_dup>:
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	56                   	push   %esi
80104fb4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104fb5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104fb8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104fbb:	50                   	push   %eax
80104fbc:	6a 00                	push   $0x0
80104fbe:	e8 bd fc ff ff       	call   80104c80 <argint>
80104fc3:	83 c4 10             	add    $0x10,%esp
80104fc6:	85 c0                	test   %eax,%eax
80104fc8:	78 36                	js     80105000 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104fca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104fce:	77 30                	ja     80105000 <sys_dup+0x50>
80104fd0:	e8 8b e9 ff ff       	call   80103960 <myproc>
80104fd5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104fd8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104fdc:	85 f6                	test   %esi,%esi
80104fde:	74 20                	je     80105000 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104fe0:	e8 7b e9 ff ff       	call   80103960 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104fe5:	31 db                	xor    %ebx,%ebx
80104fe7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fee:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80104ff0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104ff4:	85 d2                	test   %edx,%edx
80104ff6:	74 18                	je     80105010 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104ff8:	83 c3 01             	add    $0x1,%ebx
80104ffb:	83 fb 10             	cmp    $0x10,%ebx
80104ffe:	75 f0                	jne    80104ff0 <sys_dup+0x40>
}
80105000:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105003:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105008:	89 d8                	mov    %ebx,%eax
8010500a:	5b                   	pop    %ebx
8010500b:	5e                   	pop    %esi
8010500c:	5d                   	pop    %ebp
8010500d:	c3                   	ret
8010500e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105010:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105013:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105017:	56                   	push   %esi
80105018:	e8 d3 be ff ff       	call   80100ef0 <filedup>
  return fd;
8010501d:	83 c4 10             	add    $0x10,%esp
}
80105020:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105023:	89 d8                	mov    %ebx,%eax
80105025:	5b                   	pop    %ebx
80105026:	5e                   	pop    %esi
80105027:	5d                   	pop    %ebp
80105028:	c3                   	ret
80105029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105030 <sys_read>:
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	56                   	push   %esi
80105034:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105035:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105038:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010503b:	53                   	push   %ebx
8010503c:	6a 00                	push   $0x0
8010503e:	e8 3d fc ff ff       	call   80104c80 <argint>
80105043:	83 c4 10             	add    $0x10,%esp
80105046:	85 c0                	test   %eax,%eax
80105048:	78 5e                	js     801050a8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010504a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010504e:	77 58                	ja     801050a8 <sys_read+0x78>
80105050:	e8 0b e9 ff ff       	call   80103960 <myproc>
80105055:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105058:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010505c:	85 f6                	test   %esi,%esi
8010505e:	74 48                	je     801050a8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105060:	83 ec 08             	sub    $0x8,%esp
80105063:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105066:	50                   	push   %eax
80105067:	6a 02                	push   $0x2
80105069:	e8 12 fc ff ff       	call   80104c80 <argint>
8010506e:	83 c4 10             	add    $0x10,%esp
80105071:	85 c0                	test   %eax,%eax
80105073:	78 33                	js     801050a8 <sys_read+0x78>
80105075:	83 ec 04             	sub    $0x4,%esp
80105078:	ff 75 f0             	push   -0x10(%ebp)
8010507b:	53                   	push   %ebx
8010507c:	6a 01                	push   $0x1
8010507e:	e8 4d fc ff ff       	call   80104cd0 <argptr>
80105083:	83 c4 10             	add    $0x10,%esp
80105086:	85 c0                	test   %eax,%eax
80105088:	78 1e                	js     801050a8 <sys_read+0x78>
  return fileread(f, p, n);
8010508a:	83 ec 04             	sub    $0x4,%esp
8010508d:	ff 75 f0             	push   -0x10(%ebp)
80105090:	ff 75 f4             	push   -0xc(%ebp)
80105093:	56                   	push   %esi
80105094:	e8 d7 bf ff ff       	call   80101070 <fileread>
80105099:	83 c4 10             	add    $0x10,%esp
}
8010509c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010509f:	5b                   	pop    %ebx
801050a0:	5e                   	pop    %esi
801050a1:	5d                   	pop    %ebp
801050a2:	c3                   	ret
801050a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050a7:	90                   	nop
    return -1;
801050a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050ad:	eb ed                	jmp    8010509c <sys_read+0x6c>
801050af:	90                   	nop

801050b0 <sys_write>:
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	56                   	push   %esi
801050b4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801050b5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801050b8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801050bb:	53                   	push   %ebx
801050bc:	6a 00                	push   $0x0
801050be:	e8 bd fb ff ff       	call   80104c80 <argint>
801050c3:	83 c4 10             	add    $0x10,%esp
801050c6:	85 c0                	test   %eax,%eax
801050c8:	78 5e                	js     80105128 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801050ca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801050ce:	77 58                	ja     80105128 <sys_write+0x78>
801050d0:	e8 8b e8 ff ff       	call   80103960 <myproc>
801050d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050d8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801050dc:	85 f6                	test   %esi,%esi
801050de:	74 48                	je     80105128 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801050e0:	83 ec 08             	sub    $0x8,%esp
801050e3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050e6:	50                   	push   %eax
801050e7:	6a 02                	push   $0x2
801050e9:	e8 92 fb ff ff       	call   80104c80 <argint>
801050ee:	83 c4 10             	add    $0x10,%esp
801050f1:	85 c0                	test   %eax,%eax
801050f3:	78 33                	js     80105128 <sys_write+0x78>
801050f5:	83 ec 04             	sub    $0x4,%esp
801050f8:	ff 75 f0             	push   -0x10(%ebp)
801050fb:	53                   	push   %ebx
801050fc:	6a 01                	push   $0x1
801050fe:	e8 cd fb ff ff       	call   80104cd0 <argptr>
80105103:	83 c4 10             	add    $0x10,%esp
80105106:	85 c0                	test   %eax,%eax
80105108:	78 1e                	js     80105128 <sys_write+0x78>
  return filewrite(f, p, n);
8010510a:	83 ec 04             	sub    $0x4,%esp
8010510d:	ff 75 f0             	push   -0x10(%ebp)
80105110:	ff 75 f4             	push   -0xc(%ebp)
80105113:	56                   	push   %esi
80105114:	e8 e7 bf ff ff       	call   80101100 <filewrite>
80105119:	83 c4 10             	add    $0x10,%esp
}
8010511c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010511f:	5b                   	pop    %ebx
80105120:	5e                   	pop    %esi
80105121:	5d                   	pop    %ebp
80105122:	c3                   	ret
80105123:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105127:	90                   	nop
    return -1;
80105128:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010512d:	eb ed                	jmp    8010511c <sys_write+0x6c>
8010512f:	90                   	nop

80105130 <sys_close>:
{
80105130:	55                   	push   %ebp
80105131:	89 e5                	mov    %esp,%ebp
80105133:	56                   	push   %esi
80105134:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105135:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105138:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010513b:	50                   	push   %eax
8010513c:	6a 00                	push   $0x0
8010513e:	e8 3d fb ff ff       	call   80104c80 <argint>
80105143:	83 c4 10             	add    $0x10,%esp
80105146:	85 c0                	test   %eax,%eax
80105148:	78 3e                	js     80105188 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010514a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010514e:	77 38                	ja     80105188 <sys_close+0x58>
80105150:	e8 0b e8 ff ff       	call   80103960 <myproc>
80105155:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105158:	8d 5a 08             	lea    0x8(%edx),%ebx
8010515b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
8010515f:	85 f6                	test   %esi,%esi
80105161:	74 25                	je     80105188 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105163:	e8 f8 e7 ff ff       	call   80103960 <myproc>
  fileclose(f);
80105168:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010516b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105172:	00 
  fileclose(f);
80105173:	56                   	push   %esi
80105174:	e8 c7 bd ff ff       	call   80100f40 <fileclose>
  return 0;
80105179:	83 c4 10             	add    $0x10,%esp
8010517c:	31 c0                	xor    %eax,%eax
}
8010517e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105181:	5b                   	pop    %ebx
80105182:	5e                   	pop    %esi
80105183:	5d                   	pop    %ebp
80105184:	c3                   	ret
80105185:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105188:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010518d:	eb ef                	jmp    8010517e <sys_close+0x4e>
8010518f:	90                   	nop

80105190 <sys_fstat>:
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	56                   	push   %esi
80105194:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105195:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105198:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010519b:	53                   	push   %ebx
8010519c:	6a 00                	push   $0x0
8010519e:	e8 dd fa ff ff       	call   80104c80 <argint>
801051a3:	83 c4 10             	add    $0x10,%esp
801051a6:	85 c0                	test   %eax,%eax
801051a8:	78 46                	js     801051f0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801051aa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801051ae:	77 40                	ja     801051f0 <sys_fstat+0x60>
801051b0:	e8 ab e7 ff ff       	call   80103960 <myproc>
801051b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801051b8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801051bc:	85 f6                	test   %esi,%esi
801051be:	74 30                	je     801051f0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801051c0:	83 ec 04             	sub    $0x4,%esp
801051c3:	6a 14                	push   $0x14
801051c5:	53                   	push   %ebx
801051c6:	6a 01                	push   $0x1
801051c8:	e8 03 fb ff ff       	call   80104cd0 <argptr>
801051cd:	83 c4 10             	add    $0x10,%esp
801051d0:	85 c0                	test   %eax,%eax
801051d2:	78 1c                	js     801051f0 <sys_fstat+0x60>
  return filestat(f, st);
801051d4:	83 ec 08             	sub    $0x8,%esp
801051d7:	ff 75 f4             	push   -0xc(%ebp)
801051da:	56                   	push   %esi
801051db:	e8 40 be ff ff       	call   80101020 <filestat>
801051e0:	83 c4 10             	add    $0x10,%esp
}
801051e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051e6:	5b                   	pop    %ebx
801051e7:	5e                   	pop    %esi
801051e8:	5d                   	pop    %ebp
801051e9:	c3                   	ret
801051ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801051f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051f5:	eb ec                	jmp    801051e3 <sys_fstat+0x53>
801051f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051fe:	66 90                	xchg   %ax,%ax

80105200 <sys_link>:
{
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	57                   	push   %edi
80105204:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105205:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105208:	53                   	push   %ebx
80105209:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010520c:	50                   	push   %eax
8010520d:	6a 00                	push   $0x0
8010520f:	e8 2c fb ff ff       	call   80104d40 <argstr>
80105214:	83 c4 10             	add    $0x10,%esp
80105217:	85 c0                	test   %eax,%eax
80105219:	0f 88 fb 00 00 00    	js     8010531a <sys_link+0x11a>
8010521f:	83 ec 08             	sub    $0x8,%esp
80105222:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105225:	50                   	push   %eax
80105226:	6a 01                	push   $0x1
80105228:	e8 13 fb ff ff       	call   80104d40 <argstr>
8010522d:	83 c4 10             	add    $0x10,%esp
80105230:	85 c0                	test   %eax,%eax
80105232:	0f 88 e2 00 00 00    	js     8010531a <sys_link+0x11a>
  begin_op();
80105238:	e8 e3 da ff ff       	call   80102d20 <begin_op>
  if((ip = namei(old)) == 0){
8010523d:	83 ec 0c             	sub    $0xc,%esp
80105240:	ff 75 d4             	push   -0x2c(%ebp)
80105243:	e8 d8 ce ff ff       	call   80102120 <namei>
80105248:	83 c4 10             	add    $0x10,%esp
8010524b:	89 c3                	mov    %eax,%ebx
8010524d:	85 c0                	test   %eax,%eax
8010524f:	0f 84 df 00 00 00    	je     80105334 <sys_link+0x134>
  ilock(ip);
80105255:	83 ec 0c             	sub    $0xc,%esp
80105258:	50                   	push   %eax
80105259:	e8 92 c5 ff ff       	call   801017f0 <ilock>
  if(ip->type == T_DIR){
8010525e:	83 c4 10             	add    $0x10,%esp
80105261:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105266:	0f 84 b5 00 00 00    	je     80105321 <sys_link+0x121>
  iupdate(ip);
8010526c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010526f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105274:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105277:	53                   	push   %ebx
80105278:	e8 c3 c4 ff ff       	call   80101740 <iupdate>
  iunlock(ip);
8010527d:	89 1c 24             	mov    %ebx,(%esp)
80105280:	e8 4b c6 ff ff       	call   801018d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105285:	58                   	pop    %eax
80105286:	5a                   	pop    %edx
80105287:	57                   	push   %edi
80105288:	ff 75 d0             	push   -0x30(%ebp)
8010528b:	e8 b0 ce ff ff       	call   80102140 <nameiparent>
80105290:	83 c4 10             	add    $0x10,%esp
80105293:	89 c6                	mov    %eax,%esi
80105295:	85 c0                	test   %eax,%eax
80105297:	74 5b                	je     801052f4 <sys_link+0xf4>
  ilock(dp);
80105299:	83 ec 0c             	sub    $0xc,%esp
8010529c:	50                   	push   %eax
8010529d:	e8 4e c5 ff ff       	call   801017f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801052a2:	8b 03                	mov    (%ebx),%eax
801052a4:	83 c4 10             	add    $0x10,%esp
801052a7:	39 06                	cmp    %eax,(%esi)
801052a9:	75 3d                	jne    801052e8 <sys_link+0xe8>
801052ab:	83 ec 04             	sub    $0x4,%esp
801052ae:	ff 73 04             	push   0x4(%ebx)
801052b1:	57                   	push   %edi
801052b2:	56                   	push   %esi
801052b3:	e8 a8 cd ff ff       	call   80102060 <dirlink>
801052b8:	83 c4 10             	add    $0x10,%esp
801052bb:	85 c0                	test   %eax,%eax
801052bd:	78 29                	js     801052e8 <sys_link+0xe8>
  iunlockput(dp);
801052bf:	83 ec 0c             	sub    $0xc,%esp
801052c2:	56                   	push   %esi
801052c3:	e8 b8 c7 ff ff       	call   80101a80 <iunlockput>
  iput(ip);
801052c8:	89 1c 24             	mov    %ebx,(%esp)
801052cb:	e8 50 c6 ff ff       	call   80101920 <iput>
  end_op();
801052d0:	e8 bb da ff ff       	call   80102d90 <end_op>
  return 0;
801052d5:	83 c4 10             	add    $0x10,%esp
801052d8:	31 c0                	xor    %eax,%eax
}
801052da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052dd:	5b                   	pop    %ebx
801052de:	5e                   	pop    %esi
801052df:	5f                   	pop    %edi
801052e0:	5d                   	pop    %ebp
801052e1:	c3                   	ret
801052e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801052e8:	83 ec 0c             	sub    $0xc,%esp
801052eb:	56                   	push   %esi
801052ec:	e8 8f c7 ff ff       	call   80101a80 <iunlockput>
    goto bad;
801052f1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801052f4:	83 ec 0c             	sub    $0xc,%esp
801052f7:	53                   	push   %ebx
801052f8:	e8 f3 c4 ff ff       	call   801017f0 <ilock>
  ip->nlink--;
801052fd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105302:	89 1c 24             	mov    %ebx,(%esp)
80105305:	e8 36 c4 ff ff       	call   80101740 <iupdate>
  iunlockput(ip);
8010530a:	89 1c 24             	mov    %ebx,(%esp)
8010530d:	e8 6e c7 ff ff       	call   80101a80 <iunlockput>
  end_op();
80105312:	e8 79 da ff ff       	call   80102d90 <end_op>
  return -1;
80105317:	83 c4 10             	add    $0x10,%esp
    return -1;
8010531a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010531f:	eb b9                	jmp    801052da <sys_link+0xda>
    iunlockput(ip);
80105321:	83 ec 0c             	sub    $0xc,%esp
80105324:	53                   	push   %ebx
80105325:	e8 56 c7 ff ff       	call   80101a80 <iunlockput>
    end_op();
8010532a:	e8 61 da ff ff       	call   80102d90 <end_op>
    return -1;
8010532f:	83 c4 10             	add    $0x10,%esp
80105332:	eb e6                	jmp    8010531a <sys_link+0x11a>
    end_op();
80105334:	e8 57 da ff ff       	call   80102d90 <end_op>
    return -1;
80105339:	eb df                	jmp    8010531a <sys_link+0x11a>
8010533b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010533f:	90                   	nop

80105340 <sys_unlink>:
{
80105340:	55                   	push   %ebp
80105341:	89 e5                	mov    %esp,%ebp
80105343:	57                   	push   %edi
80105344:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105345:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105348:	53                   	push   %ebx
80105349:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010534c:	50                   	push   %eax
8010534d:	6a 00                	push   $0x0
8010534f:	e8 ec f9 ff ff       	call   80104d40 <argstr>
80105354:	83 c4 10             	add    $0x10,%esp
80105357:	85 c0                	test   %eax,%eax
80105359:	0f 88 54 01 00 00    	js     801054b3 <sys_unlink+0x173>
  begin_op();
8010535f:	e8 bc d9 ff ff       	call   80102d20 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105364:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105367:	83 ec 08             	sub    $0x8,%esp
8010536a:	53                   	push   %ebx
8010536b:	ff 75 c0             	push   -0x40(%ebp)
8010536e:	e8 cd cd ff ff       	call   80102140 <nameiparent>
80105373:	83 c4 10             	add    $0x10,%esp
80105376:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105379:	85 c0                	test   %eax,%eax
8010537b:	0f 84 58 01 00 00    	je     801054d9 <sys_unlink+0x199>
  ilock(dp);
80105381:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105384:	83 ec 0c             	sub    $0xc,%esp
80105387:	57                   	push   %edi
80105388:	e8 63 c4 ff ff       	call   801017f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010538d:	58                   	pop    %eax
8010538e:	5a                   	pop    %edx
8010538f:	68 14 7c 10 80       	push   $0x80107c14
80105394:	53                   	push   %ebx
80105395:	e8 96 c9 ff ff       	call   80101d30 <namecmp>
8010539a:	83 c4 10             	add    $0x10,%esp
8010539d:	85 c0                	test   %eax,%eax
8010539f:	0f 84 fb 00 00 00    	je     801054a0 <sys_unlink+0x160>
801053a5:	83 ec 08             	sub    $0x8,%esp
801053a8:	68 13 7c 10 80       	push   $0x80107c13
801053ad:	53                   	push   %ebx
801053ae:	e8 7d c9 ff ff       	call   80101d30 <namecmp>
801053b3:	83 c4 10             	add    $0x10,%esp
801053b6:	85 c0                	test   %eax,%eax
801053b8:	0f 84 e2 00 00 00    	je     801054a0 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
801053be:	83 ec 04             	sub    $0x4,%esp
801053c1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801053c4:	50                   	push   %eax
801053c5:	53                   	push   %ebx
801053c6:	57                   	push   %edi
801053c7:	e8 84 c9 ff ff       	call   80101d50 <dirlookup>
801053cc:	83 c4 10             	add    $0x10,%esp
801053cf:	89 c3                	mov    %eax,%ebx
801053d1:	85 c0                	test   %eax,%eax
801053d3:	0f 84 c7 00 00 00    	je     801054a0 <sys_unlink+0x160>
  ilock(ip);
801053d9:	83 ec 0c             	sub    $0xc,%esp
801053dc:	50                   	push   %eax
801053dd:	e8 0e c4 ff ff       	call   801017f0 <ilock>
  if(ip->nlink < 1)
801053e2:	83 c4 10             	add    $0x10,%esp
801053e5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801053ea:	0f 8e 0a 01 00 00    	jle    801054fa <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
801053f0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053f5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801053f8:	74 66                	je     80105460 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801053fa:	83 ec 04             	sub    $0x4,%esp
801053fd:	6a 10                	push   $0x10
801053ff:	6a 00                	push   $0x0
80105401:	57                   	push   %edi
80105402:	e8 c9 f5 ff ff       	call   801049d0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105407:	6a 10                	push   $0x10
80105409:	ff 75 c4             	push   -0x3c(%ebp)
8010540c:	57                   	push   %edi
8010540d:	ff 75 b4             	push   -0x4c(%ebp)
80105410:	e8 eb c7 ff ff       	call   80101c00 <writei>
80105415:	83 c4 20             	add    $0x20,%esp
80105418:	83 f8 10             	cmp    $0x10,%eax
8010541b:	0f 85 cc 00 00 00    	jne    801054ed <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105421:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105426:	0f 84 94 00 00 00    	je     801054c0 <sys_unlink+0x180>
  iunlockput(dp);
8010542c:	83 ec 0c             	sub    $0xc,%esp
8010542f:	ff 75 b4             	push   -0x4c(%ebp)
80105432:	e8 49 c6 ff ff       	call   80101a80 <iunlockput>
  ip->nlink--;
80105437:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010543c:	89 1c 24             	mov    %ebx,(%esp)
8010543f:	e8 fc c2 ff ff       	call   80101740 <iupdate>
  iunlockput(ip);
80105444:	89 1c 24             	mov    %ebx,(%esp)
80105447:	e8 34 c6 ff ff       	call   80101a80 <iunlockput>
  end_op();
8010544c:	e8 3f d9 ff ff       	call   80102d90 <end_op>
  return 0;
80105451:	83 c4 10             	add    $0x10,%esp
80105454:	31 c0                	xor    %eax,%eax
}
80105456:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105459:	5b                   	pop    %ebx
8010545a:	5e                   	pop    %esi
8010545b:	5f                   	pop    %edi
8010545c:	5d                   	pop    %ebp
8010545d:	c3                   	ret
8010545e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105460:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105464:	76 94                	jbe    801053fa <sys_unlink+0xba>
80105466:	be 20 00 00 00       	mov    $0x20,%esi
8010546b:	eb 0b                	jmp    80105478 <sys_unlink+0x138>
8010546d:	8d 76 00             	lea    0x0(%esi),%esi
80105470:	83 c6 10             	add    $0x10,%esi
80105473:	3b 73 58             	cmp    0x58(%ebx),%esi
80105476:	73 82                	jae    801053fa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105478:	6a 10                	push   $0x10
8010547a:	56                   	push   %esi
8010547b:	57                   	push   %edi
8010547c:	53                   	push   %ebx
8010547d:	e8 7e c6 ff ff       	call   80101b00 <readi>
80105482:	83 c4 10             	add    $0x10,%esp
80105485:	83 f8 10             	cmp    $0x10,%eax
80105488:	75 56                	jne    801054e0 <sys_unlink+0x1a0>
    if(de.inum != 0)
8010548a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010548f:	74 df                	je     80105470 <sys_unlink+0x130>
    iunlockput(ip);
80105491:	83 ec 0c             	sub    $0xc,%esp
80105494:	53                   	push   %ebx
80105495:	e8 e6 c5 ff ff       	call   80101a80 <iunlockput>
    goto bad;
8010549a:	83 c4 10             	add    $0x10,%esp
8010549d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
801054a0:	83 ec 0c             	sub    $0xc,%esp
801054a3:	ff 75 b4             	push   -0x4c(%ebp)
801054a6:	e8 d5 c5 ff ff       	call   80101a80 <iunlockput>
  end_op();
801054ab:	e8 e0 d8 ff ff       	call   80102d90 <end_op>
  return -1;
801054b0:	83 c4 10             	add    $0x10,%esp
    return -1;
801054b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054b8:	eb 9c                	jmp    80105456 <sys_unlink+0x116>
801054ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
801054c0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801054c3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801054c6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801054cb:	50                   	push   %eax
801054cc:	e8 6f c2 ff ff       	call   80101740 <iupdate>
801054d1:	83 c4 10             	add    $0x10,%esp
801054d4:	e9 53 ff ff ff       	jmp    8010542c <sys_unlink+0xec>
    end_op();
801054d9:	e8 b2 d8 ff ff       	call   80102d90 <end_op>
    return -1;
801054de:	eb d3                	jmp    801054b3 <sys_unlink+0x173>
      panic("isdirempty: readi");
801054e0:	83 ec 0c             	sub    $0xc,%esp
801054e3:	68 38 7c 10 80       	push   $0x80107c38
801054e8:	e8 93 ae ff ff       	call   80100380 <panic>
    panic("unlink: writei");
801054ed:	83 ec 0c             	sub    $0xc,%esp
801054f0:	68 4a 7c 10 80       	push   $0x80107c4a
801054f5:	e8 86 ae ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
801054fa:	83 ec 0c             	sub    $0xc,%esp
801054fd:	68 26 7c 10 80       	push   $0x80107c26
80105502:	e8 79 ae ff ff       	call   80100380 <panic>
80105507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010550e:	66 90                	xchg   %ax,%ax

80105510 <sys_open>:

int
sys_open(void)
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	57                   	push   %edi
80105514:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105515:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105518:	53                   	push   %ebx
80105519:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010551c:	50                   	push   %eax
8010551d:	6a 00                	push   $0x0
8010551f:	e8 1c f8 ff ff       	call   80104d40 <argstr>
80105524:	83 c4 10             	add    $0x10,%esp
80105527:	85 c0                	test   %eax,%eax
80105529:	0f 88 8e 00 00 00    	js     801055bd <sys_open+0xad>
8010552f:	83 ec 08             	sub    $0x8,%esp
80105532:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105535:	50                   	push   %eax
80105536:	6a 01                	push   $0x1
80105538:	e8 43 f7 ff ff       	call   80104c80 <argint>
8010553d:	83 c4 10             	add    $0x10,%esp
80105540:	85 c0                	test   %eax,%eax
80105542:	78 79                	js     801055bd <sys_open+0xad>
    return -1;

  begin_op();
80105544:	e8 d7 d7 ff ff       	call   80102d20 <begin_op>

  if(omode & O_CREATE){
80105549:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010554d:	75 79                	jne    801055c8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010554f:	83 ec 0c             	sub    $0xc,%esp
80105552:	ff 75 e0             	push   -0x20(%ebp)
80105555:	e8 c6 cb ff ff       	call   80102120 <namei>
8010555a:	83 c4 10             	add    $0x10,%esp
8010555d:	89 c6                	mov    %eax,%esi
8010555f:	85 c0                	test   %eax,%eax
80105561:	0f 84 7e 00 00 00    	je     801055e5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105567:	83 ec 0c             	sub    $0xc,%esp
8010556a:	50                   	push   %eax
8010556b:	e8 80 c2 ff ff       	call   801017f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105570:	83 c4 10             	add    $0x10,%esp
80105573:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105578:	0f 84 ba 00 00 00    	je     80105638 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010557e:	e8 fd b8 ff ff       	call   80100e80 <filealloc>
80105583:	89 c7                	mov    %eax,%edi
80105585:	85 c0                	test   %eax,%eax
80105587:	74 23                	je     801055ac <sys_open+0x9c>
  struct proc *curproc = myproc();
80105589:	e8 d2 e3 ff ff       	call   80103960 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010558e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105590:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105594:	85 d2                	test   %edx,%edx
80105596:	74 58                	je     801055f0 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105598:	83 c3 01             	add    $0x1,%ebx
8010559b:	83 fb 10             	cmp    $0x10,%ebx
8010559e:	75 f0                	jne    80105590 <sys_open+0x80>
    if(f)
      fileclose(f);
801055a0:	83 ec 0c             	sub    $0xc,%esp
801055a3:	57                   	push   %edi
801055a4:	e8 97 b9 ff ff       	call   80100f40 <fileclose>
801055a9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801055ac:	83 ec 0c             	sub    $0xc,%esp
801055af:	56                   	push   %esi
801055b0:	e8 cb c4 ff ff       	call   80101a80 <iunlockput>
    end_op();
801055b5:	e8 d6 d7 ff ff       	call   80102d90 <end_op>
    return -1;
801055ba:	83 c4 10             	add    $0x10,%esp
    return -1;
801055bd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801055c2:	eb 65                	jmp    80105629 <sys_open+0x119>
801055c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801055c8:	83 ec 0c             	sub    $0xc,%esp
801055cb:	31 c9                	xor    %ecx,%ecx
801055cd:	ba 02 00 00 00       	mov    $0x2,%edx
801055d2:	6a 00                	push   $0x0
801055d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801055d7:	e8 54 f8 ff ff       	call   80104e30 <create>
    if(ip == 0){
801055dc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801055df:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801055e1:	85 c0                	test   %eax,%eax
801055e3:	75 99                	jne    8010557e <sys_open+0x6e>
      end_op();
801055e5:	e8 a6 d7 ff ff       	call   80102d90 <end_op>
      return -1;
801055ea:	eb d1                	jmp    801055bd <sys_open+0xad>
801055ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801055f0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801055f3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801055f7:	56                   	push   %esi
801055f8:	e8 d3 c2 ff ff       	call   801018d0 <iunlock>
  end_op();
801055fd:	e8 8e d7 ff ff       	call   80102d90 <end_op>

  f->type = FD_INODE;
80105602:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105608:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010560b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
8010560e:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105611:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105613:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010561a:	f7 d0                	not    %eax
8010561c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010561f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105622:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105625:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105629:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010562c:	89 d8                	mov    %ebx,%eax
8010562e:	5b                   	pop    %ebx
8010562f:	5e                   	pop    %esi
80105630:	5f                   	pop    %edi
80105631:	5d                   	pop    %ebp
80105632:	c3                   	ret
80105633:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105637:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105638:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010563b:	85 c9                	test   %ecx,%ecx
8010563d:	0f 84 3b ff ff ff    	je     8010557e <sys_open+0x6e>
80105643:	e9 64 ff ff ff       	jmp    801055ac <sys_open+0x9c>
80105648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010564f:	90                   	nop

80105650 <sys_mkdir>:

int
sys_mkdir(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105656:	e8 c5 d6 ff ff       	call   80102d20 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010565b:	83 ec 08             	sub    $0x8,%esp
8010565e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105661:	50                   	push   %eax
80105662:	6a 00                	push   $0x0
80105664:	e8 d7 f6 ff ff       	call   80104d40 <argstr>
80105669:	83 c4 10             	add    $0x10,%esp
8010566c:	85 c0                	test   %eax,%eax
8010566e:	78 30                	js     801056a0 <sys_mkdir+0x50>
80105670:	83 ec 0c             	sub    $0xc,%esp
80105673:	31 c9                	xor    %ecx,%ecx
80105675:	ba 01 00 00 00       	mov    $0x1,%edx
8010567a:	6a 00                	push   $0x0
8010567c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010567f:	e8 ac f7 ff ff       	call   80104e30 <create>
80105684:	83 c4 10             	add    $0x10,%esp
80105687:	85 c0                	test   %eax,%eax
80105689:	74 15                	je     801056a0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010568b:	83 ec 0c             	sub    $0xc,%esp
8010568e:	50                   	push   %eax
8010568f:	e8 ec c3 ff ff       	call   80101a80 <iunlockput>
  end_op();
80105694:	e8 f7 d6 ff ff       	call   80102d90 <end_op>
  return 0;
80105699:	83 c4 10             	add    $0x10,%esp
8010569c:	31 c0                	xor    %eax,%eax
}
8010569e:	c9                   	leave
8010569f:	c3                   	ret
    end_op();
801056a0:	e8 eb d6 ff ff       	call   80102d90 <end_op>
    return -1;
801056a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056aa:	c9                   	leave
801056ab:	c3                   	ret
801056ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056b0 <sys_mknod>:

int
sys_mknod(void)
{
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801056b6:	e8 65 d6 ff ff       	call   80102d20 <begin_op>
  if((argstr(0, &path)) < 0 ||
801056bb:	83 ec 08             	sub    $0x8,%esp
801056be:	8d 45 ec             	lea    -0x14(%ebp),%eax
801056c1:	50                   	push   %eax
801056c2:	6a 00                	push   $0x0
801056c4:	e8 77 f6 ff ff       	call   80104d40 <argstr>
801056c9:	83 c4 10             	add    $0x10,%esp
801056cc:	85 c0                	test   %eax,%eax
801056ce:	78 60                	js     80105730 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801056d0:	83 ec 08             	sub    $0x8,%esp
801056d3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056d6:	50                   	push   %eax
801056d7:	6a 01                	push   $0x1
801056d9:	e8 a2 f5 ff ff       	call   80104c80 <argint>
  if((argstr(0, &path)) < 0 ||
801056de:	83 c4 10             	add    $0x10,%esp
801056e1:	85 c0                	test   %eax,%eax
801056e3:	78 4b                	js     80105730 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801056e5:	83 ec 08             	sub    $0x8,%esp
801056e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056eb:	50                   	push   %eax
801056ec:	6a 02                	push   $0x2
801056ee:	e8 8d f5 ff ff       	call   80104c80 <argint>
     argint(1, &major) < 0 ||
801056f3:	83 c4 10             	add    $0x10,%esp
801056f6:	85 c0                	test   %eax,%eax
801056f8:	78 36                	js     80105730 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801056fa:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801056fe:	83 ec 0c             	sub    $0xc,%esp
80105701:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105705:	ba 03 00 00 00       	mov    $0x3,%edx
8010570a:	50                   	push   %eax
8010570b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010570e:	e8 1d f7 ff ff       	call   80104e30 <create>
     argint(2, &minor) < 0 ||
80105713:	83 c4 10             	add    $0x10,%esp
80105716:	85 c0                	test   %eax,%eax
80105718:	74 16                	je     80105730 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010571a:	83 ec 0c             	sub    $0xc,%esp
8010571d:	50                   	push   %eax
8010571e:	e8 5d c3 ff ff       	call   80101a80 <iunlockput>
  end_op();
80105723:	e8 68 d6 ff ff       	call   80102d90 <end_op>
  return 0;
80105728:	83 c4 10             	add    $0x10,%esp
8010572b:	31 c0                	xor    %eax,%eax
}
8010572d:	c9                   	leave
8010572e:	c3                   	ret
8010572f:	90                   	nop
    end_op();
80105730:	e8 5b d6 ff ff       	call   80102d90 <end_op>
    return -1;
80105735:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010573a:	c9                   	leave
8010573b:	c3                   	ret
8010573c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105740 <sys_chdir>:

int
sys_chdir(void)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	56                   	push   %esi
80105744:	53                   	push   %ebx
80105745:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105748:	e8 13 e2 ff ff       	call   80103960 <myproc>
8010574d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010574f:	e8 cc d5 ff ff       	call   80102d20 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105754:	83 ec 08             	sub    $0x8,%esp
80105757:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010575a:	50                   	push   %eax
8010575b:	6a 00                	push   $0x0
8010575d:	e8 de f5 ff ff       	call   80104d40 <argstr>
80105762:	83 c4 10             	add    $0x10,%esp
80105765:	85 c0                	test   %eax,%eax
80105767:	78 77                	js     801057e0 <sys_chdir+0xa0>
80105769:	83 ec 0c             	sub    $0xc,%esp
8010576c:	ff 75 f4             	push   -0xc(%ebp)
8010576f:	e8 ac c9 ff ff       	call   80102120 <namei>
80105774:	83 c4 10             	add    $0x10,%esp
80105777:	89 c3                	mov    %eax,%ebx
80105779:	85 c0                	test   %eax,%eax
8010577b:	74 63                	je     801057e0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010577d:	83 ec 0c             	sub    $0xc,%esp
80105780:	50                   	push   %eax
80105781:	e8 6a c0 ff ff       	call   801017f0 <ilock>
  if(ip->type != T_DIR){
80105786:	83 c4 10             	add    $0x10,%esp
80105789:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010578e:	75 30                	jne    801057c0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105790:	83 ec 0c             	sub    $0xc,%esp
80105793:	53                   	push   %ebx
80105794:	e8 37 c1 ff ff       	call   801018d0 <iunlock>
  iput(curproc->cwd);
80105799:	58                   	pop    %eax
8010579a:	ff 76 68             	push   0x68(%esi)
8010579d:	e8 7e c1 ff ff       	call   80101920 <iput>
  end_op();
801057a2:	e8 e9 d5 ff ff       	call   80102d90 <end_op>
  curproc->cwd = ip;
801057a7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801057aa:	83 c4 10             	add    $0x10,%esp
801057ad:	31 c0                	xor    %eax,%eax
}
801057af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057b2:	5b                   	pop    %ebx
801057b3:	5e                   	pop    %esi
801057b4:	5d                   	pop    %ebp
801057b5:	c3                   	ret
801057b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057bd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
801057c0:	83 ec 0c             	sub    $0xc,%esp
801057c3:	53                   	push   %ebx
801057c4:	e8 b7 c2 ff ff       	call   80101a80 <iunlockput>
    end_op();
801057c9:	e8 c2 d5 ff ff       	call   80102d90 <end_op>
    return -1;
801057ce:	83 c4 10             	add    $0x10,%esp
    return -1;
801057d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057d6:	eb d7                	jmp    801057af <sys_chdir+0x6f>
801057d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057df:	90                   	nop
    end_op();
801057e0:	e8 ab d5 ff ff       	call   80102d90 <end_op>
    return -1;
801057e5:	eb ea                	jmp    801057d1 <sys_chdir+0x91>
801057e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057ee:	66 90                	xchg   %ax,%ax

801057f0 <sys_exec>:

int
sys_exec(void)
{
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	57                   	push   %edi
801057f4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801057f5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801057fb:	53                   	push   %ebx
801057fc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105802:	50                   	push   %eax
80105803:	6a 00                	push   $0x0
80105805:	e8 36 f5 ff ff       	call   80104d40 <argstr>
8010580a:	83 c4 10             	add    $0x10,%esp
8010580d:	85 c0                	test   %eax,%eax
8010580f:	0f 88 87 00 00 00    	js     8010589c <sys_exec+0xac>
80105815:	83 ec 08             	sub    $0x8,%esp
80105818:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010581e:	50                   	push   %eax
8010581f:	6a 01                	push   $0x1
80105821:	e8 5a f4 ff ff       	call   80104c80 <argint>
80105826:	83 c4 10             	add    $0x10,%esp
80105829:	85 c0                	test   %eax,%eax
8010582b:	78 6f                	js     8010589c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010582d:	83 ec 04             	sub    $0x4,%esp
80105830:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105836:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105838:	68 80 00 00 00       	push   $0x80
8010583d:	6a 00                	push   $0x0
8010583f:	56                   	push   %esi
80105840:	e8 8b f1 ff ff       	call   801049d0 <memset>
80105845:	83 c4 10             	add    $0x10,%esp
80105848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010584f:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105850:	83 ec 08             	sub    $0x8,%esp
80105853:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105859:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105860:	50                   	push   %eax
80105861:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105867:	01 f8                	add    %edi,%eax
80105869:	50                   	push   %eax
8010586a:	e8 81 f3 ff ff       	call   80104bf0 <fetchint>
8010586f:	83 c4 10             	add    $0x10,%esp
80105872:	85 c0                	test   %eax,%eax
80105874:	78 26                	js     8010589c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105876:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010587c:	85 c0                	test   %eax,%eax
8010587e:	74 30                	je     801058b0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105880:	83 ec 08             	sub    $0x8,%esp
80105883:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105886:	52                   	push   %edx
80105887:	50                   	push   %eax
80105888:	e8 a3 f3 ff ff       	call   80104c30 <fetchstr>
8010588d:	83 c4 10             	add    $0x10,%esp
80105890:	85 c0                	test   %eax,%eax
80105892:	78 08                	js     8010589c <sys_exec+0xac>
  for(i=0;; i++){
80105894:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105897:	83 fb 20             	cmp    $0x20,%ebx
8010589a:	75 b4                	jne    80105850 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010589c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010589f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058a4:	5b                   	pop    %ebx
801058a5:	5e                   	pop    %esi
801058a6:	5f                   	pop    %edi
801058a7:	5d                   	pop    %ebp
801058a8:	c3                   	ret
801058a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801058b0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801058b7:	00 00 00 00 
  return exec(path, argv);
801058bb:	83 ec 08             	sub    $0x8,%esp
801058be:	56                   	push   %esi
801058bf:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801058c5:	e8 16 b2 ff ff       	call   80100ae0 <exec>
801058ca:	83 c4 10             	add    $0x10,%esp
}
801058cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058d0:	5b                   	pop    %ebx
801058d1:	5e                   	pop    %esi
801058d2:	5f                   	pop    %edi
801058d3:	5d                   	pop    %ebp
801058d4:	c3                   	ret
801058d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058e0 <sys_pipe>:

int
sys_pipe(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	57                   	push   %edi
801058e4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801058e5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801058e8:	53                   	push   %ebx
801058e9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801058ec:	6a 08                	push   $0x8
801058ee:	50                   	push   %eax
801058ef:	6a 00                	push   $0x0
801058f1:	e8 da f3 ff ff       	call   80104cd0 <argptr>
801058f6:	83 c4 10             	add    $0x10,%esp
801058f9:	85 c0                	test   %eax,%eax
801058fb:	0f 88 8b 00 00 00    	js     8010598c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105901:	83 ec 08             	sub    $0x8,%esp
80105904:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105907:	50                   	push   %eax
80105908:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010590b:	50                   	push   %eax
8010590c:	e8 df da ff ff       	call   801033f0 <pipealloc>
80105911:	83 c4 10             	add    $0x10,%esp
80105914:	85 c0                	test   %eax,%eax
80105916:	78 74                	js     8010598c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105918:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010591b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010591d:	e8 3e e0 ff ff       	call   80103960 <myproc>
    if(curproc->ofile[fd] == 0){
80105922:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105926:	85 f6                	test   %esi,%esi
80105928:	74 16                	je     80105940 <sys_pipe+0x60>
8010592a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105930:	83 c3 01             	add    $0x1,%ebx
80105933:	83 fb 10             	cmp    $0x10,%ebx
80105936:	74 3d                	je     80105975 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
80105938:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010593c:	85 f6                	test   %esi,%esi
8010593e:	75 f0                	jne    80105930 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105940:	8d 73 08             	lea    0x8(%ebx),%esi
80105943:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105947:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010594a:	e8 11 e0 ff ff       	call   80103960 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010594f:	31 d2                	xor    %edx,%edx
80105951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105958:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010595c:	85 c9                	test   %ecx,%ecx
8010595e:	74 38                	je     80105998 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80105960:	83 c2 01             	add    $0x1,%edx
80105963:	83 fa 10             	cmp    $0x10,%edx
80105966:	75 f0                	jne    80105958 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105968:	e8 f3 df ff ff       	call   80103960 <myproc>
8010596d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105974:	00 
    fileclose(rf);
80105975:	83 ec 0c             	sub    $0xc,%esp
80105978:	ff 75 e0             	push   -0x20(%ebp)
8010597b:	e8 c0 b5 ff ff       	call   80100f40 <fileclose>
    fileclose(wf);
80105980:	58                   	pop    %eax
80105981:	ff 75 e4             	push   -0x1c(%ebp)
80105984:	e8 b7 b5 ff ff       	call   80100f40 <fileclose>
    return -1;
80105989:	83 c4 10             	add    $0x10,%esp
    return -1;
8010598c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105991:	eb 16                	jmp    801059a9 <sys_pipe+0xc9>
80105993:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105997:	90                   	nop
      curproc->ofile[fd] = f;
80105998:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010599c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010599f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801059a1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801059a4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801059a7:	31 c0                	xor    %eax,%eax
}
801059a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059ac:	5b                   	pop    %ebx
801059ad:	5e                   	pop    %esi
801059ae:	5f                   	pop    %edi
801059af:	5d                   	pop    %ebp
801059b0:	c3                   	ret
801059b1:	66 90                	xchg   %ax,%ax
801059b3:	66 90                	xchg   %ax,%ax
801059b5:	66 90                	xchg   %ax,%ax
801059b7:	66 90                	xchg   %ax,%ax
801059b9:	66 90                	xchg   %ax,%ax
801059bb:	66 90                	xchg   %ax,%ax
801059bd:	66 90                	xchg   %ax,%ax
801059bf:	90                   	nop

801059c0 <sys_mask>:
#include "mmu.h"
#include "proc.h"

int
sys_mask(void)
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	83 ec 20             	sub    $0x20,%esp
  int bit_mask;

  if(argint(0, &bit_mask) < 0)
801059c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059c9:	50                   	push   %eax
801059ca:	6a 00                	push   $0x0
801059cc:	e8 af f2 ff ff       	call   80104c80 <argint>
801059d1:	83 c4 10             	add    $0x10,%esp
801059d4:	85 c0                	test   %eax,%eax
801059d6:	78 18                	js     801059f0 <sys_mask+0x30>
    return -1;
  return mask(bit_mask);
801059d8:	83 ec 0c             	sub    $0xc,%esp
801059db:	ff 75 f4             	push   -0xc(%ebp)
801059de:	e8 7d ea ff ff       	call   80104460 <mask>
801059e3:	83 c4 10             	add    $0x10,%esp
}
801059e6:	c9                   	leave
801059e7:	c3                   	ret
801059e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ef:	90                   	nop
801059f0:	c9                   	leave
    return -1;
801059f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059f6:	c3                   	ret
801059f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059fe:	66 90                	xchg   %ax,%ax

80105a00 <sys_pstat>:

int sys_pstat(void){
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0){
80105a06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a09:	50                   	push   %eax
80105a0a:	6a 00                	push   $0x0
80105a0c:	e8 6f f2 ff ff       	call   80104c80 <argint>
80105a11:	83 c4 10             	add    $0x10,%esp
80105a14:	85 c0                	test   %eax,%eax
80105a16:	78 18                	js     80105a30 <sys_pstat+0x30>
    return -1;
  }
  return p_stat(pid);
80105a18:	83 ec 0c             	sub    $0xc,%esp
80105a1b:	ff 75 f4             	push   -0xc(%ebp)
80105a1e:	e8 9d e9 ff ff       	call   801043c0 <p_stat>
80105a23:	83 c4 10             	add    $0x10,%esp
}
80105a26:	c9                   	leave
80105a27:	c3                   	ret
80105a28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a2f:	90                   	nop
80105a30:	c9                   	leave
    return -1;
80105a31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a36:	c3                   	ret
80105a37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a3e:	66 90                	xchg   %ax,%ax

80105a40 <sys_fork>:

int
sys_fork(void)
{
  return fork();
80105a40:	e9 bb e0 ff ff       	jmp    80103b00 <fork>
80105a45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a50 <sys_exit>:
}

int
sys_exit(void)
{
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	83 ec 08             	sub    $0x8,%esp
  exit();
80105a56:	e8 25 e3 ff ff       	call   80103d80 <exit>
  return 0;  // not reached
}
80105a5b:	31 c0                	xor    %eax,%eax
80105a5d:	c9                   	leave
80105a5e:	c3                   	ret
80105a5f:	90                   	nop

80105a60 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105a60:	e9 4b e4 ff ff       	jmp    80103eb0 <wait>
80105a65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a70 <sys_kill>:
}

int
sys_kill(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105a76:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a79:	50                   	push   %eax
80105a7a:	6a 00                	push   $0x0
80105a7c:	e8 ff f1 ff ff       	call   80104c80 <argint>
80105a81:	83 c4 10             	add    $0x10,%esp
80105a84:	85 c0                	test   %eax,%eax
80105a86:	78 18                	js     80105aa0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105a88:	83 ec 0c             	sub    $0xc,%esp
80105a8b:	ff 75 f4             	push   -0xc(%ebp)
80105a8e:	e8 bd e6 ff ff       	call   80104150 <kill>
80105a93:	83 c4 10             	add    $0x10,%esp
}
80105a96:	c9                   	leave
80105a97:	c3                   	ret
80105a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a9f:	90                   	nop
80105aa0:	c9                   	leave
    return -1;
80105aa1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105aa6:	c3                   	ret
80105aa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aae:	66 90                	xchg   %ax,%ax

80105ab0 <sys_term>:

int
sys_term(void)
{
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105ab6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ab9:	50                   	push   %eax
80105aba:	6a 00                	push   $0x0
80105abc:	e8 bf f1 ff ff       	call   80104c80 <argint>
80105ac1:	83 c4 10             	add    $0x10,%esp
80105ac4:	85 c0                	test   %eax,%eax
80105ac6:	78 18                	js     80105ae0 <sys_term+0x30>
    return -1;
  return term(pid);
80105ac8:	83 ec 0c             	sub    $0xc,%esp
80105acb:	ff 75 f4             	push   -0xc(%ebp)
80105ace:	e8 bd e9 ff ff       	call   80104490 <term>
80105ad3:	83 c4 10             	add    $0x10,%esp
}
80105ad6:	c9                   	leave
80105ad7:	c3                   	ret
80105ad8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105adf:	90                   	nop
80105ae0:	c9                   	leave
    return -1;
80105ae1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ae6:	c3                   	ret
80105ae7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aee:	66 90                	xchg   %ax,%ax

80105af0 <sys_stop>:

int sys_stop (void){
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	83 ec 20             	sub    $0x20,%esp
  int pid;
  if(argint(0, &pid) < 0)
80105af6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105af9:	50                   	push   %eax
80105afa:	6a 00                	push   $0x0
80105afc:	e8 7f f1 ff ff       	call   80104c80 <argint>
80105b01:	83 c4 10             	add    $0x10,%esp
80105b04:	85 c0                	test   %eax,%eax
80105b06:	78 18                	js     80105b20 <sys_stop+0x30>
    return -1;
  return stop(pid);
80105b08:	83 ec 0c             	sub    $0xc,%esp
80105b0b:	ff 75 f4             	push   -0xc(%ebp)
80105b0e:	e8 1d ea ff ff       	call   80104530 <stop>
80105b13:	83 c4 10             	add    $0x10,%esp
}
80105b16:	c9                   	leave
80105b17:	c3                   	ret
80105b18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b1f:	90                   	nop
80105b20:	c9                   	leave
    return -1;
80105b21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b26:	c3                   	ret
80105b27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b2e:	66 90                	xchg   %ax,%ax

80105b30 <sys_cont>:

int sys_cont (void){
80105b30:	55                   	push   %ebp
80105b31:	89 e5                	mov    %esp,%ebp
80105b33:	83 ec 20             	sub    $0x20,%esp
  int pid;
  if(argint(0, &pid) < 0)
80105b36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b39:	50                   	push   %eax
80105b3a:	6a 00                	push   $0x0
80105b3c:	e8 3f f1 ff ff       	call   80104c80 <argint>
80105b41:	83 c4 10             	add    $0x10,%esp
80105b44:	85 c0                	test   %eax,%eax
80105b46:	78 18                	js     80105b60 <sys_cont+0x30>
    return -1;
  return cont(pid);
80105b48:	83 ec 0c             	sub    $0xc,%esp
80105b4b:	ff 75 f4             	push   -0xc(%ebp)
80105b4e:	e8 5d ea ff ff       	call   801045b0 <cont>
80105b53:	83 c4 10             	add    $0x10,%esp
}
80105b56:	c9                   	leave
80105b57:	c3                   	ret
80105b58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b5f:	90                   	nop
80105b60:	c9                   	leave
    return -1;
80105b61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b66:	c3                   	ret
80105b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b6e:	66 90                	xchg   %ax,%ax

80105b70 <sys_getpid>:

int
sys_getpid(void)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105b76:	e8 e5 dd ff ff       	call   80103960 <myproc>
80105b7b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105b7e:	c9                   	leave
80105b7f:	c3                   	ret

80105b80 <sys_sbrk>:

int
sys_sbrk(void)
{
80105b80:	55                   	push   %ebp
80105b81:	89 e5                	mov    %esp,%ebp
80105b83:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105b84:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b87:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105b8a:	50                   	push   %eax
80105b8b:	6a 00                	push   $0x0
80105b8d:	e8 ee f0 ff ff       	call   80104c80 <argint>
80105b92:	83 c4 10             	add    $0x10,%esp
80105b95:	85 c0                	test   %eax,%eax
80105b97:	78 27                	js     80105bc0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105b99:	e8 c2 dd ff ff       	call   80103960 <myproc>
  if(growproc(n) < 0)
80105b9e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105ba1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105ba3:	ff 75 f4             	push   -0xc(%ebp)
80105ba6:	e8 d5 de ff ff       	call   80103a80 <growproc>
80105bab:	83 c4 10             	add    $0x10,%esp
80105bae:	85 c0                	test   %eax,%eax
80105bb0:	78 0e                	js     80105bc0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105bb2:	89 d8                	mov    %ebx,%eax
80105bb4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bb7:	c9                   	leave
80105bb8:	c3                   	ret
80105bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105bc0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105bc5:	eb eb                	jmp    80105bb2 <sys_sbrk+0x32>
80105bc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bce:	66 90                	xchg   %ax,%ax

80105bd0 <sys_sleep>:

int
sys_sleep(void)
{
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105bd4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105bd7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105bda:	50                   	push   %eax
80105bdb:	6a 00                	push   $0x0
80105bdd:	e8 9e f0 ff ff       	call   80104c80 <argint>
80105be2:	83 c4 10             	add    $0x10,%esp
80105be5:	85 c0                	test   %eax,%eax
80105be7:	78 64                	js     80105c4d <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80105be9:	83 ec 0c             	sub    $0xc,%esp
80105bec:	68 60 e8 11 80       	push   $0x8011e860
80105bf1:	e8 4a ec ff ff       	call   80104840 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105bf6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105bf9:	8b 1d 40 e8 11 80    	mov    0x8011e840,%ebx
  while(ticks - ticks0 < n){
80105bff:	83 c4 10             	add    $0x10,%esp
80105c02:	85 d2                	test   %edx,%edx
80105c04:	75 2b                	jne    80105c31 <sys_sleep+0x61>
80105c06:	eb 58                	jmp    80105c60 <sys_sleep+0x90>
80105c08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c0f:	90                   	nop
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105c10:	83 ec 08             	sub    $0x8,%esp
80105c13:	68 60 e8 11 80       	push   $0x8011e860
80105c18:	68 40 e8 11 80       	push   $0x8011e840
80105c1d:	e8 0e e4 ff ff       	call   80104030 <sleep>
  while(ticks - ticks0 < n){
80105c22:	a1 40 e8 11 80       	mov    0x8011e840,%eax
80105c27:	83 c4 10             	add    $0x10,%esp
80105c2a:	29 d8                	sub    %ebx,%eax
80105c2c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105c2f:	73 2f                	jae    80105c60 <sys_sleep+0x90>
    if(myproc()->killed){
80105c31:	e8 2a dd ff ff       	call   80103960 <myproc>
80105c36:	8b 40 24             	mov    0x24(%eax),%eax
80105c39:	85 c0                	test   %eax,%eax
80105c3b:	74 d3                	je     80105c10 <sys_sleep+0x40>
      release(&tickslock);
80105c3d:	83 ec 0c             	sub    $0xc,%esp
80105c40:	68 60 e8 11 80       	push   $0x8011e860
80105c45:	e8 36 ed ff ff       	call   80104980 <release>
      return -1;
80105c4a:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
80105c4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c55:	c9                   	leave
80105c56:	c3                   	ret
80105c57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c5e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105c60:	83 ec 0c             	sub    $0xc,%esp
80105c63:	68 60 e8 11 80       	push   $0x8011e860
80105c68:	e8 13 ed ff ff       	call   80104980 <release>
}
80105c6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80105c70:	83 c4 10             	add    $0x10,%esp
80105c73:	31 c0                	xor    %eax,%eax
}
80105c75:	c9                   	leave
80105c76:	c3                   	ret
80105c77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c7e:	66 90                	xchg   %ax,%ax

80105c80 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	53                   	push   %ebx
80105c84:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105c87:	68 60 e8 11 80       	push   $0x8011e860
80105c8c:	e8 af eb ff ff       	call   80104840 <acquire>
  xticks = ticks;
80105c91:	8b 1d 40 e8 11 80    	mov    0x8011e840,%ebx
  release(&tickslock);
80105c97:	c7 04 24 60 e8 11 80 	movl   $0x8011e860,(%esp)
80105c9e:	e8 dd ec ff ff       	call   80104980 <release>
  return xticks;
}
80105ca3:	89 d8                	mov    %ebx,%eax
80105ca5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ca8:	c9                   	leave
80105ca9:	c3                   	ret
80105caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105cb0 <sys_shutdown>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105cb0:	b8 00 20 00 00       	mov    $0x2000,%eax
80105cb5:	ba 04 b0 ff ff       	mov    $0xffffb004,%edx
80105cba:	66 ef                	out    %ax,(%dx)
80105cbc:	ba 04 06 00 00       	mov    $0x604,%edx
80105cc1:	66 ef                	out    %ax,(%dx)
  /* Either of the following will work. Does not harm to put them together. */
  outw(0xB004, 0x0|0x2000); // working for old qemu
  outw(0x604, 0x0|0x2000); // working for newer qemu
  
  return 0;
}
80105cc3:	31 c0                	xor    %eax,%eax
80105cc5:	c3                   	ret
80105cc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ccd:	8d 76 00             	lea    0x0(%esi),%esi

80105cd0 <sys_cps>:

int
sys_cps(void)
{
  return cps();
80105cd0:	e9 cb e5 ff ff       	jmp    801042a0 <cps>
80105cd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ce0 <sys_chpr>:
}

int
sys_chpr(void)
{
80105ce0:	55                   	push   %ebp
80105ce1:	89 e5                	mov    %esp,%ebp
80105ce3:	83 ec 20             	sub    $0x20,%esp
  int pid, pr;
  if(argint(0, &pid) < 0)
80105ce6:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ce9:	50                   	push   %eax
80105cea:	6a 00                	push   $0x0
80105cec:	e8 8f ef ff ff       	call   80104c80 <argint>
80105cf1:	83 c4 10             	add    $0x10,%esp
80105cf4:	85 c0                	test   %eax,%eax
80105cf6:	78 28                	js     80105d20 <sys_chpr+0x40>
    return -1;
  if(argint(1, &pr) < 0)
80105cf8:	83 ec 08             	sub    $0x8,%esp
80105cfb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cfe:	50                   	push   %eax
80105cff:	6a 01                	push   $0x1
80105d01:	e8 7a ef ff ff       	call   80104c80 <argint>
80105d06:	83 c4 10             	add    $0x10,%esp
80105d09:	85 c0                	test   %eax,%eax
80105d0b:	78 13                	js     80105d20 <sys_chpr+0x40>
    return -1;

  return chpr(pid, pr);
80105d0d:	83 ec 08             	sub    $0x8,%esp
80105d10:	ff 75 f4             	push   -0xc(%ebp)
80105d13:	ff 75 f0             	push   -0x10(%ebp)
80105d16:	e8 55 e6 ff ff       	call   80104370 <chpr>
80105d1b:	83 c4 10             	add    $0x10,%esp
}
80105d1e:	c9                   	leave
80105d1f:	c3                   	ret
80105d20:	c9                   	leave
    return -1;
80105d21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d26:	c3                   	ret

80105d27 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105d27:	1e                   	push   %ds
  pushl %es
80105d28:	06                   	push   %es
  pushl %fs
80105d29:	0f a0                	push   %fs
  pushl %gs
80105d2b:	0f a8                	push   %gs
  pushal
80105d2d:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105d2e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105d32:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105d34:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105d36:	54                   	push   %esp
  call trap
80105d37:	e8 c4 00 00 00       	call   80105e00 <trap>
  addl $4, %esp
80105d3c:	83 c4 04             	add    $0x4,%esp

80105d3f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105d3f:	61                   	popa
  popl %gs
80105d40:	0f a9                	pop    %gs
  popl %fs
80105d42:	0f a1                	pop    %fs
  popl %es
80105d44:	07                   	pop    %es
  popl %ds
80105d45:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105d46:	83 c4 08             	add    $0x8,%esp
  iret
80105d49:	cf                   	iret
80105d4a:	66 90                	xchg   %ax,%ax
80105d4c:	66 90                	xchg   %ax,%ax
80105d4e:	66 90                	xchg   %ax,%ax

80105d50 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105d50:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105d51:	31 c0                	xor    %eax,%eax
{
80105d53:	89 e5                	mov    %esp,%ebp
80105d55:	83 ec 08             	sub    $0x8,%esp
80105d58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d5f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105d60:	8b 14 85 08 90 10 80 	mov    -0x7fef6ff8(,%eax,4),%edx
80105d67:	c7 04 c5 a2 e8 11 80 	movl   $0x8e000008,-0x7fee175e(,%eax,8)
80105d6e:	08 00 00 8e 
80105d72:	66 89 14 c5 a0 e8 11 	mov    %dx,-0x7fee1760(,%eax,8)
80105d79:	80 
80105d7a:	c1 ea 10             	shr    $0x10,%edx
80105d7d:	66 89 14 c5 a6 e8 11 	mov    %dx,-0x7fee175a(,%eax,8)
80105d84:	80 
  for(i = 0; i < 256; i++)
80105d85:	83 c0 01             	add    $0x1,%eax
80105d88:	3d 00 01 00 00       	cmp    $0x100,%eax
80105d8d:	75 d1                	jne    80105d60 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105d8f:	a1 08 91 10 80       	mov    0x80109108,%eax

  initlock(&tickslock, "time");
80105d94:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105d97:	c7 05 a2 ea 11 80 08 	movl   $0xef000008,0x8011eaa2
80105d9e:	00 00 ef 
80105da1:	66 a3 a0 ea 11 80    	mov    %ax,0x8011eaa0
80105da7:	c1 e8 10             	shr    $0x10,%eax
80105daa:	66 a3 a6 ea 11 80    	mov    %ax,0x8011eaa6
  initlock(&tickslock, "time");
80105db0:	68 59 7c 10 80       	push   $0x80107c59
80105db5:	68 60 e8 11 80       	push   $0x8011e860
80105dba:	e8 61 e9 ff ff       	call   80104720 <initlock>
}
80105dbf:	83 c4 10             	add    $0x10,%esp
80105dc2:	c9                   	leave
80105dc3:	c3                   	ret
80105dc4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105dcf:	90                   	nop

80105dd0 <idtinit>:

void
idtinit(void)
{
80105dd0:	55                   	push   %ebp
  pd[0] = size-1;
80105dd1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105dd6:	89 e5                	mov    %esp,%ebp
80105dd8:	83 ec 10             	sub    $0x10,%esp
80105ddb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105ddf:	b8 a0 e8 11 80       	mov    $0x8011e8a0,%eax
80105de4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105de8:	c1 e8 10             	shr    $0x10,%eax
80105deb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105def:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105df2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105df5:	c9                   	leave
80105df6:	c3                   	ret
80105df7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dfe:	66 90                	xchg   %ax,%ax

80105e00 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	57                   	push   %edi
80105e04:	56                   	push   %esi
80105e05:	53                   	push   %ebx
80105e06:	83 ec 1c             	sub    $0x1c,%esp
80105e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105e0c:	8b 43 30             	mov    0x30(%ebx),%eax
80105e0f:	83 f8 40             	cmp    $0x40,%eax
80105e12:	0f 84 68 01 00 00    	je     80105f80 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105e18:	83 e8 20             	sub    $0x20,%eax
80105e1b:	83 f8 1f             	cmp    $0x1f,%eax
80105e1e:	0f 87 8c 00 00 00    	ja     80105eb0 <trap+0xb0>
80105e24:	ff 24 85 00 7d 10 80 	jmp    *-0x7fef8300(,%eax,4)
80105e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e2f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105e30:	e8 9b c4 ff ff       	call   801022d0 <ideintr>
    lapiceoi();
80105e35:	e8 96 ca ff ff       	call   801028d0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e3a:	e8 21 db ff ff       	call   80103960 <myproc>
80105e3f:	85 c0                	test   %eax,%eax
80105e41:	74 1d                	je     80105e60 <trap+0x60>
80105e43:	e8 18 db ff ff       	call   80103960 <myproc>
80105e48:	8b 50 24             	mov    0x24(%eax),%edx
80105e4b:	85 d2                	test   %edx,%edx
80105e4d:	74 11                	je     80105e60 <trap+0x60>
80105e4f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105e53:	83 e0 03             	and    $0x3,%eax
80105e56:	66 83 f8 03          	cmp    $0x3,%ax
80105e5a:	0f 84 e8 01 00 00    	je     80106048 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105e60:	e8 fb da ff ff       	call   80103960 <myproc>
80105e65:	85 c0                	test   %eax,%eax
80105e67:	74 0f                	je     80105e78 <trap+0x78>
80105e69:	e8 f2 da ff ff       	call   80103960 <myproc>
80105e6e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105e72:	0f 84 b8 00 00 00    	je     80105f30 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e78:	e8 e3 da ff ff       	call   80103960 <myproc>
80105e7d:	85 c0                	test   %eax,%eax
80105e7f:	74 1d                	je     80105e9e <trap+0x9e>
80105e81:	e8 da da ff ff       	call   80103960 <myproc>
80105e86:	8b 40 24             	mov    0x24(%eax),%eax
80105e89:	85 c0                	test   %eax,%eax
80105e8b:	74 11                	je     80105e9e <trap+0x9e>
80105e8d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105e91:	83 e0 03             	and    $0x3,%eax
80105e94:	66 83 f8 03          	cmp    $0x3,%ax
80105e98:	0f 84 0f 01 00 00    	je     80105fad <trap+0x1ad>
    exit();
}
80105e9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ea1:	5b                   	pop    %ebx
80105ea2:	5e                   	pop    %esi
80105ea3:	5f                   	pop    %edi
80105ea4:	5d                   	pop    %ebp
80105ea5:	c3                   	ret
80105ea6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ead:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80105eb0:	e8 ab da ff ff       	call   80103960 <myproc>
80105eb5:	8b 7b 38             	mov    0x38(%ebx),%edi
80105eb8:	85 c0                	test   %eax,%eax
80105eba:	0f 84 a2 01 00 00    	je     80106062 <trap+0x262>
80105ec0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105ec4:	0f 84 98 01 00 00    	je     80106062 <trap+0x262>
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105eca:	0f 20 d1             	mov    %cr2,%ecx
80105ecd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ed0:	e8 6b da ff ff       	call   80103940 <cpuid>
80105ed5:	8b 73 30             	mov    0x30(%ebx),%esi
80105ed8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105edb:	8b 43 34             	mov    0x34(%ebx),%eax
80105ede:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105ee1:	e8 7a da ff ff       	call   80103960 <myproc>
80105ee6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105ee9:	e8 72 da ff ff       	call   80103960 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105eee:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105ef1:	51                   	push   %ecx
80105ef2:	57                   	push   %edi
80105ef3:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105ef6:	52                   	push   %edx
80105ef7:	ff 75 e4             	push   -0x1c(%ebp)
80105efa:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105efb:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105efe:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f01:	56                   	push   %esi
80105f02:	ff 70 10             	push   0x10(%eax)
80105f05:	68 bc 7c 10 80       	push   $0x80107cbc
80105f0a:	e8 a1 a7 ff ff       	call   801006b0 <cprintf>
    myproc()->killed = 1;
80105f0f:	83 c4 20             	add    $0x20,%esp
80105f12:	e8 49 da ff ff       	call   80103960 <myproc>
80105f17:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f1e:	e8 3d da ff ff       	call   80103960 <myproc>
80105f23:	85 c0                	test   %eax,%eax
80105f25:	0f 85 18 ff ff ff    	jne    80105e43 <trap+0x43>
80105f2b:	e9 30 ff ff ff       	jmp    80105e60 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80105f30:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105f34:	0f 85 3e ff ff ff    	jne    80105e78 <trap+0x78>
    yield();
80105f3a:	e8 a1 e0 ff ff       	call   80103fe0 <yield>
80105f3f:	e9 34 ff ff ff       	jmp    80105e78 <trap+0x78>
80105f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105f48:	8b 7b 38             	mov    0x38(%ebx),%edi
80105f4b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105f4f:	e8 ec d9 ff ff       	call   80103940 <cpuid>
80105f54:	57                   	push   %edi
80105f55:	56                   	push   %esi
80105f56:	50                   	push   %eax
80105f57:	68 64 7c 10 80       	push   $0x80107c64
80105f5c:	e8 4f a7 ff ff       	call   801006b0 <cprintf>
    lapiceoi();
80105f61:	e8 6a c9 ff ff       	call   801028d0 <lapiceoi>
    break;
80105f66:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f69:	e8 f2 d9 ff ff       	call   80103960 <myproc>
80105f6e:	85 c0                	test   %eax,%eax
80105f70:	0f 85 cd fe ff ff    	jne    80105e43 <trap+0x43>
80105f76:	e9 e5 fe ff ff       	jmp    80105e60 <trap+0x60>
80105f7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f7f:	90                   	nop
    if(myproc()->killed)
80105f80:	e8 db d9 ff ff       	call   80103960 <myproc>
80105f85:	8b 70 24             	mov    0x24(%eax),%esi
80105f88:	85 f6                	test   %esi,%esi
80105f8a:	0f 85 c8 00 00 00    	jne    80106058 <trap+0x258>
    myproc()->tf = tf;
80105f90:	e8 cb d9 ff ff       	call   80103960 <myproc>
80105f95:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105f98:	e8 23 ee ff ff       	call   80104dc0 <syscall>
    if(myproc()->killed)
80105f9d:	e8 be d9 ff ff       	call   80103960 <myproc>
80105fa2:	8b 48 24             	mov    0x24(%eax),%ecx
80105fa5:	85 c9                	test   %ecx,%ecx
80105fa7:	0f 84 f1 fe ff ff    	je     80105e9e <trap+0x9e>
}
80105fad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fb0:	5b                   	pop    %ebx
80105fb1:	5e                   	pop    %esi
80105fb2:	5f                   	pop    %edi
80105fb3:	5d                   	pop    %ebp
      exit();
80105fb4:	e9 c7 dd ff ff       	jmp    80103d80 <exit>
80105fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105fc0:	e8 4b 02 00 00       	call   80106210 <uartintr>
    lapiceoi();
80105fc5:	e8 06 c9 ff ff       	call   801028d0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105fca:	e8 91 d9 ff ff       	call   80103960 <myproc>
80105fcf:	85 c0                	test   %eax,%eax
80105fd1:	0f 85 6c fe ff ff    	jne    80105e43 <trap+0x43>
80105fd7:	e9 84 fe ff ff       	jmp    80105e60 <trap+0x60>
80105fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105fe0:	e8 ab c7 ff ff       	call   80102790 <kbdintr>
    lapiceoi();
80105fe5:	e8 e6 c8 ff ff       	call   801028d0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105fea:	e8 71 d9 ff ff       	call   80103960 <myproc>
80105fef:	85 c0                	test   %eax,%eax
80105ff1:	0f 85 4c fe ff ff    	jne    80105e43 <trap+0x43>
80105ff7:	e9 64 fe ff ff       	jmp    80105e60 <trap+0x60>
80105ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106000:	e8 3b d9 ff ff       	call   80103940 <cpuid>
80106005:	85 c0                	test   %eax,%eax
80106007:	0f 85 28 fe ff ff    	jne    80105e35 <trap+0x35>
      acquire(&tickslock);
8010600d:	83 ec 0c             	sub    $0xc,%esp
80106010:	68 60 e8 11 80       	push   $0x8011e860
80106015:	e8 26 e8 ff ff       	call   80104840 <acquire>
      ticks++;
8010601a:	83 05 40 e8 11 80 01 	addl   $0x1,0x8011e840
      wakeup(&ticks);
80106021:	c7 04 24 40 e8 11 80 	movl   $0x8011e840,(%esp)
80106028:	e8 c3 e0 ff ff       	call   801040f0 <wakeup>
      release(&tickslock);
8010602d:	c7 04 24 60 e8 11 80 	movl   $0x8011e860,(%esp)
80106034:	e8 47 e9 ff ff       	call   80104980 <release>
80106039:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010603c:	e9 f4 fd ff ff       	jmp    80105e35 <trap+0x35>
80106041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106048:	e8 33 dd ff ff       	call   80103d80 <exit>
8010604d:	e9 0e fe ff ff       	jmp    80105e60 <trap+0x60>
80106052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106058:	e8 23 dd ff ff       	call   80103d80 <exit>
8010605d:	e9 2e ff ff ff       	jmp    80105f90 <trap+0x190>
80106062:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106065:	e8 d6 d8 ff ff       	call   80103940 <cpuid>
8010606a:	83 ec 0c             	sub    $0xc,%esp
8010606d:	56                   	push   %esi
8010606e:	57                   	push   %edi
8010606f:	50                   	push   %eax
80106070:	ff 73 30             	push   0x30(%ebx)
80106073:	68 88 7c 10 80       	push   $0x80107c88
80106078:	e8 33 a6 ff ff       	call   801006b0 <cprintf>
      panic("trap");
8010607d:	83 c4 14             	add    $0x14,%esp
80106080:	68 5e 7c 10 80       	push   $0x80107c5e
80106085:	e8 f6 a2 ff ff       	call   80100380 <panic>
8010608a:	66 90                	xchg   %ax,%ax
8010608c:	66 90                	xchg   %ax,%ax
8010608e:	66 90                	xchg   %ax,%ax

80106090 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106090:	a1 a0 f0 11 80       	mov    0x8011f0a0,%eax
80106095:	85 c0                	test   %eax,%eax
80106097:	74 17                	je     801060b0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106099:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010609e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010609f:	a8 01                	test   $0x1,%al
801060a1:	74 0d                	je     801060b0 <uartgetc+0x20>
801060a3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060a8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801060a9:	0f b6 c0             	movzbl %al,%eax
801060ac:	c3                   	ret
801060ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801060b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060b5:	c3                   	ret
801060b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060bd:	8d 76 00             	lea    0x0(%esi),%esi

801060c0 <uartinit>:
{
801060c0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801060c1:	31 c9                	xor    %ecx,%ecx
801060c3:	89 c8                	mov    %ecx,%eax
801060c5:	89 e5                	mov    %esp,%ebp
801060c7:	57                   	push   %edi
801060c8:	bf fa 03 00 00       	mov    $0x3fa,%edi
801060cd:	56                   	push   %esi
801060ce:	89 fa                	mov    %edi,%edx
801060d0:	53                   	push   %ebx
801060d1:	83 ec 1c             	sub    $0x1c,%esp
801060d4:	ee                   	out    %al,(%dx)
801060d5:	be fb 03 00 00       	mov    $0x3fb,%esi
801060da:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801060df:	89 f2                	mov    %esi,%edx
801060e1:	ee                   	out    %al,(%dx)
801060e2:	b8 0c 00 00 00       	mov    $0xc,%eax
801060e7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060ec:	ee                   	out    %al,(%dx)
801060ed:	bb f9 03 00 00       	mov    $0x3f9,%ebx
801060f2:	89 c8                	mov    %ecx,%eax
801060f4:	89 da                	mov    %ebx,%edx
801060f6:	ee                   	out    %al,(%dx)
801060f7:	b8 03 00 00 00       	mov    $0x3,%eax
801060fc:	89 f2                	mov    %esi,%edx
801060fe:	ee                   	out    %al,(%dx)
801060ff:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106104:	89 c8                	mov    %ecx,%eax
80106106:	ee                   	out    %al,(%dx)
80106107:	b8 01 00 00 00       	mov    $0x1,%eax
8010610c:	89 da                	mov    %ebx,%edx
8010610e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010610f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106114:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106115:	3c ff                	cmp    $0xff,%al
80106117:	0f 84 7c 00 00 00    	je     80106199 <uartinit+0xd9>
  uart = 1;
8010611d:	c7 05 a0 f0 11 80 01 	movl   $0x1,0x8011f0a0
80106124:	00 00 00 
80106127:	89 fa                	mov    %edi,%edx
80106129:	ec                   	in     (%dx),%al
8010612a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010612f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106130:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106133:	bf 80 7d 10 80       	mov    $0x80107d80,%edi
80106138:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
8010613d:	6a 00                	push   $0x0
8010613f:	6a 04                	push   $0x4
80106141:	e8 ba c3 ff ff       	call   80102500 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80106146:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
8010614a:	83 c4 10             	add    $0x10,%esp
8010614d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80106150:	a1 a0 f0 11 80       	mov    0x8011f0a0,%eax
80106155:	85 c0                	test   %eax,%eax
80106157:	74 32                	je     8010618b <uartinit+0xcb>
80106159:	89 f2                	mov    %esi,%edx
8010615b:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010615c:	a8 20                	test   $0x20,%al
8010615e:	75 21                	jne    80106181 <uartinit+0xc1>
80106160:	bb 80 00 00 00       	mov    $0x80,%ebx
80106165:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80106168:	83 ec 0c             	sub    $0xc,%esp
8010616b:	6a 0a                	push   $0xa
8010616d:	e8 7e c7 ff ff       	call   801028f0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106172:	83 c4 10             	add    $0x10,%esp
80106175:	83 eb 01             	sub    $0x1,%ebx
80106178:	74 07                	je     80106181 <uartinit+0xc1>
8010617a:	89 f2                	mov    %esi,%edx
8010617c:	ec                   	in     (%dx),%al
8010617d:	a8 20                	test   $0x20,%al
8010617f:	74 e7                	je     80106168 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106181:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106186:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010618a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
8010618b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
8010618f:	83 c7 01             	add    $0x1,%edi
80106192:	88 45 e7             	mov    %al,-0x19(%ebp)
80106195:	84 c0                	test   %al,%al
80106197:	75 b7                	jne    80106150 <uartinit+0x90>
}
80106199:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010619c:	5b                   	pop    %ebx
8010619d:	5e                   	pop    %esi
8010619e:	5f                   	pop    %edi
8010619f:	5d                   	pop    %ebp
801061a0:	c3                   	ret
801061a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061af:	90                   	nop

801061b0 <uartputc>:
  if(!uart)
801061b0:	a1 a0 f0 11 80       	mov    0x8011f0a0,%eax
801061b5:	85 c0                	test   %eax,%eax
801061b7:	74 4f                	je     80106208 <uartputc+0x58>
{
801061b9:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801061ba:	ba fd 03 00 00       	mov    $0x3fd,%edx
801061bf:	89 e5                	mov    %esp,%ebp
801061c1:	56                   	push   %esi
801061c2:	53                   	push   %ebx
801061c3:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801061c4:	a8 20                	test   $0x20,%al
801061c6:	75 29                	jne    801061f1 <uartputc+0x41>
801061c8:	bb 80 00 00 00       	mov    $0x80,%ebx
801061cd:	be fd 03 00 00       	mov    $0x3fd,%esi
801061d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
801061d8:	83 ec 0c             	sub    $0xc,%esp
801061db:	6a 0a                	push   $0xa
801061dd:	e8 0e c7 ff ff       	call   801028f0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801061e2:	83 c4 10             	add    $0x10,%esp
801061e5:	83 eb 01             	sub    $0x1,%ebx
801061e8:	74 07                	je     801061f1 <uartputc+0x41>
801061ea:	89 f2                	mov    %esi,%edx
801061ec:	ec                   	in     (%dx),%al
801061ed:	a8 20                	test   $0x20,%al
801061ef:	74 e7                	je     801061d8 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801061f1:	8b 45 08             	mov    0x8(%ebp),%eax
801061f4:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061f9:	ee                   	out    %al,(%dx)
}
801061fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801061fd:	5b                   	pop    %ebx
801061fe:	5e                   	pop    %esi
801061ff:	5d                   	pop    %ebp
80106200:	c3                   	ret
80106201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106208:	c3                   	ret
80106209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106210 <uartintr>:

void
uartintr(void)
{
80106210:	55                   	push   %ebp
80106211:	89 e5                	mov    %esp,%ebp
80106213:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106216:	68 90 60 10 80       	push   $0x80106090
8010621b:	e8 a0 a6 ff ff       	call   801008c0 <consoleintr>
}
80106220:	83 c4 10             	add    $0x10,%esp
80106223:	c9                   	leave
80106224:	c3                   	ret

80106225 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106225:	6a 00                	push   $0x0
  pushl $0
80106227:	6a 00                	push   $0x0
  jmp alltraps
80106229:	e9 f9 fa ff ff       	jmp    80105d27 <alltraps>

8010622e <vector1>:
.globl vector1
vector1:
  pushl $0
8010622e:	6a 00                	push   $0x0
  pushl $1
80106230:	6a 01                	push   $0x1
  jmp alltraps
80106232:	e9 f0 fa ff ff       	jmp    80105d27 <alltraps>

80106237 <vector2>:
.globl vector2
vector2:
  pushl $0
80106237:	6a 00                	push   $0x0
  pushl $2
80106239:	6a 02                	push   $0x2
  jmp alltraps
8010623b:	e9 e7 fa ff ff       	jmp    80105d27 <alltraps>

80106240 <vector3>:
.globl vector3
vector3:
  pushl $0
80106240:	6a 00                	push   $0x0
  pushl $3
80106242:	6a 03                	push   $0x3
  jmp alltraps
80106244:	e9 de fa ff ff       	jmp    80105d27 <alltraps>

80106249 <vector4>:
.globl vector4
vector4:
  pushl $0
80106249:	6a 00                	push   $0x0
  pushl $4
8010624b:	6a 04                	push   $0x4
  jmp alltraps
8010624d:	e9 d5 fa ff ff       	jmp    80105d27 <alltraps>

80106252 <vector5>:
.globl vector5
vector5:
  pushl $0
80106252:	6a 00                	push   $0x0
  pushl $5
80106254:	6a 05                	push   $0x5
  jmp alltraps
80106256:	e9 cc fa ff ff       	jmp    80105d27 <alltraps>

8010625b <vector6>:
.globl vector6
vector6:
  pushl $0
8010625b:	6a 00                	push   $0x0
  pushl $6
8010625d:	6a 06                	push   $0x6
  jmp alltraps
8010625f:	e9 c3 fa ff ff       	jmp    80105d27 <alltraps>

80106264 <vector7>:
.globl vector7
vector7:
  pushl $0
80106264:	6a 00                	push   $0x0
  pushl $7
80106266:	6a 07                	push   $0x7
  jmp alltraps
80106268:	e9 ba fa ff ff       	jmp    80105d27 <alltraps>

8010626d <vector8>:
.globl vector8
vector8:
  pushl $8
8010626d:	6a 08                	push   $0x8
  jmp alltraps
8010626f:	e9 b3 fa ff ff       	jmp    80105d27 <alltraps>

80106274 <vector9>:
.globl vector9
vector9:
  pushl $0
80106274:	6a 00                	push   $0x0
  pushl $9
80106276:	6a 09                	push   $0x9
  jmp alltraps
80106278:	e9 aa fa ff ff       	jmp    80105d27 <alltraps>

8010627d <vector10>:
.globl vector10
vector10:
  pushl $10
8010627d:	6a 0a                	push   $0xa
  jmp alltraps
8010627f:	e9 a3 fa ff ff       	jmp    80105d27 <alltraps>

80106284 <vector11>:
.globl vector11
vector11:
  pushl $11
80106284:	6a 0b                	push   $0xb
  jmp alltraps
80106286:	e9 9c fa ff ff       	jmp    80105d27 <alltraps>

8010628b <vector12>:
.globl vector12
vector12:
  pushl $12
8010628b:	6a 0c                	push   $0xc
  jmp alltraps
8010628d:	e9 95 fa ff ff       	jmp    80105d27 <alltraps>

80106292 <vector13>:
.globl vector13
vector13:
  pushl $13
80106292:	6a 0d                	push   $0xd
  jmp alltraps
80106294:	e9 8e fa ff ff       	jmp    80105d27 <alltraps>

80106299 <vector14>:
.globl vector14
vector14:
  pushl $14
80106299:	6a 0e                	push   $0xe
  jmp alltraps
8010629b:	e9 87 fa ff ff       	jmp    80105d27 <alltraps>

801062a0 <vector15>:
.globl vector15
vector15:
  pushl $0
801062a0:	6a 00                	push   $0x0
  pushl $15
801062a2:	6a 0f                	push   $0xf
  jmp alltraps
801062a4:	e9 7e fa ff ff       	jmp    80105d27 <alltraps>

801062a9 <vector16>:
.globl vector16
vector16:
  pushl $0
801062a9:	6a 00                	push   $0x0
  pushl $16
801062ab:	6a 10                	push   $0x10
  jmp alltraps
801062ad:	e9 75 fa ff ff       	jmp    80105d27 <alltraps>

801062b2 <vector17>:
.globl vector17
vector17:
  pushl $17
801062b2:	6a 11                	push   $0x11
  jmp alltraps
801062b4:	e9 6e fa ff ff       	jmp    80105d27 <alltraps>

801062b9 <vector18>:
.globl vector18
vector18:
  pushl $0
801062b9:	6a 00                	push   $0x0
  pushl $18
801062bb:	6a 12                	push   $0x12
  jmp alltraps
801062bd:	e9 65 fa ff ff       	jmp    80105d27 <alltraps>

801062c2 <vector19>:
.globl vector19
vector19:
  pushl $0
801062c2:	6a 00                	push   $0x0
  pushl $19
801062c4:	6a 13                	push   $0x13
  jmp alltraps
801062c6:	e9 5c fa ff ff       	jmp    80105d27 <alltraps>

801062cb <vector20>:
.globl vector20
vector20:
  pushl $0
801062cb:	6a 00                	push   $0x0
  pushl $20
801062cd:	6a 14                	push   $0x14
  jmp alltraps
801062cf:	e9 53 fa ff ff       	jmp    80105d27 <alltraps>

801062d4 <vector21>:
.globl vector21
vector21:
  pushl $0
801062d4:	6a 00                	push   $0x0
  pushl $21
801062d6:	6a 15                	push   $0x15
  jmp alltraps
801062d8:	e9 4a fa ff ff       	jmp    80105d27 <alltraps>

801062dd <vector22>:
.globl vector22
vector22:
  pushl $0
801062dd:	6a 00                	push   $0x0
  pushl $22
801062df:	6a 16                	push   $0x16
  jmp alltraps
801062e1:	e9 41 fa ff ff       	jmp    80105d27 <alltraps>

801062e6 <vector23>:
.globl vector23
vector23:
  pushl $0
801062e6:	6a 00                	push   $0x0
  pushl $23
801062e8:	6a 17                	push   $0x17
  jmp alltraps
801062ea:	e9 38 fa ff ff       	jmp    80105d27 <alltraps>

801062ef <vector24>:
.globl vector24
vector24:
  pushl $0
801062ef:	6a 00                	push   $0x0
  pushl $24
801062f1:	6a 18                	push   $0x18
  jmp alltraps
801062f3:	e9 2f fa ff ff       	jmp    80105d27 <alltraps>

801062f8 <vector25>:
.globl vector25
vector25:
  pushl $0
801062f8:	6a 00                	push   $0x0
  pushl $25
801062fa:	6a 19                	push   $0x19
  jmp alltraps
801062fc:	e9 26 fa ff ff       	jmp    80105d27 <alltraps>

80106301 <vector26>:
.globl vector26
vector26:
  pushl $0
80106301:	6a 00                	push   $0x0
  pushl $26
80106303:	6a 1a                	push   $0x1a
  jmp alltraps
80106305:	e9 1d fa ff ff       	jmp    80105d27 <alltraps>

8010630a <vector27>:
.globl vector27
vector27:
  pushl $0
8010630a:	6a 00                	push   $0x0
  pushl $27
8010630c:	6a 1b                	push   $0x1b
  jmp alltraps
8010630e:	e9 14 fa ff ff       	jmp    80105d27 <alltraps>

80106313 <vector28>:
.globl vector28
vector28:
  pushl $0
80106313:	6a 00                	push   $0x0
  pushl $28
80106315:	6a 1c                	push   $0x1c
  jmp alltraps
80106317:	e9 0b fa ff ff       	jmp    80105d27 <alltraps>

8010631c <vector29>:
.globl vector29
vector29:
  pushl $0
8010631c:	6a 00                	push   $0x0
  pushl $29
8010631e:	6a 1d                	push   $0x1d
  jmp alltraps
80106320:	e9 02 fa ff ff       	jmp    80105d27 <alltraps>

80106325 <vector30>:
.globl vector30
vector30:
  pushl $0
80106325:	6a 00                	push   $0x0
  pushl $30
80106327:	6a 1e                	push   $0x1e
  jmp alltraps
80106329:	e9 f9 f9 ff ff       	jmp    80105d27 <alltraps>

8010632e <vector31>:
.globl vector31
vector31:
  pushl $0
8010632e:	6a 00                	push   $0x0
  pushl $31
80106330:	6a 1f                	push   $0x1f
  jmp alltraps
80106332:	e9 f0 f9 ff ff       	jmp    80105d27 <alltraps>

80106337 <vector32>:
.globl vector32
vector32:
  pushl $0
80106337:	6a 00                	push   $0x0
  pushl $32
80106339:	6a 20                	push   $0x20
  jmp alltraps
8010633b:	e9 e7 f9 ff ff       	jmp    80105d27 <alltraps>

80106340 <vector33>:
.globl vector33
vector33:
  pushl $0
80106340:	6a 00                	push   $0x0
  pushl $33
80106342:	6a 21                	push   $0x21
  jmp alltraps
80106344:	e9 de f9 ff ff       	jmp    80105d27 <alltraps>

80106349 <vector34>:
.globl vector34
vector34:
  pushl $0
80106349:	6a 00                	push   $0x0
  pushl $34
8010634b:	6a 22                	push   $0x22
  jmp alltraps
8010634d:	e9 d5 f9 ff ff       	jmp    80105d27 <alltraps>

80106352 <vector35>:
.globl vector35
vector35:
  pushl $0
80106352:	6a 00                	push   $0x0
  pushl $35
80106354:	6a 23                	push   $0x23
  jmp alltraps
80106356:	e9 cc f9 ff ff       	jmp    80105d27 <alltraps>

8010635b <vector36>:
.globl vector36
vector36:
  pushl $0
8010635b:	6a 00                	push   $0x0
  pushl $36
8010635d:	6a 24                	push   $0x24
  jmp alltraps
8010635f:	e9 c3 f9 ff ff       	jmp    80105d27 <alltraps>

80106364 <vector37>:
.globl vector37
vector37:
  pushl $0
80106364:	6a 00                	push   $0x0
  pushl $37
80106366:	6a 25                	push   $0x25
  jmp alltraps
80106368:	e9 ba f9 ff ff       	jmp    80105d27 <alltraps>

8010636d <vector38>:
.globl vector38
vector38:
  pushl $0
8010636d:	6a 00                	push   $0x0
  pushl $38
8010636f:	6a 26                	push   $0x26
  jmp alltraps
80106371:	e9 b1 f9 ff ff       	jmp    80105d27 <alltraps>

80106376 <vector39>:
.globl vector39
vector39:
  pushl $0
80106376:	6a 00                	push   $0x0
  pushl $39
80106378:	6a 27                	push   $0x27
  jmp alltraps
8010637a:	e9 a8 f9 ff ff       	jmp    80105d27 <alltraps>

8010637f <vector40>:
.globl vector40
vector40:
  pushl $0
8010637f:	6a 00                	push   $0x0
  pushl $40
80106381:	6a 28                	push   $0x28
  jmp alltraps
80106383:	e9 9f f9 ff ff       	jmp    80105d27 <alltraps>

80106388 <vector41>:
.globl vector41
vector41:
  pushl $0
80106388:	6a 00                	push   $0x0
  pushl $41
8010638a:	6a 29                	push   $0x29
  jmp alltraps
8010638c:	e9 96 f9 ff ff       	jmp    80105d27 <alltraps>

80106391 <vector42>:
.globl vector42
vector42:
  pushl $0
80106391:	6a 00                	push   $0x0
  pushl $42
80106393:	6a 2a                	push   $0x2a
  jmp alltraps
80106395:	e9 8d f9 ff ff       	jmp    80105d27 <alltraps>

8010639a <vector43>:
.globl vector43
vector43:
  pushl $0
8010639a:	6a 00                	push   $0x0
  pushl $43
8010639c:	6a 2b                	push   $0x2b
  jmp alltraps
8010639e:	e9 84 f9 ff ff       	jmp    80105d27 <alltraps>

801063a3 <vector44>:
.globl vector44
vector44:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $44
801063a5:	6a 2c                	push   $0x2c
  jmp alltraps
801063a7:	e9 7b f9 ff ff       	jmp    80105d27 <alltraps>

801063ac <vector45>:
.globl vector45
vector45:
  pushl $0
801063ac:	6a 00                	push   $0x0
  pushl $45
801063ae:	6a 2d                	push   $0x2d
  jmp alltraps
801063b0:	e9 72 f9 ff ff       	jmp    80105d27 <alltraps>

801063b5 <vector46>:
.globl vector46
vector46:
  pushl $0
801063b5:	6a 00                	push   $0x0
  pushl $46
801063b7:	6a 2e                	push   $0x2e
  jmp alltraps
801063b9:	e9 69 f9 ff ff       	jmp    80105d27 <alltraps>

801063be <vector47>:
.globl vector47
vector47:
  pushl $0
801063be:	6a 00                	push   $0x0
  pushl $47
801063c0:	6a 2f                	push   $0x2f
  jmp alltraps
801063c2:	e9 60 f9 ff ff       	jmp    80105d27 <alltraps>

801063c7 <vector48>:
.globl vector48
vector48:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $48
801063c9:	6a 30                	push   $0x30
  jmp alltraps
801063cb:	e9 57 f9 ff ff       	jmp    80105d27 <alltraps>

801063d0 <vector49>:
.globl vector49
vector49:
  pushl $0
801063d0:	6a 00                	push   $0x0
  pushl $49
801063d2:	6a 31                	push   $0x31
  jmp alltraps
801063d4:	e9 4e f9 ff ff       	jmp    80105d27 <alltraps>

801063d9 <vector50>:
.globl vector50
vector50:
  pushl $0
801063d9:	6a 00                	push   $0x0
  pushl $50
801063db:	6a 32                	push   $0x32
  jmp alltraps
801063dd:	e9 45 f9 ff ff       	jmp    80105d27 <alltraps>

801063e2 <vector51>:
.globl vector51
vector51:
  pushl $0
801063e2:	6a 00                	push   $0x0
  pushl $51
801063e4:	6a 33                	push   $0x33
  jmp alltraps
801063e6:	e9 3c f9 ff ff       	jmp    80105d27 <alltraps>

801063eb <vector52>:
.globl vector52
vector52:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $52
801063ed:	6a 34                	push   $0x34
  jmp alltraps
801063ef:	e9 33 f9 ff ff       	jmp    80105d27 <alltraps>

801063f4 <vector53>:
.globl vector53
vector53:
  pushl $0
801063f4:	6a 00                	push   $0x0
  pushl $53
801063f6:	6a 35                	push   $0x35
  jmp alltraps
801063f8:	e9 2a f9 ff ff       	jmp    80105d27 <alltraps>

801063fd <vector54>:
.globl vector54
vector54:
  pushl $0
801063fd:	6a 00                	push   $0x0
  pushl $54
801063ff:	6a 36                	push   $0x36
  jmp alltraps
80106401:	e9 21 f9 ff ff       	jmp    80105d27 <alltraps>

80106406 <vector55>:
.globl vector55
vector55:
  pushl $0
80106406:	6a 00                	push   $0x0
  pushl $55
80106408:	6a 37                	push   $0x37
  jmp alltraps
8010640a:	e9 18 f9 ff ff       	jmp    80105d27 <alltraps>

8010640f <vector56>:
.globl vector56
vector56:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $56
80106411:	6a 38                	push   $0x38
  jmp alltraps
80106413:	e9 0f f9 ff ff       	jmp    80105d27 <alltraps>

80106418 <vector57>:
.globl vector57
vector57:
  pushl $0
80106418:	6a 00                	push   $0x0
  pushl $57
8010641a:	6a 39                	push   $0x39
  jmp alltraps
8010641c:	e9 06 f9 ff ff       	jmp    80105d27 <alltraps>

80106421 <vector58>:
.globl vector58
vector58:
  pushl $0
80106421:	6a 00                	push   $0x0
  pushl $58
80106423:	6a 3a                	push   $0x3a
  jmp alltraps
80106425:	e9 fd f8 ff ff       	jmp    80105d27 <alltraps>

8010642a <vector59>:
.globl vector59
vector59:
  pushl $0
8010642a:	6a 00                	push   $0x0
  pushl $59
8010642c:	6a 3b                	push   $0x3b
  jmp alltraps
8010642e:	e9 f4 f8 ff ff       	jmp    80105d27 <alltraps>

80106433 <vector60>:
.globl vector60
vector60:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $60
80106435:	6a 3c                	push   $0x3c
  jmp alltraps
80106437:	e9 eb f8 ff ff       	jmp    80105d27 <alltraps>

8010643c <vector61>:
.globl vector61
vector61:
  pushl $0
8010643c:	6a 00                	push   $0x0
  pushl $61
8010643e:	6a 3d                	push   $0x3d
  jmp alltraps
80106440:	e9 e2 f8 ff ff       	jmp    80105d27 <alltraps>

80106445 <vector62>:
.globl vector62
vector62:
  pushl $0
80106445:	6a 00                	push   $0x0
  pushl $62
80106447:	6a 3e                	push   $0x3e
  jmp alltraps
80106449:	e9 d9 f8 ff ff       	jmp    80105d27 <alltraps>

8010644e <vector63>:
.globl vector63
vector63:
  pushl $0
8010644e:	6a 00                	push   $0x0
  pushl $63
80106450:	6a 3f                	push   $0x3f
  jmp alltraps
80106452:	e9 d0 f8 ff ff       	jmp    80105d27 <alltraps>

80106457 <vector64>:
.globl vector64
vector64:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $64
80106459:	6a 40                	push   $0x40
  jmp alltraps
8010645b:	e9 c7 f8 ff ff       	jmp    80105d27 <alltraps>

80106460 <vector65>:
.globl vector65
vector65:
  pushl $0
80106460:	6a 00                	push   $0x0
  pushl $65
80106462:	6a 41                	push   $0x41
  jmp alltraps
80106464:	e9 be f8 ff ff       	jmp    80105d27 <alltraps>

80106469 <vector66>:
.globl vector66
vector66:
  pushl $0
80106469:	6a 00                	push   $0x0
  pushl $66
8010646b:	6a 42                	push   $0x42
  jmp alltraps
8010646d:	e9 b5 f8 ff ff       	jmp    80105d27 <alltraps>

80106472 <vector67>:
.globl vector67
vector67:
  pushl $0
80106472:	6a 00                	push   $0x0
  pushl $67
80106474:	6a 43                	push   $0x43
  jmp alltraps
80106476:	e9 ac f8 ff ff       	jmp    80105d27 <alltraps>

8010647b <vector68>:
.globl vector68
vector68:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $68
8010647d:	6a 44                	push   $0x44
  jmp alltraps
8010647f:	e9 a3 f8 ff ff       	jmp    80105d27 <alltraps>

80106484 <vector69>:
.globl vector69
vector69:
  pushl $0
80106484:	6a 00                	push   $0x0
  pushl $69
80106486:	6a 45                	push   $0x45
  jmp alltraps
80106488:	e9 9a f8 ff ff       	jmp    80105d27 <alltraps>

8010648d <vector70>:
.globl vector70
vector70:
  pushl $0
8010648d:	6a 00                	push   $0x0
  pushl $70
8010648f:	6a 46                	push   $0x46
  jmp alltraps
80106491:	e9 91 f8 ff ff       	jmp    80105d27 <alltraps>

80106496 <vector71>:
.globl vector71
vector71:
  pushl $0
80106496:	6a 00                	push   $0x0
  pushl $71
80106498:	6a 47                	push   $0x47
  jmp alltraps
8010649a:	e9 88 f8 ff ff       	jmp    80105d27 <alltraps>

8010649f <vector72>:
.globl vector72
vector72:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $72
801064a1:	6a 48                	push   $0x48
  jmp alltraps
801064a3:	e9 7f f8 ff ff       	jmp    80105d27 <alltraps>

801064a8 <vector73>:
.globl vector73
vector73:
  pushl $0
801064a8:	6a 00                	push   $0x0
  pushl $73
801064aa:	6a 49                	push   $0x49
  jmp alltraps
801064ac:	e9 76 f8 ff ff       	jmp    80105d27 <alltraps>

801064b1 <vector74>:
.globl vector74
vector74:
  pushl $0
801064b1:	6a 00                	push   $0x0
  pushl $74
801064b3:	6a 4a                	push   $0x4a
  jmp alltraps
801064b5:	e9 6d f8 ff ff       	jmp    80105d27 <alltraps>

801064ba <vector75>:
.globl vector75
vector75:
  pushl $0
801064ba:	6a 00                	push   $0x0
  pushl $75
801064bc:	6a 4b                	push   $0x4b
  jmp alltraps
801064be:	e9 64 f8 ff ff       	jmp    80105d27 <alltraps>

801064c3 <vector76>:
.globl vector76
vector76:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $76
801064c5:	6a 4c                	push   $0x4c
  jmp alltraps
801064c7:	e9 5b f8 ff ff       	jmp    80105d27 <alltraps>

801064cc <vector77>:
.globl vector77
vector77:
  pushl $0
801064cc:	6a 00                	push   $0x0
  pushl $77
801064ce:	6a 4d                	push   $0x4d
  jmp alltraps
801064d0:	e9 52 f8 ff ff       	jmp    80105d27 <alltraps>

801064d5 <vector78>:
.globl vector78
vector78:
  pushl $0
801064d5:	6a 00                	push   $0x0
  pushl $78
801064d7:	6a 4e                	push   $0x4e
  jmp alltraps
801064d9:	e9 49 f8 ff ff       	jmp    80105d27 <alltraps>

801064de <vector79>:
.globl vector79
vector79:
  pushl $0
801064de:	6a 00                	push   $0x0
  pushl $79
801064e0:	6a 4f                	push   $0x4f
  jmp alltraps
801064e2:	e9 40 f8 ff ff       	jmp    80105d27 <alltraps>

801064e7 <vector80>:
.globl vector80
vector80:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $80
801064e9:	6a 50                	push   $0x50
  jmp alltraps
801064eb:	e9 37 f8 ff ff       	jmp    80105d27 <alltraps>

801064f0 <vector81>:
.globl vector81
vector81:
  pushl $0
801064f0:	6a 00                	push   $0x0
  pushl $81
801064f2:	6a 51                	push   $0x51
  jmp alltraps
801064f4:	e9 2e f8 ff ff       	jmp    80105d27 <alltraps>

801064f9 <vector82>:
.globl vector82
vector82:
  pushl $0
801064f9:	6a 00                	push   $0x0
  pushl $82
801064fb:	6a 52                	push   $0x52
  jmp alltraps
801064fd:	e9 25 f8 ff ff       	jmp    80105d27 <alltraps>

80106502 <vector83>:
.globl vector83
vector83:
  pushl $0
80106502:	6a 00                	push   $0x0
  pushl $83
80106504:	6a 53                	push   $0x53
  jmp alltraps
80106506:	e9 1c f8 ff ff       	jmp    80105d27 <alltraps>

8010650b <vector84>:
.globl vector84
vector84:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $84
8010650d:	6a 54                	push   $0x54
  jmp alltraps
8010650f:	e9 13 f8 ff ff       	jmp    80105d27 <alltraps>

80106514 <vector85>:
.globl vector85
vector85:
  pushl $0
80106514:	6a 00                	push   $0x0
  pushl $85
80106516:	6a 55                	push   $0x55
  jmp alltraps
80106518:	e9 0a f8 ff ff       	jmp    80105d27 <alltraps>

8010651d <vector86>:
.globl vector86
vector86:
  pushl $0
8010651d:	6a 00                	push   $0x0
  pushl $86
8010651f:	6a 56                	push   $0x56
  jmp alltraps
80106521:	e9 01 f8 ff ff       	jmp    80105d27 <alltraps>

80106526 <vector87>:
.globl vector87
vector87:
  pushl $0
80106526:	6a 00                	push   $0x0
  pushl $87
80106528:	6a 57                	push   $0x57
  jmp alltraps
8010652a:	e9 f8 f7 ff ff       	jmp    80105d27 <alltraps>

8010652f <vector88>:
.globl vector88
vector88:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $88
80106531:	6a 58                	push   $0x58
  jmp alltraps
80106533:	e9 ef f7 ff ff       	jmp    80105d27 <alltraps>

80106538 <vector89>:
.globl vector89
vector89:
  pushl $0
80106538:	6a 00                	push   $0x0
  pushl $89
8010653a:	6a 59                	push   $0x59
  jmp alltraps
8010653c:	e9 e6 f7 ff ff       	jmp    80105d27 <alltraps>

80106541 <vector90>:
.globl vector90
vector90:
  pushl $0
80106541:	6a 00                	push   $0x0
  pushl $90
80106543:	6a 5a                	push   $0x5a
  jmp alltraps
80106545:	e9 dd f7 ff ff       	jmp    80105d27 <alltraps>

8010654a <vector91>:
.globl vector91
vector91:
  pushl $0
8010654a:	6a 00                	push   $0x0
  pushl $91
8010654c:	6a 5b                	push   $0x5b
  jmp alltraps
8010654e:	e9 d4 f7 ff ff       	jmp    80105d27 <alltraps>

80106553 <vector92>:
.globl vector92
vector92:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $92
80106555:	6a 5c                	push   $0x5c
  jmp alltraps
80106557:	e9 cb f7 ff ff       	jmp    80105d27 <alltraps>

8010655c <vector93>:
.globl vector93
vector93:
  pushl $0
8010655c:	6a 00                	push   $0x0
  pushl $93
8010655e:	6a 5d                	push   $0x5d
  jmp alltraps
80106560:	e9 c2 f7 ff ff       	jmp    80105d27 <alltraps>

80106565 <vector94>:
.globl vector94
vector94:
  pushl $0
80106565:	6a 00                	push   $0x0
  pushl $94
80106567:	6a 5e                	push   $0x5e
  jmp alltraps
80106569:	e9 b9 f7 ff ff       	jmp    80105d27 <alltraps>

8010656e <vector95>:
.globl vector95
vector95:
  pushl $0
8010656e:	6a 00                	push   $0x0
  pushl $95
80106570:	6a 5f                	push   $0x5f
  jmp alltraps
80106572:	e9 b0 f7 ff ff       	jmp    80105d27 <alltraps>

80106577 <vector96>:
.globl vector96
vector96:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $96
80106579:	6a 60                	push   $0x60
  jmp alltraps
8010657b:	e9 a7 f7 ff ff       	jmp    80105d27 <alltraps>

80106580 <vector97>:
.globl vector97
vector97:
  pushl $0
80106580:	6a 00                	push   $0x0
  pushl $97
80106582:	6a 61                	push   $0x61
  jmp alltraps
80106584:	e9 9e f7 ff ff       	jmp    80105d27 <alltraps>

80106589 <vector98>:
.globl vector98
vector98:
  pushl $0
80106589:	6a 00                	push   $0x0
  pushl $98
8010658b:	6a 62                	push   $0x62
  jmp alltraps
8010658d:	e9 95 f7 ff ff       	jmp    80105d27 <alltraps>

80106592 <vector99>:
.globl vector99
vector99:
  pushl $0
80106592:	6a 00                	push   $0x0
  pushl $99
80106594:	6a 63                	push   $0x63
  jmp alltraps
80106596:	e9 8c f7 ff ff       	jmp    80105d27 <alltraps>

8010659b <vector100>:
.globl vector100
vector100:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $100
8010659d:	6a 64                	push   $0x64
  jmp alltraps
8010659f:	e9 83 f7 ff ff       	jmp    80105d27 <alltraps>

801065a4 <vector101>:
.globl vector101
vector101:
  pushl $0
801065a4:	6a 00                	push   $0x0
  pushl $101
801065a6:	6a 65                	push   $0x65
  jmp alltraps
801065a8:	e9 7a f7 ff ff       	jmp    80105d27 <alltraps>

801065ad <vector102>:
.globl vector102
vector102:
  pushl $0
801065ad:	6a 00                	push   $0x0
  pushl $102
801065af:	6a 66                	push   $0x66
  jmp alltraps
801065b1:	e9 71 f7 ff ff       	jmp    80105d27 <alltraps>

801065b6 <vector103>:
.globl vector103
vector103:
  pushl $0
801065b6:	6a 00                	push   $0x0
  pushl $103
801065b8:	6a 67                	push   $0x67
  jmp alltraps
801065ba:	e9 68 f7 ff ff       	jmp    80105d27 <alltraps>

801065bf <vector104>:
.globl vector104
vector104:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $104
801065c1:	6a 68                	push   $0x68
  jmp alltraps
801065c3:	e9 5f f7 ff ff       	jmp    80105d27 <alltraps>

801065c8 <vector105>:
.globl vector105
vector105:
  pushl $0
801065c8:	6a 00                	push   $0x0
  pushl $105
801065ca:	6a 69                	push   $0x69
  jmp alltraps
801065cc:	e9 56 f7 ff ff       	jmp    80105d27 <alltraps>

801065d1 <vector106>:
.globl vector106
vector106:
  pushl $0
801065d1:	6a 00                	push   $0x0
  pushl $106
801065d3:	6a 6a                	push   $0x6a
  jmp alltraps
801065d5:	e9 4d f7 ff ff       	jmp    80105d27 <alltraps>

801065da <vector107>:
.globl vector107
vector107:
  pushl $0
801065da:	6a 00                	push   $0x0
  pushl $107
801065dc:	6a 6b                	push   $0x6b
  jmp alltraps
801065de:	e9 44 f7 ff ff       	jmp    80105d27 <alltraps>

801065e3 <vector108>:
.globl vector108
vector108:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $108
801065e5:	6a 6c                	push   $0x6c
  jmp alltraps
801065e7:	e9 3b f7 ff ff       	jmp    80105d27 <alltraps>

801065ec <vector109>:
.globl vector109
vector109:
  pushl $0
801065ec:	6a 00                	push   $0x0
  pushl $109
801065ee:	6a 6d                	push   $0x6d
  jmp alltraps
801065f0:	e9 32 f7 ff ff       	jmp    80105d27 <alltraps>

801065f5 <vector110>:
.globl vector110
vector110:
  pushl $0
801065f5:	6a 00                	push   $0x0
  pushl $110
801065f7:	6a 6e                	push   $0x6e
  jmp alltraps
801065f9:	e9 29 f7 ff ff       	jmp    80105d27 <alltraps>

801065fe <vector111>:
.globl vector111
vector111:
  pushl $0
801065fe:	6a 00                	push   $0x0
  pushl $111
80106600:	6a 6f                	push   $0x6f
  jmp alltraps
80106602:	e9 20 f7 ff ff       	jmp    80105d27 <alltraps>

80106607 <vector112>:
.globl vector112
vector112:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $112
80106609:	6a 70                	push   $0x70
  jmp alltraps
8010660b:	e9 17 f7 ff ff       	jmp    80105d27 <alltraps>

80106610 <vector113>:
.globl vector113
vector113:
  pushl $0
80106610:	6a 00                	push   $0x0
  pushl $113
80106612:	6a 71                	push   $0x71
  jmp alltraps
80106614:	e9 0e f7 ff ff       	jmp    80105d27 <alltraps>

80106619 <vector114>:
.globl vector114
vector114:
  pushl $0
80106619:	6a 00                	push   $0x0
  pushl $114
8010661b:	6a 72                	push   $0x72
  jmp alltraps
8010661d:	e9 05 f7 ff ff       	jmp    80105d27 <alltraps>

80106622 <vector115>:
.globl vector115
vector115:
  pushl $0
80106622:	6a 00                	push   $0x0
  pushl $115
80106624:	6a 73                	push   $0x73
  jmp alltraps
80106626:	e9 fc f6 ff ff       	jmp    80105d27 <alltraps>

8010662b <vector116>:
.globl vector116
vector116:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $116
8010662d:	6a 74                	push   $0x74
  jmp alltraps
8010662f:	e9 f3 f6 ff ff       	jmp    80105d27 <alltraps>

80106634 <vector117>:
.globl vector117
vector117:
  pushl $0
80106634:	6a 00                	push   $0x0
  pushl $117
80106636:	6a 75                	push   $0x75
  jmp alltraps
80106638:	e9 ea f6 ff ff       	jmp    80105d27 <alltraps>

8010663d <vector118>:
.globl vector118
vector118:
  pushl $0
8010663d:	6a 00                	push   $0x0
  pushl $118
8010663f:	6a 76                	push   $0x76
  jmp alltraps
80106641:	e9 e1 f6 ff ff       	jmp    80105d27 <alltraps>

80106646 <vector119>:
.globl vector119
vector119:
  pushl $0
80106646:	6a 00                	push   $0x0
  pushl $119
80106648:	6a 77                	push   $0x77
  jmp alltraps
8010664a:	e9 d8 f6 ff ff       	jmp    80105d27 <alltraps>

8010664f <vector120>:
.globl vector120
vector120:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $120
80106651:	6a 78                	push   $0x78
  jmp alltraps
80106653:	e9 cf f6 ff ff       	jmp    80105d27 <alltraps>

80106658 <vector121>:
.globl vector121
vector121:
  pushl $0
80106658:	6a 00                	push   $0x0
  pushl $121
8010665a:	6a 79                	push   $0x79
  jmp alltraps
8010665c:	e9 c6 f6 ff ff       	jmp    80105d27 <alltraps>

80106661 <vector122>:
.globl vector122
vector122:
  pushl $0
80106661:	6a 00                	push   $0x0
  pushl $122
80106663:	6a 7a                	push   $0x7a
  jmp alltraps
80106665:	e9 bd f6 ff ff       	jmp    80105d27 <alltraps>

8010666a <vector123>:
.globl vector123
vector123:
  pushl $0
8010666a:	6a 00                	push   $0x0
  pushl $123
8010666c:	6a 7b                	push   $0x7b
  jmp alltraps
8010666e:	e9 b4 f6 ff ff       	jmp    80105d27 <alltraps>

80106673 <vector124>:
.globl vector124
vector124:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $124
80106675:	6a 7c                	push   $0x7c
  jmp alltraps
80106677:	e9 ab f6 ff ff       	jmp    80105d27 <alltraps>

8010667c <vector125>:
.globl vector125
vector125:
  pushl $0
8010667c:	6a 00                	push   $0x0
  pushl $125
8010667e:	6a 7d                	push   $0x7d
  jmp alltraps
80106680:	e9 a2 f6 ff ff       	jmp    80105d27 <alltraps>

80106685 <vector126>:
.globl vector126
vector126:
  pushl $0
80106685:	6a 00                	push   $0x0
  pushl $126
80106687:	6a 7e                	push   $0x7e
  jmp alltraps
80106689:	e9 99 f6 ff ff       	jmp    80105d27 <alltraps>

8010668e <vector127>:
.globl vector127
vector127:
  pushl $0
8010668e:	6a 00                	push   $0x0
  pushl $127
80106690:	6a 7f                	push   $0x7f
  jmp alltraps
80106692:	e9 90 f6 ff ff       	jmp    80105d27 <alltraps>

80106697 <vector128>:
.globl vector128
vector128:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $128
80106699:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010669e:	e9 84 f6 ff ff       	jmp    80105d27 <alltraps>

801066a3 <vector129>:
.globl vector129
vector129:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $129
801066a5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801066aa:	e9 78 f6 ff ff       	jmp    80105d27 <alltraps>

801066af <vector130>:
.globl vector130
vector130:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $130
801066b1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801066b6:	e9 6c f6 ff ff       	jmp    80105d27 <alltraps>

801066bb <vector131>:
.globl vector131
vector131:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $131
801066bd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801066c2:	e9 60 f6 ff ff       	jmp    80105d27 <alltraps>

801066c7 <vector132>:
.globl vector132
vector132:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $132
801066c9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801066ce:	e9 54 f6 ff ff       	jmp    80105d27 <alltraps>

801066d3 <vector133>:
.globl vector133
vector133:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $133
801066d5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801066da:	e9 48 f6 ff ff       	jmp    80105d27 <alltraps>

801066df <vector134>:
.globl vector134
vector134:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $134
801066e1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801066e6:	e9 3c f6 ff ff       	jmp    80105d27 <alltraps>

801066eb <vector135>:
.globl vector135
vector135:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $135
801066ed:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801066f2:	e9 30 f6 ff ff       	jmp    80105d27 <alltraps>

801066f7 <vector136>:
.globl vector136
vector136:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $136
801066f9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801066fe:	e9 24 f6 ff ff       	jmp    80105d27 <alltraps>

80106703 <vector137>:
.globl vector137
vector137:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $137
80106705:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010670a:	e9 18 f6 ff ff       	jmp    80105d27 <alltraps>

8010670f <vector138>:
.globl vector138
vector138:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $138
80106711:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106716:	e9 0c f6 ff ff       	jmp    80105d27 <alltraps>

8010671b <vector139>:
.globl vector139
vector139:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $139
8010671d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106722:	e9 00 f6 ff ff       	jmp    80105d27 <alltraps>

80106727 <vector140>:
.globl vector140
vector140:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $140
80106729:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010672e:	e9 f4 f5 ff ff       	jmp    80105d27 <alltraps>

80106733 <vector141>:
.globl vector141
vector141:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $141
80106735:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010673a:	e9 e8 f5 ff ff       	jmp    80105d27 <alltraps>

8010673f <vector142>:
.globl vector142
vector142:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $142
80106741:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106746:	e9 dc f5 ff ff       	jmp    80105d27 <alltraps>

8010674b <vector143>:
.globl vector143
vector143:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $143
8010674d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106752:	e9 d0 f5 ff ff       	jmp    80105d27 <alltraps>

80106757 <vector144>:
.globl vector144
vector144:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $144
80106759:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010675e:	e9 c4 f5 ff ff       	jmp    80105d27 <alltraps>

80106763 <vector145>:
.globl vector145
vector145:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $145
80106765:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010676a:	e9 b8 f5 ff ff       	jmp    80105d27 <alltraps>

8010676f <vector146>:
.globl vector146
vector146:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $146
80106771:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106776:	e9 ac f5 ff ff       	jmp    80105d27 <alltraps>

8010677b <vector147>:
.globl vector147
vector147:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $147
8010677d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106782:	e9 a0 f5 ff ff       	jmp    80105d27 <alltraps>

80106787 <vector148>:
.globl vector148
vector148:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $148
80106789:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010678e:	e9 94 f5 ff ff       	jmp    80105d27 <alltraps>

80106793 <vector149>:
.globl vector149
vector149:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $149
80106795:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010679a:	e9 88 f5 ff ff       	jmp    80105d27 <alltraps>

8010679f <vector150>:
.globl vector150
vector150:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $150
801067a1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801067a6:	e9 7c f5 ff ff       	jmp    80105d27 <alltraps>

801067ab <vector151>:
.globl vector151
vector151:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $151
801067ad:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801067b2:	e9 70 f5 ff ff       	jmp    80105d27 <alltraps>

801067b7 <vector152>:
.globl vector152
vector152:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $152
801067b9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801067be:	e9 64 f5 ff ff       	jmp    80105d27 <alltraps>

801067c3 <vector153>:
.globl vector153
vector153:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $153
801067c5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801067ca:	e9 58 f5 ff ff       	jmp    80105d27 <alltraps>

801067cf <vector154>:
.globl vector154
vector154:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $154
801067d1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801067d6:	e9 4c f5 ff ff       	jmp    80105d27 <alltraps>

801067db <vector155>:
.globl vector155
vector155:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $155
801067dd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801067e2:	e9 40 f5 ff ff       	jmp    80105d27 <alltraps>

801067e7 <vector156>:
.globl vector156
vector156:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $156
801067e9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801067ee:	e9 34 f5 ff ff       	jmp    80105d27 <alltraps>

801067f3 <vector157>:
.globl vector157
vector157:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $157
801067f5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801067fa:	e9 28 f5 ff ff       	jmp    80105d27 <alltraps>

801067ff <vector158>:
.globl vector158
vector158:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $158
80106801:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106806:	e9 1c f5 ff ff       	jmp    80105d27 <alltraps>

8010680b <vector159>:
.globl vector159
vector159:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $159
8010680d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106812:	e9 10 f5 ff ff       	jmp    80105d27 <alltraps>

80106817 <vector160>:
.globl vector160
vector160:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $160
80106819:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010681e:	e9 04 f5 ff ff       	jmp    80105d27 <alltraps>

80106823 <vector161>:
.globl vector161
vector161:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $161
80106825:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010682a:	e9 f8 f4 ff ff       	jmp    80105d27 <alltraps>

8010682f <vector162>:
.globl vector162
vector162:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $162
80106831:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106836:	e9 ec f4 ff ff       	jmp    80105d27 <alltraps>

8010683b <vector163>:
.globl vector163
vector163:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $163
8010683d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106842:	e9 e0 f4 ff ff       	jmp    80105d27 <alltraps>

80106847 <vector164>:
.globl vector164
vector164:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $164
80106849:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010684e:	e9 d4 f4 ff ff       	jmp    80105d27 <alltraps>

80106853 <vector165>:
.globl vector165
vector165:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $165
80106855:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010685a:	e9 c8 f4 ff ff       	jmp    80105d27 <alltraps>

8010685f <vector166>:
.globl vector166
vector166:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $166
80106861:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106866:	e9 bc f4 ff ff       	jmp    80105d27 <alltraps>

8010686b <vector167>:
.globl vector167
vector167:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $167
8010686d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106872:	e9 b0 f4 ff ff       	jmp    80105d27 <alltraps>

80106877 <vector168>:
.globl vector168
vector168:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $168
80106879:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010687e:	e9 a4 f4 ff ff       	jmp    80105d27 <alltraps>

80106883 <vector169>:
.globl vector169
vector169:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $169
80106885:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010688a:	e9 98 f4 ff ff       	jmp    80105d27 <alltraps>

8010688f <vector170>:
.globl vector170
vector170:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $170
80106891:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106896:	e9 8c f4 ff ff       	jmp    80105d27 <alltraps>

8010689b <vector171>:
.globl vector171
vector171:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $171
8010689d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801068a2:	e9 80 f4 ff ff       	jmp    80105d27 <alltraps>

801068a7 <vector172>:
.globl vector172
vector172:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $172
801068a9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801068ae:	e9 74 f4 ff ff       	jmp    80105d27 <alltraps>

801068b3 <vector173>:
.globl vector173
vector173:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $173
801068b5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801068ba:	e9 68 f4 ff ff       	jmp    80105d27 <alltraps>

801068bf <vector174>:
.globl vector174
vector174:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $174
801068c1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801068c6:	e9 5c f4 ff ff       	jmp    80105d27 <alltraps>

801068cb <vector175>:
.globl vector175
vector175:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $175
801068cd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801068d2:	e9 50 f4 ff ff       	jmp    80105d27 <alltraps>

801068d7 <vector176>:
.globl vector176
vector176:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $176
801068d9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801068de:	e9 44 f4 ff ff       	jmp    80105d27 <alltraps>

801068e3 <vector177>:
.globl vector177
vector177:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $177
801068e5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801068ea:	e9 38 f4 ff ff       	jmp    80105d27 <alltraps>

801068ef <vector178>:
.globl vector178
vector178:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $178
801068f1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801068f6:	e9 2c f4 ff ff       	jmp    80105d27 <alltraps>

801068fb <vector179>:
.globl vector179
vector179:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $179
801068fd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106902:	e9 20 f4 ff ff       	jmp    80105d27 <alltraps>

80106907 <vector180>:
.globl vector180
vector180:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $180
80106909:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010690e:	e9 14 f4 ff ff       	jmp    80105d27 <alltraps>

80106913 <vector181>:
.globl vector181
vector181:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $181
80106915:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010691a:	e9 08 f4 ff ff       	jmp    80105d27 <alltraps>

8010691f <vector182>:
.globl vector182
vector182:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $182
80106921:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106926:	e9 fc f3 ff ff       	jmp    80105d27 <alltraps>

8010692b <vector183>:
.globl vector183
vector183:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $183
8010692d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106932:	e9 f0 f3 ff ff       	jmp    80105d27 <alltraps>

80106937 <vector184>:
.globl vector184
vector184:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $184
80106939:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010693e:	e9 e4 f3 ff ff       	jmp    80105d27 <alltraps>

80106943 <vector185>:
.globl vector185
vector185:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $185
80106945:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010694a:	e9 d8 f3 ff ff       	jmp    80105d27 <alltraps>

8010694f <vector186>:
.globl vector186
vector186:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $186
80106951:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106956:	e9 cc f3 ff ff       	jmp    80105d27 <alltraps>

8010695b <vector187>:
.globl vector187
vector187:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $187
8010695d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106962:	e9 c0 f3 ff ff       	jmp    80105d27 <alltraps>

80106967 <vector188>:
.globl vector188
vector188:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $188
80106969:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010696e:	e9 b4 f3 ff ff       	jmp    80105d27 <alltraps>

80106973 <vector189>:
.globl vector189
vector189:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $189
80106975:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010697a:	e9 a8 f3 ff ff       	jmp    80105d27 <alltraps>

8010697f <vector190>:
.globl vector190
vector190:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $190
80106981:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106986:	e9 9c f3 ff ff       	jmp    80105d27 <alltraps>

8010698b <vector191>:
.globl vector191
vector191:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $191
8010698d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106992:	e9 90 f3 ff ff       	jmp    80105d27 <alltraps>

80106997 <vector192>:
.globl vector192
vector192:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $192
80106999:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010699e:	e9 84 f3 ff ff       	jmp    80105d27 <alltraps>

801069a3 <vector193>:
.globl vector193
vector193:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $193
801069a5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801069aa:	e9 78 f3 ff ff       	jmp    80105d27 <alltraps>

801069af <vector194>:
.globl vector194
vector194:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $194
801069b1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801069b6:	e9 6c f3 ff ff       	jmp    80105d27 <alltraps>

801069bb <vector195>:
.globl vector195
vector195:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $195
801069bd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801069c2:	e9 60 f3 ff ff       	jmp    80105d27 <alltraps>

801069c7 <vector196>:
.globl vector196
vector196:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $196
801069c9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801069ce:	e9 54 f3 ff ff       	jmp    80105d27 <alltraps>

801069d3 <vector197>:
.globl vector197
vector197:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $197
801069d5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801069da:	e9 48 f3 ff ff       	jmp    80105d27 <alltraps>

801069df <vector198>:
.globl vector198
vector198:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $198
801069e1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801069e6:	e9 3c f3 ff ff       	jmp    80105d27 <alltraps>

801069eb <vector199>:
.globl vector199
vector199:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $199
801069ed:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801069f2:	e9 30 f3 ff ff       	jmp    80105d27 <alltraps>

801069f7 <vector200>:
.globl vector200
vector200:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $200
801069f9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801069fe:	e9 24 f3 ff ff       	jmp    80105d27 <alltraps>

80106a03 <vector201>:
.globl vector201
vector201:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $201
80106a05:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106a0a:	e9 18 f3 ff ff       	jmp    80105d27 <alltraps>

80106a0f <vector202>:
.globl vector202
vector202:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $202
80106a11:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106a16:	e9 0c f3 ff ff       	jmp    80105d27 <alltraps>

80106a1b <vector203>:
.globl vector203
vector203:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $203
80106a1d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106a22:	e9 00 f3 ff ff       	jmp    80105d27 <alltraps>

80106a27 <vector204>:
.globl vector204
vector204:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $204
80106a29:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106a2e:	e9 f4 f2 ff ff       	jmp    80105d27 <alltraps>

80106a33 <vector205>:
.globl vector205
vector205:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $205
80106a35:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106a3a:	e9 e8 f2 ff ff       	jmp    80105d27 <alltraps>

80106a3f <vector206>:
.globl vector206
vector206:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $206
80106a41:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106a46:	e9 dc f2 ff ff       	jmp    80105d27 <alltraps>

80106a4b <vector207>:
.globl vector207
vector207:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $207
80106a4d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106a52:	e9 d0 f2 ff ff       	jmp    80105d27 <alltraps>

80106a57 <vector208>:
.globl vector208
vector208:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $208
80106a59:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106a5e:	e9 c4 f2 ff ff       	jmp    80105d27 <alltraps>

80106a63 <vector209>:
.globl vector209
vector209:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $209
80106a65:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106a6a:	e9 b8 f2 ff ff       	jmp    80105d27 <alltraps>

80106a6f <vector210>:
.globl vector210
vector210:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $210
80106a71:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106a76:	e9 ac f2 ff ff       	jmp    80105d27 <alltraps>

80106a7b <vector211>:
.globl vector211
vector211:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $211
80106a7d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106a82:	e9 a0 f2 ff ff       	jmp    80105d27 <alltraps>

80106a87 <vector212>:
.globl vector212
vector212:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $212
80106a89:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106a8e:	e9 94 f2 ff ff       	jmp    80105d27 <alltraps>

80106a93 <vector213>:
.globl vector213
vector213:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $213
80106a95:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106a9a:	e9 88 f2 ff ff       	jmp    80105d27 <alltraps>

80106a9f <vector214>:
.globl vector214
vector214:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $214
80106aa1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106aa6:	e9 7c f2 ff ff       	jmp    80105d27 <alltraps>

80106aab <vector215>:
.globl vector215
vector215:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $215
80106aad:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106ab2:	e9 70 f2 ff ff       	jmp    80105d27 <alltraps>

80106ab7 <vector216>:
.globl vector216
vector216:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $216
80106ab9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106abe:	e9 64 f2 ff ff       	jmp    80105d27 <alltraps>

80106ac3 <vector217>:
.globl vector217
vector217:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $217
80106ac5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106aca:	e9 58 f2 ff ff       	jmp    80105d27 <alltraps>

80106acf <vector218>:
.globl vector218
vector218:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $218
80106ad1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106ad6:	e9 4c f2 ff ff       	jmp    80105d27 <alltraps>

80106adb <vector219>:
.globl vector219
vector219:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $219
80106add:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106ae2:	e9 40 f2 ff ff       	jmp    80105d27 <alltraps>

80106ae7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $220
80106ae9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106aee:	e9 34 f2 ff ff       	jmp    80105d27 <alltraps>

80106af3 <vector221>:
.globl vector221
vector221:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $221
80106af5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106afa:	e9 28 f2 ff ff       	jmp    80105d27 <alltraps>

80106aff <vector222>:
.globl vector222
vector222:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $222
80106b01:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106b06:	e9 1c f2 ff ff       	jmp    80105d27 <alltraps>

80106b0b <vector223>:
.globl vector223
vector223:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $223
80106b0d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106b12:	e9 10 f2 ff ff       	jmp    80105d27 <alltraps>

80106b17 <vector224>:
.globl vector224
vector224:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $224
80106b19:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106b1e:	e9 04 f2 ff ff       	jmp    80105d27 <alltraps>

80106b23 <vector225>:
.globl vector225
vector225:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $225
80106b25:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106b2a:	e9 f8 f1 ff ff       	jmp    80105d27 <alltraps>

80106b2f <vector226>:
.globl vector226
vector226:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $226
80106b31:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106b36:	e9 ec f1 ff ff       	jmp    80105d27 <alltraps>

80106b3b <vector227>:
.globl vector227
vector227:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $227
80106b3d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106b42:	e9 e0 f1 ff ff       	jmp    80105d27 <alltraps>

80106b47 <vector228>:
.globl vector228
vector228:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $228
80106b49:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106b4e:	e9 d4 f1 ff ff       	jmp    80105d27 <alltraps>

80106b53 <vector229>:
.globl vector229
vector229:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $229
80106b55:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106b5a:	e9 c8 f1 ff ff       	jmp    80105d27 <alltraps>

80106b5f <vector230>:
.globl vector230
vector230:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $230
80106b61:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106b66:	e9 bc f1 ff ff       	jmp    80105d27 <alltraps>

80106b6b <vector231>:
.globl vector231
vector231:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $231
80106b6d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106b72:	e9 b0 f1 ff ff       	jmp    80105d27 <alltraps>

80106b77 <vector232>:
.globl vector232
vector232:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $232
80106b79:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106b7e:	e9 a4 f1 ff ff       	jmp    80105d27 <alltraps>

80106b83 <vector233>:
.globl vector233
vector233:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $233
80106b85:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106b8a:	e9 98 f1 ff ff       	jmp    80105d27 <alltraps>

80106b8f <vector234>:
.globl vector234
vector234:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $234
80106b91:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106b96:	e9 8c f1 ff ff       	jmp    80105d27 <alltraps>

80106b9b <vector235>:
.globl vector235
vector235:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $235
80106b9d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106ba2:	e9 80 f1 ff ff       	jmp    80105d27 <alltraps>

80106ba7 <vector236>:
.globl vector236
vector236:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $236
80106ba9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106bae:	e9 74 f1 ff ff       	jmp    80105d27 <alltraps>

80106bb3 <vector237>:
.globl vector237
vector237:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $237
80106bb5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106bba:	e9 68 f1 ff ff       	jmp    80105d27 <alltraps>

80106bbf <vector238>:
.globl vector238
vector238:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $238
80106bc1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106bc6:	e9 5c f1 ff ff       	jmp    80105d27 <alltraps>

80106bcb <vector239>:
.globl vector239
vector239:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $239
80106bcd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106bd2:	e9 50 f1 ff ff       	jmp    80105d27 <alltraps>

80106bd7 <vector240>:
.globl vector240
vector240:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $240
80106bd9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106bde:	e9 44 f1 ff ff       	jmp    80105d27 <alltraps>

80106be3 <vector241>:
.globl vector241
vector241:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $241
80106be5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106bea:	e9 38 f1 ff ff       	jmp    80105d27 <alltraps>

80106bef <vector242>:
.globl vector242
vector242:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $242
80106bf1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106bf6:	e9 2c f1 ff ff       	jmp    80105d27 <alltraps>

80106bfb <vector243>:
.globl vector243
vector243:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $243
80106bfd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106c02:	e9 20 f1 ff ff       	jmp    80105d27 <alltraps>

80106c07 <vector244>:
.globl vector244
vector244:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $244
80106c09:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106c0e:	e9 14 f1 ff ff       	jmp    80105d27 <alltraps>

80106c13 <vector245>:
.globl vector245
vector245:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $245
80106c15:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106c1a:	e9 08 f1 ff ff       	jmp    80105d27 <alltraps>

80106c1f <vector246>:
.globl vector246
vector246:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $246
80106c21:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106c26:	e9 fc f0 ff ff       	jmp    80105d27 <alltraps>

80106c2b <vector247>:
.globl vector247
vector247:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $247
80106c2d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106c32:	e9 f0 f0 ff ff       	jmp    80105d27 <alltraps>

80106c37 <vector248>:
.globl vector248
vector248:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $248
80106c39:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106c3e:	e9 e4 f0 ff ff       	jmp    80105d27 <alltraps>

80106c43 <vector249>:
.globl vector249
vector249:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $249
80106c45:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106c4a:	e9 d8 f0 ff ff       	jmp    80105d27 <alltraps>

80106c4f <vector250>:
.globl vector250
vector250:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $250
80106c51:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106c56:	e9 cc f0 ff ff       	jmp    80105d27 <alltraps>

80106c5b <vector251>:
.globl vector251
vector251:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $251
80106c5d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106c62:	e9 c0 f0 ff ff       	jmp    80105d27 <alltraps>

80106c67 <vector252>:
.globl vector252
vector252:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $252
80106c69:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106c6e:	e9 b4 f0 ff ff       	jmp    80105d27 <alltraps>

80106c73 <vector253>:
.globl vector253
vector253:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $253
80106c75:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106c7a:	e9 a8 f0 ff ff       	jmp    80105d27 <alltraps>

80106c7f <vector254>:
.globl vector254
vector254:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $254
80106c81:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106c86:	e9 9c f0 ff ff       	jmp    80105d27 <alltraps>

80106c8b <vector255>:
.globl vector255
vector255:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $255
80106c8d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106c92:	e9 90 f0 ff ff       	jmp    80105d27 <alltraps>
80106c97:	66 90                	xchg   %ax,%ax
80106c99:	66 90                	xchg   %ax,%ax
80106c9b:	66 90                	xchg   %ax,%ax
80106c9d:	66 90                	xchg   %ax,%ax
80106c9f:	90                   	nop

80106ca0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	57                   	push   %edi
80106ca4:	56                   	push   %esi
80106ca5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106ca6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106cac:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106cb2:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80106cb5:	39 d3                	cmp    %edx,%ebx
80106cb7:	73 56                	jae    80106d0f <deallocuvm.part.0+0x6f>
80106cb9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106cbc:	89 c6                	mov    %eax,%esi
80106cbe:	89 d7                	mov    %edx,%edi
80106cc0:	eb 12                	jmp    80106cd4 <deallocuvm.part.0+0x34>
80106cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106cc8:	83 c2 01             	add    $0x1,%edx
80106ccb:	89 d3                	mov    %edx,%ebx
80106ccd:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106cd0:	39 fb                	cmp    %edi,%ebx
80106cd2:	73 38                	jae    80106d0c <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
80106cd4:	89 da                	mov    %ebx,%edx
80106cd6:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106cd9:	8b 04 96             	mov    (%esi,%edx,4),%eax
80106cdc:	a8 01                	test   $0x1,%al
80106cde:	74 e8                	je     80106cc8 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80106ce0:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106ce2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106ce7:	c1 e9 0a             	shr    $0xa,%ecx
80106cea:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106cf0:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106cf7:	85 c0                	test   %eax,%eax
80106cf9:	74 cd                	je     80106cc8 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
80106cfb:	8b 10                	mov    (%eax),%edx
80106cfd:	f6 c2 01             	test   $0x1,%dl
80106d00:	75 1e                	jne    80106d20 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
80106d02:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d08:	39 fb                	cmp    %edi,%ebx
80106d0a:	72 c8                	jb     80106cd4 <deallocuvm.part.0+0x34>
80106d0c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106d0f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d12:	89 c8                	mov    %ecx,%eax
80106d14:	5b                   	pop    %ebx
80106d15:	5e                   	pop    %esi
80106d16:	5f                   	pop    %edi
80106d17:	5d                   	pop    %ebp
80106d18:	c3                   	ret
80106d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106d20:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106d26:	74 26                	je     80106d4e <deallocuvm.part.0+0xae>
      kfree(v);
80106d28:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106d2b:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106d31:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106d34:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106d3a:	52                   	push   %edx
80106d3b:	e8 00 b8 ff ff       	call   80102540 <kfree>
      *pte = 0;
80106d40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106d43:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106d46:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106d4c:	eb 82                	jmp    80106cd0 <deallocuvm.part.0+0x30>
        panic("kfree");
80106d4e:	83 ec 0c             	sub    $0xc,%esp
80106d51:	68 c6 78 10 80       	push   $0x801078c6
80106d56:	e8 25 96 ff ff       	call   80100380 <panic>
80106d5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106d5f:	90                   	nop

80106d60 <mappages>:
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	57                   	push   %edi
80106d64:	56                   	push   %esi
80106d65:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106d66:	89 d3                	mov    %edx,%ebx
80106d68:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106d6e:	83 ec 1c             	sub    $0x1c,%esp
80106d71:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106d74:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106d78:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d7d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106d80:	8b 45 08             	mov    0x8(%ebp),%eax
80106d83:	29 d8                	sub    %ebx,%eax
80106d85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d88:	eb 3f                	jmp    80106dc9 <mappages+0x69>
80106d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106d90:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106d92:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106d97:	c1 ea 0a             	shr    $0xa,%edx
80106d9a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106da0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106da7:	85 c0                	test   %eax,%eax
80106da9:	74 75                	je     80106e20 <mappages+0xc0>
    if(*pte & PTE_P)
80106dab:	f6 00 01             	testb  $0x1,(%eax)
80106dae:	0f 85 86 00 00 00    	jne    80106e3a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106db4:	0b 75 0c             	or     0xc(%ebp),%esi
80106db7:	83 ce 01             	or     $0x1,%esi
80106dba:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106dbc:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106dbf:	39 c3                	cmp    %eax,%ebx
80106dc1:	74 6d                	je     80106e30 <mappages+0xd0>
    a += PGSIZE;
80106dc3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106dc9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106dcc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106dcf:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80106dd2:	89 d8                	mov    %ebx,%eax
80106dd4:	c1 e8 16             	shr    $0x16,%eax
80106dd7:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106dda:	8b 07                	mov    (%edi),%eax
80106ddc:	a8 01                	test   $0x1,%al
80106dde:	75 b0                	jne    80106d90 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106de0:	e8 1b b9 ff ff       	call   80102700 <kalloc>
80106de5:	85 c0                	test   %eax,%eax
80106de7:	74 37                	je     80106e20 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106de9:	83 ec 04             	sub    $0x4,%esp
80106dec:	68 00 10 00 00       	push   $0x1000
80106df1:	6a 00                	push   $0x0
80106df3:	50                   	push   %eax
80106df4:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106df7:	e8 d4 db ff ff       	call   801049d0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106dfc:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106dff:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106e02:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106e08:	83 c8 07             	or     $0x7,%eax
80106e0b:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106e0d:	89 d8                	mov    %ebx,%eax
80106e0f:	c1 e8 0a             	shr    $0xa,%eax
80106e12:	25 fc 0f 00 00       	and    $0xffc,%eax
80106e17:	01 d0                	add    %edx,%eax
80106e19:	eb 90                	jmp    80106dab <mappages+0x4b>
80106e1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106e1f:	90                   	nop
}
80106e20:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106e23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e28:	5b                   	pop    %ebx
80106e29:	5e                   	pop    %esi
80106e2a:	5f                   	pop    %edi
80106e2b:	5d                   	pop    %ebp
80106e2c:	c3                   	ret
80106e2d:	8d 76 00             	lea    0x0(%esi),%esi
80106e30:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106e33:	31 c0                	xor    %eax,%eax
}
80106e35:	5b                   	pop    %ebx
80106e36:	5e                   	pop    %esi
80106e37:	5f                   	pop    %edi
80106e38:	5d                   	pop    %ebp
80106e39:	c3                   	ret
      panic("remap");
80106e3a:	83 ec 0c             	sub    $0xc,%esp
80106e3d:	68 88 7d 10 80       	push   $0x80107d88
80106e42:	e8 39 95 ff ff       	call   80100380 <panic>
80106e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e4e:	66 90                	xchg   %ax,%ax

80106e50 <seginit>:
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106e56:	e8 e5 ca ff ff       	call   80103940 <cpuid>
  pd[0] = size-1;
80106e5b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106e60:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106e66:	c7 80 f8 c1 11 80 ff 	movl   $0xffff,-0x7fee3e08(%eax)
80106e6d:	ff 00 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e70:	c7 80 00 c2 11 80 ff 	movl   $0xffff,-0x7fee3e00(%eax)
80106e77:	ff 00 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e7a:	c7 80 08 c2 11 80 ff 	movl   $0xffff,-0x7fee3df8(%eax)
80106e81:	ff 00 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106e84:	c7 80 10 c2 11 80 ff 	movl   $0xffff,-0x7fee3df0(%eax)
80106e8b:	ff 00 00 
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106e8e:	c7 80 fc c1 11 80 00 	movl   $0xcf9a00,-0x7fee3e04(%eax)
80106e95:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e98:	c7 80 04 c2 11 80 00 	movl   $0xcf9200,-0x7fee3dfc(%eax)
80106e9f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ea2:	c7 80 0c c2 11 80 00 	movl   $0xcffa00,-0x7fee3df4(%eax)
80106ea9:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106eac:	c7 80 14 c2 11 80 00 	movl   $0xcff200,-0x7fee3dec(%eax)
80106eb3:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106eb6:	05 f0 c1 11 80       	add    $0x8011c1f0,%eax
80106ebb:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106ebf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106ec3:	c1 e8 10             	shr    $0x10,%eax
80106ec6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106eca:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ecd:	0f 01 10             	lgdtl  (%eax)
}
80106ed0:	c9                   	leave
80106ed1:	c3                   	ret
80106ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ee0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ee0:	a1 a4 f0 11 80       	mov    0x8011f0a4,%eax
80106ee5:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106eea:	0f 22 d8             	mov    %eax,%cr3
}
80106eed:	c3                   	ret
80106eee:	66 90                	xchg   %ax,%ax

80106ef0 <switchuvm>:
{
80106ef0:	55                   	push   %ebp
80106ef1:	89 e5                	mov    %esp,%ebp
80106ef3:	57                   	push   %edi
80106ef4:	56                   	push   %esi
80106ef5:	53                   	push   %ebx
80106ef6:	83 ec 1c             	sub    $0x1c,%esp
80106ef9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106efc:	85 f6                	test   %esi,%esi
80106efe:	0f 84 cb 00 00 00    	je     80106fcf <switchuvm+0xdf>
  if(p->kstack == 0)
80106f04:	8b 46 08             	mov    0x8(%esi),%eax
80106f07:	85 c0                	test   %eax,%eax
80106f09:	0f 84 da 00 00 00    	je     80106fe9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106f0f:	8b 46 04             	mov    0x4(%esi),%eax
80106f12:	85 c0                	test   %eax,%eax
80106f14:	0f 84 c2 00 00 00    	je     80106fdc <switchuvm+0xec>
  pushcli();
80106f1a:	e8 d1 d8 ff ff       	call   801047f0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106f1f:	e8 bc c9 ff ff       	call   801038e0 <mycpu>
80106f24:	89 c3                	mov    %eax,%ebx
80106f26:	e8 b5 c9 ff ff       	call   801038e0 <mycpu>
80106f2b:	89 c7                	mov    %eax,%edi
80106f2d:	e8 ae c9 ff ff       	call   801038e0 <mycpu>
80106f32:	83 c7 08             	add    $0x8,%edi
80106f35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f38:	e8 a3 c9 ff ff       	call   801038e0 <mycpu>
80106f3d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106f40:	ba 67 00 00 00       	mov    $0x67,%edx
80106f45:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106f4c:	83 c0 08             	add    $0x8,%eax
80106f4f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106f56:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106f5b:	83 c1 08             	add    $0x8,%ecx
80106f5e:	c1 e8 18             	shr    $0x18,%eax
80106f61:	c1 e9 10             	shr    $0x10,%ecx
80106f64:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106f6a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106f70:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106f75:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106f7c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106f81:	e8 5a c9 ff ff       	call   801038e0 <mycpu>
80106f86:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106f8d:	e8 4e c9 ff ff       	call   801038e0 <mycpu>
80106f92:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106f96:	8b 5e 08             	mov    0x8(%esi),%ebx
80106f99:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f9f:	e8 3c c9 ff ff       	call   801038e0 <mycpu>
80106fa4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106fa7:	e8 34 c9 ff ff       	call   801038e0 <mycpu>
80106fac:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106fb0:	b8 28 00 00 00       	mov    $0x28,%eax
80106fb5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106fb8:	8b 46 04             	mov    0x4(%esi),%eax
80106fbb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106fc0:	0f 22 d8             	mov    %eax,%cr3
}
80106fc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fc6:	5b                   	pop    %ebx
80106fc7:	5e                   	pop    %esi
80106fc8:	5f                   	pop    %edi
80106fc9:	5d                   	pop    %ebp
  popcli();
80106fca:	e9 51 d9 ff ff       	jmp    80104920 <popcli>
    panic("switchuvm: no process");
80106fcf:	83 ec 0c             	sub    $0xc,%esp
80106fd2:	68 8e 7d 10 80       	push   $0x80107d8e
80106fd7:	e8 a4 93 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106fdc:	83 ec 0c             	sub    $0xc,%esp
80106fdf:	68 b9 7d 10 80       	push   $0x80107db9
80106fe4:	e8 97 93 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106fe9:	83 ec 0c             	sub    $0xc,%esp
80106fec:	68 a4 7d 10 80       	push   $0x80107da4
80106ff1:	e8 8a 93 ff ff       	call   80100380 <panic>
80106ff6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ffd:	8d 76 00             	lea    0x0(%esi),%esi

80107000 <inituvm>:
{
80107000:	55                   	push   %ebp
80107001:	89 e5                	mov    %esp,%ebp
80107003:	57                   	push   %edi
80107004:	56                   	push   %esi
80107005:	53                   	push   %ebx
80107006:	83 ec 1c             	sub    $0x1c,%esp
80107009:	8b 45 08             	mov    0x8(%ebp),%eax
8010700c:	8b 75 10             	mov    0x10(%ebp),%esi
8010700f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107012:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107015:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010701b:	77 49                	ja     80107066 <inituvm+0x66>
  mem = kalloc();
8010701d:	e8 de b6 ff ff       	call   80102700 <kalloc>
  memset(mem, 0, PGSIZE);
80107022:	83 ec 04             	sub    $0x4,%esp
80107025:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010702a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010702c:	6a 00                	push   $0x0
8010702e:	50                   	push   %eax
8010702f:	e8 9c d9 ff ff       	call   801049d0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107034:	58                   	pop    %eax
80107035:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010703b:	5a                   	pop    %edx
8010703c:	6a 06                	push   $0x6
8010703e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107043:	31 d2                	xor    %edx,%edx
80107045:	50                   	push   %eax
80107046:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107049:	e8 12 fd ff ff       	call   80106d60 <mappages>
  memmove(mem, init, sz);
8010704e:	89 75 10             	mov    %esi,0x10(%ebp)
80107051:	83 c4 10             	add    $0x10,%esp
80107054:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107057:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010705a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010705d:	5b                   	pop    %ebx
8010705e:	5e                   	pop    %esi
8010705f:	5f                   	pop    %edi
80107060:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107061:	e9 fa d9 ff ff       	jmp    80104a60 <memmove>
    panic("inituvm: more than a page");
80107066:	83 ec 0c             	sub    $0xc,%esp
80107069:	68 cd 7d 10 80       	push   $0x80107dcd
8010706e:	e8 0d 93 ff ff       	call   80100380 <panic>
80107073:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010707a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107080 <loaduvm>:
{
80107080:	55                   	push   %ebp
80107081:	89 e5                	mov    %esp,%ebp
80107083:	57                   	push   %edi
80107084:	56                   	push   %esi
80107085:	53                   	push   %ebx
80107086:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107089:	8b 75 0c             	mov    0xc(%ebp),%esi
{
8010708c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
8010708f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80107095:	0f 85 a2 00 00 00    	jne    8010713d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
8010709b:	85 ff                	test   %edi,%edi
8010709d:	74 7d                	je     8010711c <loaduvm+0x9c>
8010709f:	90                   	nop
  pde = &pgdir[PDX(va)];
801070a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801070a3:	8b 55 08             	mov    0x8(%ebp),%edx
801070a6:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
801070a8:	89 c1                	mov    %eax,%ecx
801070aa:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801070ad:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
801070b0:	f6 c1 01             	test   $0x1,%cl
801070b3:	75 13                	jne    801070c8 <loaduvm+0x48>
      panic("loaduvm: address should exist");
801070b5:	83 ec 0c             	sub    $0xc,%esp
801070b8:	68 e7 7d 10 80       	push   $0x80107de7
801070bd:	e8 be 92 ff ff       	call   80100380 <panic>
801070c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801070c8:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801070cb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801070d1:	25 fc 0f 00 00       	and    $0xffc,%eax
801070d6:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801070dd:	85 c9                	test   %ecx,%ecx
801070df:	74 d4                	je     801070b5 <loaduvm+0x35>
    if(sz - i < PGSIZE)
801070e1:	89 fb                	mov    %edi,%ebx
801070e3:	b8 00 10 00 00       	mov    $0x1000,%eax
801070e8:	29 f3                	sub    %esi,%ebx
801070ea:	39 c3                	cmp    %eax,%ebx
801070ec:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
801070ef:	53                   	push   %ebx
801070f0:	8b 45 14             	mov    0x14(%ebp),%eax
801070f3:	01 f0                	add    %esi,%eax
801070f5:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
801070f6:	8b 01                	mov    (%ecx),%eax
801070f8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801070fd:	05 00 00 00 80       	add    $0x80000000,%eax
80107102:	50                   	push   %eax
80107103:	ff 75 10             	push   0x10(%ebp)
80107106:	e8 f5 a9 ff ff       	call   80101b00 <readi>
8010710b:	83 c4 10             	add    $0x10,%esp
8010710e:	39 d8                	cmp    %ebx,%eax
80107110:	75 1e                	jne    80107130 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80107112:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107118:	39 fe                	cmp    %edi,%esi
8010711a:	72 84                	jb     801070a0 <loaduvm+0x20>
}
8010711c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010711f:	31 c0                	xor    %eax,%eax
}
80107121:	5b                   	pop    %ebx
80107122:	5e                   	pop    %esi
80107123:	5f                   	pop    %edi
80107124:	5d                   	pop    %ebp
80107125:	c3                   	ret
80107126:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010712d:	8d 76 00             	lea    0x0(%esi),%esi
80107130:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107133:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107138:	5b                   	pop    %ebx
80107139:	5e                   	pop    %esi
8010713a:	5f                   	pop    %edi
8010713b:	5d                   	pop    %ebp
8010713c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
8010713d:	83 ec 0c             	sub    $0xc,%esp
80107140:	68 88 7e 10 80       	push   $0x80107e88
80107145:	e8 36 92 ff ff       	call   80100380 <panic>
8010714a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107150 <allocuvm>:
{
80107150:	55                   	push   %ebp
80107151:	89 e5                	mov    %esp,%ebp
80107153:	57                   	push   %edi
80107154:	56                   	push   %esi
80107155:	53                   	push   %ebx
80107156:	83 ec 1c             	sub    $0x1c,%esp
80107159:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
8010715c:	85 f6                	test   %esi,%esi
8010715e:	0f 88 98 00 00 00    	js     801071fc <allocuvm+0xac>
80107164:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80107166:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107169:	0f 82 a1 00 00 00    	jb     80107210 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010716f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107172:	05 ff 0f 00 00       	add    $0xfff,%eax
80107177:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010717c:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
8010717e:	39 f0                	cmp    %esi,%eax
80107180:	0f 83 8d 00 00 00    	jae    80107213 <allocuvm+0xc3>
80107186:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80107189:	eb 44                	jmp    801071cf <allocuvm+0x7f>
8010718b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010718f:	90                   	nop
    memset(mem, 0, PGSIZE);
80107190:	83 ec 04             	sub    $0x4,%esp
80107193:	68 00 10 00 00       	push   $0x1000
80107198:	6a 00                	push   $0x0
8010719a:	50                   	push   %eax
8010719b:	e8 30 d8 ff ff       	call   801049d0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801071a0:	58                   	pop    %eax
801071a1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801071a7:	5a                   	pop    %edx
801071a8:	6a 06                	push   $0x6
801071aa:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071af:	89 fa                	mov    %edi,%edx
801071b1:	50                   	push   %eax
801071b2:	8b 45 08             	mov    0x8(%ebp),%eax
801071b5:	e8 a6 fb ff ff       	call   80106d60 <mappages>
801071ba:	83 c4 10             	add    $0x10,%esp
801071bd:	85 c0                	test   %eax,%eax
801071bf:	78 5f                	js     80107220 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
801071c1:	81 c7 00 10 00 00    	add    $0x1000,%edi
801071c7:	39 f7                	cmp    %esi,%edi
801071c9:	0f 83 89 00 00 00    	jae    80107258 <allocuvm+0x108>
    mem = kalloc();
801071cf:	e8 2c b5 ff ff       	call   80102700 <kalloc>
801071d4:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801071d6:	85 c0                	test   %eax,%eax
801071d8:	75 b6                	jne    80107190 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801071da:	83 ec 0c             	sub    $0xc,%esp
801071dd:	68 05 7e 10 80       	push   $0x80107e05
801071e2:	e8 c9 94 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
801071e7:	83 c4 10             	add    $0x10,%esp
801071ea:	3b 75 0c             	cmp    0xc(%ebp),%esi
801071ed:	74 0d                	je     801071fc <allocuvm+0xac>
801071ef:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801071f2:	8b 45 08             	mov    0x8(%ebp),%eax
801071f5:	89 f2                	mov    %esi,%edx
801071f7:	e8 a4 fa ff ff       	call   80106ca0 <deallocuvm.part.0>
    return 0;
801071fc:	31 d2                	xor    %edx,%edx
}
801071fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107201:	89 d0                	mov    %edx,%eax
80107203:	5b                   	pop    %ebx
80107204:	5e                   	pop    %esi
80107205:	5f                   	pop    %edi
80107206:	5d                   	pop    %ebp
80107207:	c3                   	ret
80107208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010720f:	90                   	nop
    return oldsz;
80107210:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80107213:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107216:	89 d0                	mov    %edx,%eax
80107218:	5b                   	pop    %ebx
80107219:	5e                   	pop    %esi
8010721a:	5f                   	pop    %edi
8010721b:	5d                   	pop    %ebp
8010721c:	c3                   	ret
8010721d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107220:	83 ec 0c             	sub    $0xc,%esp
80107223:	68 1d 7e 10 80       	push   $0x80107e1d
80107228:	e8 83 94 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
8010722d:	83 c4 10             	add    $0x10,%esp
80107230:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107233:	74 0d                	je     80107242 <allocuvm+0xf2>
80107235:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107238:	8b 45 08             	mov    0x8(%ebp),%eax
8010723b:	89 f2                	mov    %esi,%edx
8010723d:	e8 5e fa ff ff       	call   80106ca0 <deallocuvm.part.0>
      kfree(mem);
80107242:	83 ec 0c             	sub    $0xc,%esp
80107245:	53                   	push   %ebx
80107246:	e8 f5 b2 ff ff       	call   80102540 <kfree>
      return 0;
8010724b:	83 c4 10             	add    $0x10,%esp
    return 0;
8010724e:	31 d2                	xor    %edx,%edx
80107250:	eb ac                	jmp    801071fe <allocuvm+0xae>
80107252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107258:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
8010725b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010725e:	5b                   	pop    %ebx
8010725f:	5e                   	pop    %esi
80107260:	89 d0                	mov    %edx,%eax
80107262:	5f                   	pop    %edi
80107263:	5d                   	pop    %ebp
80107264:	c3                   	ret
80107265:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010726c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107270 <deallocuvm>:
{
80107270:	55                   	push   %ebp
80107271:	89 e5                	mov    %esp,%ebp
80107273:	8b 55 0c             	mov    0xc(%ebp),%edx
80107276:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107279:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010727c:	39 d1                	cmp    %edx,%ecx
8010727e:	73 10                	jae    80107290 <deallocuvm+0x20>
}
80107280:	5d                   	pop    %ebp
80107281:	e9 1a fa ff ff       	jmp    80106ca0 <deallocuvm.part.0>
80107286:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010728d:	8d 76 00             	lea    0x0(%esi),%esi
80107290:	89 d0                	mov    %edx,%eax
80107292:	5d                   	pop    %ebp
80107293:	c3                   	ret
80107294:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010729b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010729f:	90                   	nop

801072a0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801072a0:	55                   	push   %ebp
801072a1:	89 e5                	mov    %esp,%ebp
801072a3:	57                   	push   %edi
801072a4:	56                   	push   %esi
801072a5:	53                   	push   %ebx
801072a6:	83 ec 0c             	sub    $0xc,%esp
801072a9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801072ac:	85 f6                	test   %esi,%esi
801072ae:	74 59                	je     80107309 <freevm+0x69>
  if(newsz >= oldsz)
801072b0:	31 c9                	xor    %ecx,%ecx
801072b2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801072b7:	89 f0                	mov    %esi,%eax
801072b9:	89 f3                	mov    %esi,%ebx
801072bb:	e8 e0 f9 ff ff       	call   80106ca0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801072c0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801072c6:	eb 0f                	jmp    801072d7 <freevm+0x37>
801072c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072cf:	90                   	nop
801072d0:	83 c3 04             	add    $0x4,%ebx
801072d3:	39 fb                	cmp    %edi,%ebx
801072d5:	74 23                	je     801072fa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801072d7:	8b 03                	mov    (%ebx),%eax
801072d9:	a8 01                	test   $0x1,%al
801072db:	74 f3                	je     801072d0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801072dd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801072e2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
801072e5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801072e8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801072ed:	50                   	push   %eax
801072ee:	e8 4d b2 ff ff       	call   80102540 <kfree>
801072f3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801072f6:	39 fb                	cmp    %edi,%ebx
801072f8:	75 dd                	jne    801072d7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801072fa:	89 75 08             	mov    %esi,0x8(%ebp)
}
801072fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107300:	5b                   	pop    %ebx
80107301:	5e                   	pop    %esi
80107302:	5f                   	pop    %edi
80107303:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107304:	e9 37 b2 ff ff       	jmp    80102540 <kfree>
    panic("freevm: no pgdir");
80107309:	83 ec 0c             	sub    $0xc,%esp
8010730c:	68 39 7e 10 80       	push   $0x80107e39
80107311:	e8 6a 90 ff ff       	call   80100380 <panic>
80107316:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010731d:	8d 76 00             	lea    0x0(%esi),%esi

80107320 <setupkvm>:
{
80107320:	55                   	push   %ebp
80107321:	89 e5                	mov    %esp,%ebp
80107323:	56                   	push   %esi
80107324:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107325:	e8 d6 b3 ff ff       	call   80102700 <kalloc>
8010732a:	85 c0                	test   %eax,%eax
8010732c:	74 5e                	je     8010738c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
8010732e:	83 ec 04             	sub    $0x4,%esp
80107331:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107333:	bb 20 94 10 80       	mov    $0x80109420,%ebx
  memset(pgdir, 0, PGSIZE);
80107338:	68 00 10 00 00       	push   $0x1000
8010733d:	6a 00                	push   $0x0
8010733f:	50                   	push   %eax
80107340:	e8 8b d6 ff ff       	call   801049d0 <memset>
80107345:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107348:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010734b:	83 ec 08             	sub    $0x8,%esp
8010734e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107351:	8b 13                	mov    (%ebx),%edx
80107353:	ff 73 0c             	push   0xc(%ebx)
80107356:	50                   	push   %eax
80107357:	29 c1                	sub    %eax,%ecx
80107359:	89 f0                	mov    %esi,%eax
8010735b:	e8 00 fa ff ff       	call   80106d60 <mappages>
80107360:	83 c4 10             	add    $0x10,%esp
80107363:	85 c0                	test   %eax,%eax
80107365:	78 19                	js     80107380 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107367:	83 c3 10             	add    $0x10,%ebx
8010736a:	81 fb 60 94 10 80    	cmp    $0x80109460,%ebx
80107370:	75 d6                	jne    80107348 <setupkvm+0x28>
}
80107372:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107375:	89 f0                	mov    %esi,%eax
80107377:	5b                   	pop    %ebx
80107378:	5e                   	pop    %esi
80107379:	5d                   	pop    %ebp
8010737a:	c3                   	ret
8010737b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010737f:	90                   	nop
      freevm(pgdir);
80107380:	83 ec 0c             	sub    $0xc,%esp
80107383:	56                   	push   %esi
80107384:	e8 17 ff ff ff       	call   801072a0 <freevm>
      return 0;
80107389:	83 c4 10             	add    $0x10,%esp
}
8010738c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
8010738f:	31 f6                	xor    %esi,%esi
}
80107391:	89 f0                	mov    %esi,%eax
80107393:	5b                   	pop    %ebx
80107394:	5e                   	pop    %esi
80107395:	5d                   	pop    %ebp
80107396:	c3                   	ret
80107397:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010739e:	66 90                	xchg   %ax,%ax

801073a0 <kvmalloc>:
{
801073a0:	55                   	push   %ebp
801073a1:	89 e5                	mov    %esp,%ebp
801073a3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801073a6:	e8 75 ff ff ff       	call   80107320 <setupkvm>
801073ab:	a3 a4 f0 11 80       	mov    %eax,0x8011f0a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801073b0:	05 00 00 00 80       	add    $0x80000000,%eax
801073b5:	0f 22 d8             	mov    %eax,%cr3
}
801073b8:	c9                   	leave
801073b9:	c3                   	ret
801073ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801073c0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801073c0:	55                   	push   %ebp
801073c1:	89 e5                	mov    %esp,%ebp
801073c3:	83 ec 08             	sub    $0x8,%esp
801073c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801073c9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801073cc:	89 c1                	mov    %eax,%ecx
801073ce:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801073d1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801073d4:	f6 c2 01             	test   $0x1,%dl
801073d7:	75 17                	jne    801073f0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801073d9:	83 ec 0c             	sub    $0xc,%esp
801073dc:	68 4a 7e 10 80       	push   $0x80107e4a
801073e1:	e8 9a 8f ff ff       	call   80100380 <panic>
801073e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073ed:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801073f0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801073f3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801073f9:	25 fc 0f 00 00       	and    $0xffc,%eax
801073fe:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107405:	85 c0                	test   %eax,%eax
80107407:	74 d0                	je     801073d9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107409:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010740c:	c9                   	leave
8010740d:	c3                   	ret
8010740e:	66 90                	xchg   %ax,%ax

80107410 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107410:	55                   	push   %ebp
80107411:	89 e5                	mov    %esp,%ebp
80107413:	57                   	push   %edi
80107414:	56                   	push   %esi
80107415:	53                   	push   %ebx
80107416:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107419:	e8 02 ff ff ff       	call   80107320 <setupkvm>
8010741e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107421:	85 c0                	test   %eax,%eax
80107423:	0f 84 dd 00 00 00    	je     80107506 <copyuvm+0xf6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107429:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010742c:	85 c9                	test   %ecx,%ecx
8010742e:	0f 84 b3 00 00 00    	je     801074e7 <copyuvm+0xd7>
80107434:	31 f6                	xor    %esi,%esi
80107436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010743d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107440:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107443:	89 f0                	mov    %esi,%eax
80107445:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107448:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010744b:	a8 01                	test   $0x1,%al
8010744d:	75 11                	jne    80107460 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010744f:	83 ec 0c             	sub    $0xc,%esp
80107452:	68 54 7e 10 80       	push   $0x80107e54
80107457:	e8 24 8f ff ff       	call   80100380 <panic>
8010745c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107460:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107462:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107467:	c1 ea 0a             	shr    $0xa,%edx
8010746a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107470:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107477:	85 c0                	test   %eax,%eax
80107479:	74 d4                	je     8010744f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010747b:	8b 18                	mov    (%eax),%ebx
8010747d:	f6 c3 01             	test   $0x1,%bl
80107480:	0f 84 92 00 00 00    	je     80107518 <copyuvm+0x108>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107486:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
80107488:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
8010748e:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107494:	e8 67 b2 ff ff       	call   80102700 <kalloc>
80107499:	85 c0                	test   %eax,%eax
8010749b:	74 5b                	je     801074f8 <copyuvm+0xe8>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
8010749d:	83 ec 04             	sub    $0x4,%esp
801074a0:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801074a6:	68 00 10 00 00       	push   $0x1000
801074ab:	57                   	push   %edi
801074ac:	50                   	push   %eax
801074ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801074b0:	e8 ab d5 ff ff       	call   80104a60 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
801074b5:	58                   	pop    %eax
801074b6:	5a                   	pop    %edx
801074b7:	53                   	push   %ebx
801074b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801074bb:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074c0:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801074c6:	52                   	push   %edx
801074c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801074ca:	89 f2                	mov    %esi,%edx
801074cc:	e8 8f f8 ff ff       	call   80106d60 <mappages>
801074d1:	83 c4 10             	add    $0x10,%esp
801074d4:	85 c0                	test   %eax,%eax
801074d6:	78 20                	js     801074f8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801074d8:	81 c6 00 10 00 00    	add    $0x1000,%esi
801074de:	3b 75 0c             	cmp    0xc(%ebp),%esi
801074e1:	0f 82 59 ff ff ff    	jb     80107440 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
801074e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801074ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074ed:	5b                   	pop    %ebx
801074ee:	5e                   	pop    %esi
801074ef:	5f                   	pop    %edi
801074f0:	5d                   	pop    %ebp
801074f1:	c3                   	ret
801074f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(d);
801074f8:	83 ec 0c             	sub    $0xc,%esp
801074fb:	ff 75 e0             	push   -0x20(%ebp)
801074fe:	e8 9d fd ff ff       	call   801072a0 <freevm>
  return 0;
80107503:	83 c4 10             	add    $0x10,%esp
    return 0;
80107506:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
8010750d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107510:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107513:	5b                   	pop    %ebx
80107514:	5e                   	pop    %esi
80107515:	5f                   	pop    %edi
80107516:	5d                   	pop    %ebp
80107517:	c3                   	ret
      panic("copyuvm: page not present");
80107518:	83 ec 0c             	sub    $0xc,%esp
8010751b:	68 6e 7e 10 80       	push   $0x80107e6e
80107520:	e8 5b 8e ff ff       	call   80100380 <panic>
80107525:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010752c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107530 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107530:	55                   	push   %ebp
80107531:	89 e5                	mov    %esp,%ebp
80107533:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107536:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107539:	89 c1                	mov    %eax,%ecx
8010753b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010753e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107541:	f6 c2 01             	test   $0x1,%dl
80107544:	0f 84 00 01 00 00    	je     8010764a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010754a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010754d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107553:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107554:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107559:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107560:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107562:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107567:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010756a:	05 00 00 00 80       	add    $0x80000000,%eax
8010756f:	83 fa 05             	cmp    $0x5,%edx
80107572:	ba 00 00 00 00       	mov    $0x0,%edx
80107577:	0f 45 c2             	cmovne %edx,%eax
}
8010757a:	c3                   	ret
8010757b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010757f:	90                   	nop

80107580 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107580:	55                   	push   %ebp
80107581:	89 e5                	mov    %esp,%ebp
80107583:	57                   	push   %edi
80107584:	56                   	push   %esi
80107585:	53                   	push   %ebx
80107586:	83 ec 0c             	sub    $0xc,%esp
80107589:	8b 75 14             	mov    0x14(%ebp),%esi
8010758c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010758f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107592:	85 f6                	test   %esi,%esi
80107594:	75 51                	jne    801075e7 <copyout+0x67>
80107596:	e9 a5 00 00 00       	jmp    80107640 <copyout+0xc0>
8010759b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010759f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
801075a0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801075a6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801075ac:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801075b2:	74 75                	je     80107629 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
801075b4:	89 fb                	mov    %edi,%ebx
801075b6:	29 c3                	sub    %eax,%ebx
801075b8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801075be:	39 f3                	cmp    %esi,%ebx
801075c0:	0f 47 de             	cmova  %esi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801075c3:	29 f8                	sub    %edi,%eax
801075c5:	83 ec 04             	sub    $0x4,%esp
801075c8:	01 c1                	add    %eax,%ecx
801075ca:	53                   	push   %ebx
801075cb:	52                   	push   %edx
801075cc:	89 55 10             	mov    %edx,0x10(%ebp)
801075cf:	51                   	push   %ecx
801075d0:	e8 8b d4 ff ff       	call   80104a60 <memmove>
    len -= n;
    buf += n;
801075d5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
801075d8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
801075de:	83 c4 10             	add    $0x10,%esp
    buf += n;
801075e1:	01 da                	add    %ebx,%edx
  while(len > 0){
801075e3:	29 de                	sub    %ebx,%esi
801075e5:	74 59                	je     80107640 <copyout+0xc0>
  if(*pde & PTE_P){
801075e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
801075ea:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801075ec:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
801075ee:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801075f1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801075f7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801075fa:	f6 c1 01             	test   $0x1,%cl
801075fd:	0f 84 4e 00 00 00    	je     80107651 <copyout.cold>
  return &pgtab[PTX(va)];
80107603:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107605:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010760b:	c1 eb 0c             	shr    $0xc,%ebx
8010760e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107614:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010761b:	89 d9                	mov    %ebx,%ecx
8010761d:	83 e1 05             	and    $0x5,%ecx
80107620:	83 f9 05             	cmp    $0x5,%ecx
80107623:	0f 84 77 ff ff ff    	je     801075a0 <copyout+0x20>
  }
  return 0;
}
80107629:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010762c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107631:	5b                   	pop    %ebx
80107632:	5e                   	pop    %esi
80107633:	5f                   	pop    %edi
80107634:	5d                   	pop    %ebp
80107635:	c3                   	ret
80107636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010763d:	8d 76 00             	lea    0x0(%esi),%esi
80107640:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107643:	31 c0                	xor    %eax,%eax
}
80107645:	5b                   	pop    %ebx
80107646:	5e                   	pop    %esi
80107647:	5f                   	pop    %edi
80107648:	5d                   	pop    %ebp
80107649:	c3                   	ret

8010764a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010764a:	a1 00 00 00 00       	mov    0x0,%eax
8010764f:	0f 0b                	ud2

80107651 <copyout.cold>:
80107651:	a1 00 00 00 00       	mov    0x0,%eax
80107656:	0f 0b                	ud2
