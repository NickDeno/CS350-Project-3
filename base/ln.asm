
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  if(argc != 3){
   f:	83 39 03             	cmpl   $0x3,(%ecx)
{
  12:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  15:	74 13                	je     2a <main+0x2a>
    printf(2, "Usage: ln old new\n");
  17:	52                   	push   %edx
  18:	52                   	push   %edx
  19:	68 58 07 00 00       	push   $0x758
  1e:	6a 02                	push   $0x2
  20:	e8 0b 04 00 00       	call   430 <printf>
    exit();
  25:	e8 79 02 00 00       	call   2a3 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2a:	50                   	push   %eax
  2b:	50                   	push   %eax
  2c:	ff 73 08             	push   0x8(%ebx)
  2f:	ff 73 04             	push   0x4(%ebx)
  32:	e8 cc 02 00 00       	call   303 <link>
  37:	83 c4 10             	add    $0x10,%esp
  3a:	85 c0                	test   %eax,%eax
  3c:	78 05                	js     43 <main+0x43>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  3e:	e8 60 02 00 00       	call   2a3 <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  43:	ff 73 08             	push   0x8(%ebx)
  46:	ff 73 04             	push   0x4(%ebx)
  49:	68 6b 07 00 00       	push   $0x76b
  4e:	6a 02                	push   $0x2
  50:	e8 db 03 00 00       	call   430 <printf>
  55:	83 c4 10             	add    $0x10,%esp
  58:	eb e4                	jmp    3e <main+0x3e>
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  60:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  61:	31 c0                	xor    %eax,%eax
{
  63:	89 e5                	mov    %esp,%ebp
  65:	53                   	push   %ebx
  66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  70:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  74:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  77:	83 c0 01             	add    $0x1,%eax
  7a:	84 d2                	test   %dl,%dl
  7c:	75 f2                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  81:	89 c8                	mov    %ecx,%eax
  83:	c9                   	leave
  84:	c3                   	ret
  85:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	75 17                	jne    b8 <strcmp+0x28>
  a1:	eb 3a                	jmp    dd <strcmp+0x4d>
  a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  a7:	90                   	nop
  a8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  ac:	83 c2 01             	add    $0x1,%edx
  af:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  b2:	84 c0                	test   %al,%al
  b4:	74 1a                	je     d0 <strcmp+0x40>
    p++, q++;
  b6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
  b8:	0f b6 19             	movzbl (%ecx),%ebx
  bb:	38 c3                	cmp    %al,%bl
  bd:	74 e9                	je     a8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  bf:	29 d8                	sub    %ebx,%eax
}
  c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  c4:	c9                   	leave
  c5:	c3                   	ret
  c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  d0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  d4:	31 c0                	xor    %eax,%eax
  d6:	29 d8                	sub    %ebx,%eax
}
  d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  db:	c9                   	leave
  dc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  dd:	0f b6 19             	movzbl (%ecx),%ebx
  e0:	31 c0                	xor    %eax,%eax
  e2:	eb db                	jmp    bf <strcmp+0x2f>
  e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ef:	90                   	nop

000000f0 <strlen>:

uint
strlen(char *s)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  f6:	80 3a 00             	cmpb   $0x0,(%edx)
  f9:	74 15                	je     110 <strlen+0x20>
  fb:	31 c0                	xor    %eax,%eax
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	83 c0 01             	add    $0x1,%eax
 103:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 107:	89 c1                	mov    %eax,%ecx
 109:	75 f5                	jne    100 <strlen+0x10>
    ;
  return n;
}
 10b:	89 c8                	mov    %ecx,%eax
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret
 10f:	90                   	nop
  for(n = 0; s[n]; n++)
 110:	31 c9                	xor    %ecx,%ecx
}
 112:	5d                   	pop    %ebp
 113:	89 c8                	mov    %ecx,%eax
 115:	c3                   	ret
 116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11d:	8d 76 00             	lea    0x0(%esi),%esi

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 127:	8b 4d 10             	mov    0x10(%ebp),%ecx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld
 130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 132:	8b 7d fc             	mov    -0x4(%ebp),%edi
 135:	89 d0                	mov    %edx,%eax
 137:	c9                   	leave
 138:	c3                   	ret
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	84 d2                	test   %dl,%dl
 14f:	75 12                	jne    163 <strchr+0x23>
 151:	eb 1d                	jmp    170 <strchr+0x30>
 153:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 157:	90                   	nop
 158:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 15c:	83 c0 01             	add    $0x1,%eax
 15f:	84 d2                	test   %dl,%dl
 161:	74 0d                	je     170 <strchr+0x30>
    if(*s == c)
 163:	38 d1                	cmp    %dl,%cl
 165:	75 f1                	jne    158 <strchr+0x18>
      return (char*)s;
  return 0;
}
 167:	5d                   	pop    %ebp
 168:	c3                   	ret
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 170:	31 c0                	xor    %eax,%eax
}
 172:	5d                   	pop    %ebp
 173:	c3                   	ret
 174:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 17f:	90                   	nop

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 185:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 188:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 189:	31 db                	xor    %ebx,%ebx
{
 18b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 18e:	eb 27                	jmp    1b7 <gets+0x37>
    cc = read(0, &c, 1);
 190:	83 ec 04             	sub    $0x4,%esp
 193:	6a 01                	push   $0x1
 195:	56                   	push   %esi
 196:	6a 00                	push   $0x0
 198:	e8 1e 01 00 00       	call   2bb <read>
    if(cc < 1)
 19d:	83 c4 10             	add    $0x10,%esp
 1a0:	85 c0                	test   %eax,%eax
 1a2:	7e 1d                	jle    1c1 <gets+0x41>
      break;
    buf[i++] = c;
 1a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a8:	8b 55 08             	mov    0x8(%ebp),%edx
 1ab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1af:	3c 0a                	cmp    $0xa,%al
 1b1:	74 10                	je     1c3 <gets+0x43>
 1b3:	3c 0d                	cmp    $0xd,%al
 1b5:	74 0c                	je     1c3 <gets+0x43>
  for(i=0; i+1 < max; ){
 1b7:	89 df                	mov    %ebx,%edi
 1b9:	83 c3 01             	add    $0x1,%ebx
 1bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1bf:	7c cf                	jl     190 <gets+0x10>
 1c1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 1ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1cd:	5b                   	pop    %ebx
 1ce:	5e                   	pop    %esi
 1cf:	5f                   	pop    %edi
 1d0:	5d                   	pop    %ebp
 1d1:	c3                   	ret
 1d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001e0 <stat>:

int
stat(char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	56                   	push   %esi
 1e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e5:	83 ec 08             	sub    $0x8,%esp
 1e8:	6a 00                	push   $0x0
 1ea:	ff 75 08             	push   0x8(%ebp)
 1ed:	e8 f1 00 00 00       	call   2e3 <open>
  if(fd < 0)
 1f2:	83 c4 10             	add    $0x10,%esp
 1f5:	85 c0                	test   %eax,%eax
 1f7:	78 27                	js     220 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1f9:	83 ec 08             	sub    $0x8,%esp
 1fc:	ff 75 0c             	push   0xc(%ebp)
 1ff:	89 c3                	mov    %eax,%ebx
 201:	50                   	push   %eax
 202:	e8 f4 00 00 00       	call   2fb <fstat>
  close(fd);
 207:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 20a:	89 c6                	mov    %eax,%esi
  close(fd);
 20c:	e8 ba 00 00 00       	call   2cb <close>
  return r;
 211:	83 c4 10             	add    $0x10,%esp
}
 214:	8d 65 f8             	lea    -0x8(%ebp),%esp
 217:	89 f0                	mov    %esi,%eax
 219:	5b                   	pop    %ebx
 21a:	5e                   	pop    %esi
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret
 21d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 220:	be ff ff ff ff       	mov    $0xffffffff,%esi
 225:	eb ed                	jmp    214 <stat+0x34>
 227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22e:	66 90                	xchg   %ax,%ax

00000230 <atoi>:

int
atoi(const char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	53                   	push   %ebx
 234:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 237:	0f be 02             	movsbl (%edx),%eax
 23a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 23d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 240:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 245:	77 1e                	ja     265 <atoi+0x35>
 247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 250:	83 c2 01             	add    $0x1,%edx
 253:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 256:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 25a:	0f be 02             	movsbl (%edx),%eax
 25d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 260:	80 fb 09             	cmp    $0x9,%bl
 263:	76 eb                	jbe    250 <atoi+0x20>
  return n;
}
 265:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 268:	89 c8                	mov    %ecx,%eax
 26a:	c9                   	leave
 26b:	c3                   	ret
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	56                   	push   %esi
 275:	8b 45 10             	mov    0x10(%ebp),%eax
 278:	8b 55 08             	mov    0x8(%ebp),%edx
 27b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 c0                	test   %eax,%eax
 280:	7e 13                	jle    295 <memmove+0x25>
 282:	01 d0                	add    %edx,%eax
  dst = vdst;
 284:	89 d7                	mov    %edx,%edi
 286:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 290:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 291:	39 f8                	cmp    %edi,%eax
 293:	75 fb                	jne    290 <memmove+0x20>
  return vdst;
}
 295:	5e                   	pop    %esi
 296:	89 d0                	mov    %edx,%eax
 298:	5f                   	pop    %edi
 299:	5d                   	pop    %ebp
 29a:	c3                   	ret

0000029b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29b:	b8 01 00 00 00       	mov    $0x1,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <exit>:
SYSCALL(exit)
 2a3:	b8 02 00 00 00       	mov    $0x2,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <wait>:
SYSCALL(wait)
 2ab:	b8 03 00 00 00       	mov    $0x3,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <pipe>:
SYSCALL(pipe)
 2b3:	b8 04 00 00 00       	mov    $0x4,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <read>:
SYSCALL(read)
 2bb:	b8 05 00 00 00       	mov    $0x5,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <write>:
SYSCALL(write)
 2c3:	b8 10 00 00 00       	mov    $0x10,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <close>:
SYSCALL(close)
 2cb:	b8 15 00 00 00       	mov    $0x15,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <kill>:
SYSCALL(kill)
 2d3:	b8 06 00 00 00       	mov    $0x6,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <exec>:
SYSCALL(exec)
 2db:	b8 07 00 00 00       	mov    $0x7,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <open>:
SYSCALL(open)
 2e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <mknod>:
SYSCALL(mknod)
 2eb:	b8 11 00 00 00       	mov    $0x11,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <unlink>:
SYSCALL(unlink)
 2f3:	b8 12 00 00 00       	mov    $0x12,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <fstat>:
SYSCALL(fstat)
 2fb:	b8 08 00 00 00       	mov    $0x8,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <link>:
SYSCALL(link)
 303:	b8 13 00 00 00       	mov    $0x13,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <mkdir>:
SYSCALL(mkdir)
 30b:	b8 14 00 00 00       	mov    $0x14,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <chdir>:
SYSCALL(chdir)
 313:	b8 09 00 00 00       	mov    $0x9,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <dup>:
SYSCALL(dup)
 31b:	b8 0a 00 00 00       	mov    $0xa,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <getpid>:
SYSCALL(getpid)
 323:	b8 0b 00 00 00       	mov    $0xb,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <sbrk>:
SYSCALL(sbrk)
 32b:	b8 0c 00 00 00       	mov    $0xc,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <sleep>:
SYSCALL(sleep)
 333:	b8 0d 00 00 00       	mov    $0xd,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <uptime>:
SYSCALL(uptime)
 33b:	b8 0e 00 00 00       	mov    $0xe,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <shutdown>:
SYSCALL(shutdown)
 343:	b8 16 00 00 00       	mov    $0x16,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <cps>:
SYSCALL(cps)
 34b:	b8 17 00 00 00       	mov    $0x17,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <chpr>:
SYSCALL(chpr)
 353:	b8 18 00 00 00       	mov    $0x18,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <pstat>:
SYSCALL(pstat)
 35b:	b8 19 00 00 00       	mov    $0x19,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <term>:
SYSCALL(term)
 363:	b8 1a 00 00 00       	mov    $0x1a,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <mask>:
SYSCALL(mask)
 36b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <stop>:
SYSCALL(stop)
 373:	b8 1c 00 00 00       	mov    $0x1c,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <cont>:
SYSCALL(cont)
 37b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret
 383:	66 90                	xchg   %ax,%ax
 385:	66 90                	xchg   %ax,%ax
 387:	66 90                	xchg   %ax,%ax
 389:	66 90                	xchg   %ax,%ax
 38b:	66 90                	xchg   %ax,%ax
 38d:	66 90                	xchg   %ax,%ax
 38f:	90                   	nop

00000390 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 398:	89 d1                	mov    %edx,%ecx
{
 39a:	83 ec 3c             	sub    $0x3c,%esp
 39d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 3a0:	85 d2                	test   %edx,%edx
 3a2:	0f 89 80 00 00 00    	jns    428 <printint+0x98>
 3a8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3ac:	74 7a                	je     428 <printint+0x98>
    x = -xx;
 3ae:	f7 d9                	neg    %ecx
    neg = 1;
 3b0:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 3b5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3b8:	31 f6                	xor    %esi,%esi
 3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3c0:	89 c8                	mov    %ecx,%eax
 3c2:	31 d2                	xor    %edx,%edx
 3c4:	89 f7                	mov    %esi,%edi
 3c6:	f7 f3                	div    %ebx
 3c8:	8d 76 01             	lea    0x1(%esi),%esi
 3cb:	0f b6 92 e0 07 00 00 	movzbl 0x7e0(%edx),%edx
 3d2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 3d6:	89 ca                	mov    %ecx,%edx
 3d8:	89 c1                	mov    %eax,%ecx
 3da:	39 da                	cmp    %ebx,%edx
 3dc:	73 e2                	jae    3c0 <printint+0x30>
  if(neg)
 3de:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3e1:	85 c0                	test   %eax,%eax
 3e3:	74 07                	je     3ec <printint+0x5c>
    buf[i++] = '-';
 3e5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
 3ea:	89 f7                	mov    %esi,%edi
 3ec:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3ef:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3f2:	01 df                	add    %ebx,%edi
 3f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(--i >= 0)
    putc(fd, buf[i]);
 3f8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 3fb:	83 ec 04             	sub    $0x4,%esp
 3fe:	88 45 d7             	mov    %al,-0x29(%ebp)
 401:	8d 45 d7             	lea    -0x29(%ebp),%eax
 404:	6a 01                	push   $0x1
 406:	50                   	push   %eax
 407:	56                   	push   %esi
 408:	e8 b6 fe ff ff       	call   2c3 <write>
  while(--i >= 0)
 40d:	89 f8                	mov    %edi,%eax
 40f:	83 c4 10             	add    $0x10,%esp
 412:	83 ef 01             	sub    $0x1,%edi
 415:	39 d8                	cmp    %ebx,%eax
 417:	75 df                	jne    3f8 <printint+0x68>
}
 419:	8d 65 f4             	lea    -0xc(%ebp),%esp
 41c:	5b                   	pop    %ebx
 41d:	5e                   	pop    %esi
 41e:	5f                   	pop    %edi
 41f:	5d                   	pop    %ebp
 420:	c3                   	ret
 421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 428:	31 c0                	xor    %eax,%eax
 42a:	eb 89                	jmp    3b5 <printint+0x25>
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000430 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 439:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 43c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 43f:	0f b6 1e             	movzbl (%esi),%ebx
 442:	83 c6 01             	add    $0x1,%esi
 445:	84 db                	test   %bl,%bl
 447:	74 67                	je     4b0 <printf+0x80>
 449:	8d 4d 10             	lea    0x10(%ebp),%ecx
 44c:	31 d2                	xor    %edx,%edx
 44e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 451:	eb 34                	jmp    487 <printf+0x57>
 453:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 457:	90                   	nop
 458:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 45b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 460:	83 f8 25             	cmp    $0x25,%eax
 463:	74 18                	je     47d <printf+0x4d>
  write(fd, &c, 1);
 465:	83 ec 04             	sub    $0x4,%esp
 468:	8d 45 e7             	lea    -0x19(%ebp),%eax
 46b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 46e:	6a 01                	push   $0x1
 470:	50                   	push   %eax
 471:	57                   	push   %edi
 472:	e8 4c fe ff ff       	call   2c3 <write>
 477:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 47a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 47d:	0f b6 1e             	movzbl (%esi),%ebx
 480:	83 c6 01             	add    $0x1,%esi
 483:	84 db                	test   %bl,%bl
 485:	74 29                	je     4b0 <printf+0x80>
    c = fmt[i] & 0xff;
 487:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 48a:	85 d2                	test   %edx,%edx
 48c:	74 ca                	je     458 <printf+0x28>
      }
    } else if(state == '%'){
 48e:	83 fa 25             	cmp    $0x25,%edx
 491:	75 ea                	jne    47d <printf+0x4d>
      if(c == 'd'){
 493:	83 f8 25             	cmp    $0x25,%eax
 496:	0f 84 24 01 00 00    	je     5c0 <printf+0x190>
 49c:	83 e8 63             	sub    $0x63,%eax
 49f:	83 f8 15             	cmp    $0x15,%eax
 4a2:	77 1c                	ja     4c0 <printf+0x90>
 4a4:	ff 24 85 88 07 00 00 	jmp    *0x788(,%eax,4)
 4ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4af:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b3:	5b                   	pop    %ebx
 4b4:	5e                   	pop    %esi
 4b5:	5f                   	pop    %edi
 4b6:	5d                   	pop    %ebp
 4b7:	c3                   	ret
 4b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bf:	90                   	nop
  write(fd, &c, 1);
 4c0:	83 ec 04             	sub    $0x4,%esp
 4c3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 4c6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4ca:	6a 01                	push   $0x1
 4cc:	52                   	push   %edx
 4cd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4d0:	57                   	push   %edi
 4d1:	e8 ed fd ff ff       	call   2c3 <write>
 4d6:	83 c4 0c             	add    $0xc,%esp
 4d9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4dc:	6a 01                	push   $0x1
 4de:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4e1:	52                   	push   %edx
 4e2:	57                   	push   %edi
 4e3:	e8 db fd ff ff       	call   2c3 <write>
        putc(fd, c);
 4e8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4eb:	31 d2                	xor    %edx,%edx
 4ed:	eb 8e                	jmp    47d <printf+0x4d>
 4ef:	90                   	nop
        printint(fd, *ap, 16, 0);
 4f0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4f3:	83 ec 0c             	sub    $0xc,%esp
 4f6:	b9 10 00 00 00       	mov    $0x10,%ecx
 4fb:	8b 13                	mov    (%ebx),%edx
 4fd:	6a 00                	push   $0x0
 4ff:	89 f8                	mov    %edi,%eax
        ap++;
 501:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 504:	e8 87 fe ff ff       	call   390 <printint>
        ap++;
 509:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 50c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 50f:	31 d2                	xor    %edx,%edx
 511:	e9 67 ff ff ff       	jmp    47d <printf+0x4d>
 516:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 51d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 520:	8b 45 d0             	mov    -0x30(%ebp),%eax
 523:	8b 18                	mov    (%eax),%ebx
        ap++;
 525:	83 c0 04             	add    $0x4,%eax
 528:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 52b:	85 db                	test   %ebx,%ebx
 52d:	0f 84 9d 00 00 00    	je     5d0 <printf+0x1a0>
        while(*s != 0){
 533:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 536:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 538:	84 c0                	test   %al,%al
 53a:	0f 84 3d ff ff ff    	je     47d <printf+0x4d>
 540:	8d 55 e7             	lea    -0x19(%ebp),%edx
 543:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 546:	89 de                	mov    %ebx,%esi
 548:	89 d3                	mov    %edx,%ebx
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 550:	83 ec 04             	sub    $0x4,%esp
 553:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 556:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 559:	6a 01                	push   $0x1
 55b:	53                   	push   %ebx
 55c:	57                   	push   %edi
 55d:	e8 61 fd ff ff       	call   2c3 <write>
        while(*s != 0){
 562:	0f b6 06             	movzbl (%esi),%eax
 565:	83 c4 10             	add    $0x10,%esp
 568:	84 c0                	test   %al,%al
 56a:	75 e4                	jne    550 <printf+0x120>
      state = 0;
 56c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 56f:	31 d2                	xor    %edx,%edx
 571:	e9 07 ff ff ff       	jmp    47d <printf+0x4d>
 576:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 57d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 580:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 583:	83 ec 0c             	sub    $0xc,%esp
 586:	b9 0a 00 00 00       	mov    $0xa,%ecx
 58b:	8b 13                	mov    (%ebx),%edx
 58d:	6a 01                	push   $0x1
 58f:	e9 6b ff ff ff       	jmp    4ff <printf+0xcf>
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 598:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 59b:	83 ec 04             	sub    $0x4,%esp
 59e:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 5a1:	8b 03                	mov    (%ebx),%eax
        ap++;
 5a3:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 5a6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5a9:	6a 01                	push   $0x1
 5ab:	52                   	push   %edx
 5ac:	57                   	push   %edi
 5ad:	e8 11 fd ff ff       	call   2c3 <write>
        ap++;
 5b2:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5b5:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5b8:	31 d2                	xor    %edx,%edx
 5ba:	e9 be fe ff ff       	jmp    47d <printf+0x4d>
 5bf:	90                   	nop
  write(fd, &c, 1);
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5c6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5c9:	6a 01                	push   $0x1
 5cb:	e9 11 ff ff ff       	jmp    4e1 <printf+0xb1>
 5d0:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 5d5:	bb 7f 07 00 00       	mov    $0x77f,%ebx
 5da:	e9 61 ff ff ff       	jmp    540 <printf+0x110>
 5df:	90                   	nop

000005e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	a1 80 0a 00 00       	mov    0xa80,%eax
{
 5e6:	89 e5                	mov    %esp,%ebp
 5e8:	57                   	push   %edi
 5e9:	56                   	push   %esi
 5ea:	53                   	push   %ebx
 5eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 5ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5f8:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5fa:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5fc:	39 ca                	cmp    %ecx,%edx
 5fe:	73 30                	jae    630 <free+0x50>
 600:	39 c1                	cmp    %eax,%ecx
 602:	72 04                	jb     608 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 604:	39 c2                	cmp    %eax,%edx
 606:	72 f0                	jb     5f8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 608:	8b 73 fc             	mov    -0x4(%ebx),%esi
 60b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 60e:	39 f8                	cmp    %edi,%eax
 610:	74 2e                	je     640 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 612:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 615:	8b 42 04             	mov    0x4(%edx),%eax
 618:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 61b:	39 f1                	cmp    %esi,%ecx
 61d:	74 38                	je     657 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 61f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 621:	5b                   	pop    %ebx
  freep = p;
 622:	89 15 80 0a 00 00    	mov    %edx,0xa80
}
 628:	5e                   	pop    %esi
 629:	5f                   	pop    %edi
 62a:	5d                   	pop    %ebp
 62b:	c3                   	ret
 62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 630:	39 c1                	cmp    %eax,%ecx
 632:	72 d0                	jb     604 <free+0x24>
 634:	eb c2                	jmp    5f8 <free+0x18>
 636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63d:	8d 76 00             	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 640:	03 70 04             	add    0x4(%eax),%esi
 643:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 646:	8b 02                	mov    (%edx),%eax
 648:	8b 00                	mov    (%eax),%eax
 64a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 64d:	8b 42 04             	mov    0x4(%edx),%eax
 650:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 653:	39 f1                	cmp    %esi,%ecx
 655:	75 c8                	jne    61f <free+0x3f>
    p->s.size += bp->s.size;
 657:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 65a:	89 15 80 0a 00 00    	mov    %edx,0xa80
    p->s.size += bp->s.size;
 660:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 663:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 666:	89 0a                	mov    %ecx,(%edx)
}
 668:	5b                   	pop    %ebx
 669:	5e                   	pop    %esi
 66a:	5f                   	pop    %edi
 66b:	5d                   	pop    %ebp
 66c:	c3                   	ret
 66d:	8d 76 00             	lea    0x0(%esi),%esi

00000670 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
 676:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 679:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 67c:	8b 15 80 0a 00 00    	mov    0xa80,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 682:	8d 78 07             	lea    0x7(%eax),%edi
 685:	c1 ef 03             	shr    $0x3,%edi
 688:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 68b:	85 d2                	test   %edx,%edx
 68d:	0f 84 8d 00 00 00    	je     720 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 693:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 695:	8b 48 04             	mov    0x4(%eax),%ecx
 698:	39 f9                	cmp    %edi,%ecx
 69a:	73 64                	jae    700 <malloc+0x90>
  if(nu < 4096)
 69c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6a1:	39 df                	cmp    %ebx,%edi
 6a3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6a6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6ad:	eb 0a                	jmp    6b9 <malloc+0x49>
 6af:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6b2:	8b 48 04             	mov    0x4(%eax),%ecx
 6b5:	39 f9                	cmp    %edi,%ecx
 6b7:	73 47                	jae    700 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6b9:	89 c2                	mov    %eax,%edx
 6bb:	39 05 80 0a 00 00    	cmp    %eax,0xa80
 6c1:	75 ed                	jne    6b0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 6c3:	83 ec 0c             	sub    $0xc,%esp
 6c6:	56                   	push   %esi
 6c7:	e8 5f fc ff ff       	call   32b <sbrk>
  if(p == (char*)-1)
 6cc:	83 c4 10             	add    $0x10,%esp
 6cf:	83 f8 ff             	cmp    $0xffffffff,%eax
 6d2:	74 1c                	je     6f0 <malloc+0x80>
  hp->s.size = nu;
 6d4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6d7:	83 ec 0c             	sub    $0xc,%esp
 6da:	83 c0 08             	add    $0x8,%eax
 6dd:	50                   	push   %eax
 6de:	e8 fd fe ff ff       	call   5e0 <free>
  return freep;
 6e3:	8b 15 80 0a 00 00    	mov    0xa80,%edx
      if((p = morecore(nunits)) == 0)
 6e9:	83 c4 10             	add    $0x10,%esp
 6ec:	85 d2                	test   %edx,%edx
 6ee:	75 c0                	jne    6b0 <malloc+0x40>
        return 0;
  }
}
 6f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 6f3:	31 c0                	xor    %eax,%eax
}
 6f5:	5b                   	pop    %ebx
 6f6:	5e                   	pop    %esi
 6f7:	5f                   	pop    %edi
 6f8:	5d                   	pop    %ebp
 6f9:	c3                   	ret
 6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 700:	39 cf                	cmp    %ecx,%edi
 702:	74 4c                	je     750 <malloc+0xe0>
        p->s.size -= nunits;
 704:	29 f9                	sub    %edi,%ecx
 706:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 709:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 70c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 70f:	89 15 80 0a 00 00    	mov    %edx,0xa80
}
 715:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 718:	83 c0 08             	add    $0x8,%eax
}
 71b:	5b                   	pop    %ebx
 71c:	5e                   	pop    %esi
 71d:	5f                   	pop    %edi
 71e:	5d                   	pop    %ebp
 71f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 720:	c7 05 80 0a 00 00 84 	movl   $0xa84,0xa80
 727:	0a 00 00 
    base.s.size = 0;
 72a:	b8 84 0a 00 00       	mov    $0xa84,%eax
    base.s.ptr = freep = prevp = &base;
 72f:	c7 05 84 0a 00 00 84 	movl   $0xa84,0xa84
 736:	0a 00 00 
    base.s.size = 0;
 739:	c7 05 88 0a 00 00 00 	movl   $0x0,0xa88
 740:	00 00 00 
    if(p->s.size >= nunits){
 743:	e9 54 ff ff ff       	jmp    69c <malloc+0x2c>
 748:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 74f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 750:	8b 08                	mov    (%eax),%ecx
 752:	89 0a                	mov    %ecx,(%edx)
 754:	eb b9                	jmp    70f <malloc+0x9f>
