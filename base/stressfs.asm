
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
  int fd, i;
  char path[] = "stressfs0";
   7:	b8 30 00 00 00       	mov    $0x30,%eax
{
   c:	ff 71 fc             	push   -0x4(%ecx)
   f:	55                   	push   %ebp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %edi
  13:	56                   	push   %esi
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));
  14:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
{
  1a:	53                   	push   %ebx

  for(i = 0; i < 4; i++)
  1b:	31 db                	xor    %ebx,%ebx
{
  1d:	51                   	push   %ecx
  1e:	81 ec 20 02 00 00    	sub    $0x220,%esp
  char path[] = "stressfs0";
  24:	66 89 85 e6 fd ff ff 	mov    %ax,-0x21a(%ebp)
  2b:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
  32:	74 72 65 
  35:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
  3c:	73 66 73 
  printf(1, "stressfs starting\n");
  3f:	68 18 08 00 00       	push   $0x818
  44:	6a 01                	push   $0x1
  46:	e8 a5 04 00 00       	call   4f0 <printf>
  memset(data, 'a', sizeof(data));
  4b:	83 c4 0c             	add    $0xc,%esp
  4e:	68 00 02 00 00       	push   $0x200
  53:	6a 61                	push   $0x61
  55:	56                   	push   %esi
  56:	e8 85 01 00 00       	call   1e0 <memset>
  5b:	83 c4 10             	add    $0x10,%esp
    if(fork() > 0)
  5e:	e8 f8 02 00 00       	call   35b <fork>
  63:	85 c0                	test   %eax,%eax
  65:	7f 08                	jg     6f <main+0x6f>
  for(i = 0; i < 4; i++)
  67:	83 c3 01             	add    $0x1,%ebx
  6a:	83 fb 04             	cmp    $0x4,%ebx
  6d:	75 ef                	jne    5e <main+0x5e>
      break;

  printf(1, "write %d\n", i);
  6f:	83 ec 04             	sub    $0x4,%esp
  72:	53                   	push   %ebx
  73:	68 2b 08 00 00       	push   $0x82b
  78:	6a 01                	push   $0x1
  7a:	e8 71 04 00 00       	call   4f0 <printf>

  path[8] += i;
  7f:	00 9d e6 fd ff ff    	add    %bl,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  85:	5f                   	pop    %edi
  86:	bb 14 00 00 00       	mov    $0x14,%ebx
  8b:	58                   	pop    %eax
  8c:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  92:	68 02 02 00 00       	push   $0x202
  97:	50                   	push   %eax
  98:	e8 06 03 00 00       	call   3a3 <open>
  9d:	83 c4 10             	add    $0x10,%esp
  a0:	89 c7                	mov    %eax,%edi
  for(i = 0; i < 20; i++)
  a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  a8:	83 ec 04             	sub    $0x4,%esp
  ab:	68 00 02 00 00       	push   $0x200
  b0:	56                   	push   %esi
  b1:	57                   	push   %edi
  b2:	e8 cc 02 00 00       	call   383 <write>
  for(i = 0; i < 20; i++)
  b7:	83 c4 10             	add    $0x10,%esp
  ba:	83 eb 01             	sub    $0x1,%ebx
  bd:	75 e9                	jne    a8 <main+0xa8>
  close(fd);
  bf:	83 ec 0c             	sub    $0xc,%esp
  c2:	57                   	push   %edi
  c3:	e8 c3 02 00 00       	call   38b <close>

  printf(1, "read\n");
  c8:	58                   	pop    %eax
  c9:	5a                   	pop    %edx
  ca:	68 35 08 00 00       	push   $0x835
  cf:	6a 01                	push   $0x1
  d1:	e8 1a 04 00 00       	call   4f0 <printf>

  fd = open(path, O_RDONLY);
  d6:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  dc:	59                   	pop    %ecx
  dd:	5b                   	pop    %ebx
  de:	6a 00                	push   $0x0
  e0:	bb 14 00 00 00       	mov    $0x14,%ebx
  e5:	50                   	push   %eax
  e6:	e8 b8 02 00 00       	call   3a3 <open>
  eb:	83 c4 10             	add    $0x10,%esp
  ee:	89 c7                	mov    %eax,%edi
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  f0:	83 ec 04             	sub    $0x4,%esp
  f3:	68 00 02 00 00       	push   $0x200
  f8:	56                   	push   %esi
  f9:	57                   	push   %edi
  fa:	e8 7c 02 00 00       	call   37b <read>
  for (i = 0; i < 20; i++)
  ff:	83 c4 10             	add    $0x10,%esp
 102:	83 eb 01             	sub    $0x1,%ebx
 105:	75 e9                	jne    f0 <main+0xf0>
  close(fd);
 107:	83 ec 0c             	sub    $0xc,%esp
 10a:	57                   	push   %edi
 10b:	e8 7b 02 00 00       	call   38b <close>

  wait();
 110:	e8 56 02 00 00       	call   36b <wait>

  exit();
 115:	e8 49 02 00 00       	call   363 <exit>
 11a:	66 90                	xchg   %ax,%ax
 11c:	66 90                	xchg   %ax,%ax
 11e:	66 90                	xchg   %ax,%ax

00000120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 120:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 121:	31 c0                	xor    %eax,%eax
{
 123:	89 e5                	mov    %esp,%ebp
 125:	53                   	push   %ebx
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 130:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 134:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 137:	83 c0 01             	add    $0x1,%eax
 13a:	84 d2                	test   %dl,%dl
 13c:	75 f2                	jne    130 <strcpy+0x10>
    ;
  return os;
}
 13e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 141:	89 c8                	mov    %ecx,%eax
 143:	c9                   	leave
 144:	c3                   	ret
 145:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 55 08             	mov    0x8(%ebp),%edx
 157:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 15a:	0f b6 02             	movzbl (%edx),%eax
 15d:	84 c0                	test   %al,%al
 15f:	75 17                	jne    178 <strcmp+0x28>
 161:	eb 3a                	jmp    19d <strcmp+0x4d>
 163:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 167:	90                   	nop
 168:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 16c:	83 c2 01             	add    $0x1,%edx
 16f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 172:	84 c0                	test   %al,%al
 174:	74 1a                	je     190 <strcmp+0x40>
    p++, q++;
 176:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 178:	0f b6 19             	movzbl (%ecx),%ebx
 17b:	38 c3                	cmp    %al,%bl
 17d:	74 e9                	je     168 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 17f:	29 d8                	sub    %ebx,%eax
}
 181:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 184:	c9                   	leave
 185:	c3                   	ret
 186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 190:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 194:	31 c0                	xor    %eax,%eax
 196:	29 d8                	sub    %ebx,%eax
}
 198:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 19b:	c9                   	leave
 19c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 19d:	0f b6 19             	movzbl (%ecx),%ebx
 1a0:	31 c0                	xor    %eax,%eax
 1a2:	eb db                	jmp    17f <strcmp+0x2f>
 1a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1af:	90                   	nop

000001b0 <strlen>:

uint
strlen(char *s)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1b6:	80 3a 00             	cmpb   $0x0,(%edx)
 1b9:	74 15                	je     1d0 <strlen+0x20>
 1bb:	31 c0                	xor    %eax,%eax
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	83 c0 01             	add    $0x1,%eax
 1c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1c7:	89 c1                	mov    %eax,%ecx
 1c9:	75 f5                	jne    1c0 <strlen+0x10>
    ;
  return n;
}
 1cb:	89 c8                	mov    %ecx,%eax
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret
 1cf:	90                   	nop
  for(n = 0; s[n]; n++)
 1d0:	31 c9                	xor    %ecx,%ecx
}
 1d2:	5d                   	pop    %ebp
 1d3:	89 c8                	mov    %ecx,%eax
 1d5:	c3                   	ret
 1d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1dd:	8d 76 00             	lea    0x0(%esi),%esi

000001e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
 1e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 d7                	mov    %edx,%edi
 1ef:	fc                   	cld
 1f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1f2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1f5:	89 d0                	mov    %edx,%eax
 1f7:	c9                   	leave
 1f8:	c3                   	ret
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 20a:	0f b6 10             	movzbl (%eax),%edx
 20d:	84 d2                	test   %dl,%dl
 20f:	75 12                	jne    223 <strchr+0x23>
 211:	eb 1d                	jmp    230 <strchr+0x30>
 213:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 217:	90                   	nop
 218:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 21c:	83 c0 01             	add    $0x1,%eax
 21f:	84 d2                	test   %dl,%dl
 221:	74 0d                	je     230 <strchr+0x30>
    if(*s == c)
 223:	38 d1                	cmp    %dl,%cl
 225:	75 f1                	jne    218 <strchr+0x18>
      return (char*)s;
  return 0;
}
 227:	5d                   	pop    %ebp
 228:	c3                   	ret
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 230:	31 c0                	xor    %eax,%eax
}
 232:	5d                   	pop    %ebp
 233:	c3                   	ret
 234:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 23f:	90                   	nop

00000240 <gets>:

char*
gets(char *buf, int max)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 245:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 248:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 249:	31 db                	xor    %ebx,%ebx
{
 24b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 24e:	eb 27                	jmp    277 <gets+0x37>
    cc = read(0, &c, 1);
 250:	83 ec 04             	sub    $0x4,%esp
 253:	6a 01                	push   $0x1
 255:	56                   	push   %esi
 256:	6a 00                	push   $0x0
 258:	e8 1e 01 00 00       	call   37b <read>
    if(cc < 1)
 25d:	83 c4 10             	add    $0x10,%esp
 260:	85 c0                	test   %eax,%eax
 262:	7e 1d                	jle    281 <gets+0x41>
      break;
    buf[i++] = c;
 264:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 268:	8b 55 08             	mov    0x8(%ebp),%edx
 26b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 26f:	3c 0a                	cmp    $0xa,%al
 271:	74 10                	je     283 <gets+0x43>
 273:	3c 0d                	cmp    $0xd,%al
 275:	74 0c                	je     283 <gets+0x43>
  for(i=0; i+1 < max; ){
 277:	89 df                	mov    %ebx,%edi
 279:	83 c3 01             	add    $0x1,%ebx
 27c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 27f:	7c cf                	jl     250 <gets+0x10>
 281:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 28a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 28d:	5b                   	pop    %ebx
 28e:	5e                   	pop    %esi
 28f:	5f                   	pop    %edi
 290:	5d                   	pop    %ebp
 291:	c3                   	ret
 292:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <stat>:

int
stat(char *n, struct stat *st)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a5:	83 ec 08             	sub    $0x8,%esp
 2a8:	6a 00                	push   $0x0
 2aa:	ff 75 08             	push   0x8(%ebp)
 2ad:	e8 f1 00 00 00       	call   3a3 <open>
  if(fd < 0)
 2b2:	83 c4 10             	add    $0x10,%esp
 2b5:	85 c0                	test   %eax,%eax
 2b7:	78 27                	js     2e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2b9:	83 ec 08             	sub    $0x8,%esp
 2bc:	ff 75 0c             	push   0xc(%ebp)
 2bf:	89 c3                	mov    %eax,%ebx
 2c1:	50                   	push   %eax
 2c2:	e8 f4 00 00 00       	call   3bb <fstat>
  close(fd);
 2c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ca:	89 c6                	mov    %eax,%esi
  close(fd);
 2cc:	e8 ba 00 00 00       	call   38b <close>
  return r;
 2d1:	83 c4 10             	add    $0x10,%esp
}
 2d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2d7:	89 f0                	mov    %esi,%eax
 2d9:	5b                   	pop    %ebx
 2da:	5e                   	pop    %esi
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2e5:	eb ed                	jmp    2d4 <stat+0x34>
 2e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ee:	66 90                	xchg   %ax,%ax

000002f0 <atoi>:

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f7:	0f be 02             	movsbl (%edx),%eax
 2fa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2fd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 300:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 305:	77 1e                	ja     325 <atoi+0x35>
 307:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 310:	83 c2 01             	add    $0x1,%edx
 313:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 316:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 31a:	0f be 02             	movsbl (%edx),%eax
 31d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 320:	80 fb 09             	cmp    $0x9,%bl
 323:	76 eb                	jbe    310 <atoi+0x20>
  return n;
}
 325:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 328:	89 c8                	mov    %ecx,%eax
 32a:	c9                   	leave
 32b:	c3                   	ret
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000330 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	8b 45 10             	mov    0x10(%ebp),%eax
 338:	8b 55 08             	mov    0x8(%ebp),%edx
 33b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33e:	85 c0                	test   %eax,%eax
 340:	7e 13                	jle    355 <memmove+0x25>
 342:	01 d0                	add    %edx,%eax
  dst = vdst;
 344:	89 d7                	mov    %edx,%edi
 346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 34d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 350:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 351:	39 f8                	cmp    %edi,%eax
 353:	75 fb                	jne    350 <memmove+0x20>
  return vdst;
}
 355:	5e                   	pop    %esi
 356:	89 d0                	mov    %edx,%eax
 358:	5f                   	pop    %edi
 359:	5d                   	pop    %ebp
 35a:	c3                   	ret

0000035b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35b:	b8 01 00 00 00       	mov    $0x1,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <exit>:
SYSCALL(exit)
 363:	b8 02 00 00 00       	mov    $0x2,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <wait>:
SYSCALL(wait)
 36b:	b8 03 00 00 00       	mov    $0x3,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <pipe>:
SYSCALL(pipe)
 373:	b8 04 00 00 00       	mov    $0x4,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <read>:
SYSCALL(read)
 37b:	b8 05 00 00 00       	mov    $0x5,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <write>:
SYSCALL(write)
 383:	b8 10 00 00 00       	mov    $0x10,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <close>:
SYSCALL(close)
 38b:	b8 15 00 00 00       	mov    $0x15,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <kill>:
SYSCALL(kill)
 393:	b8 06 00 00 00       	mov    $0x6,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <exec>:
SYSCALL(exec)
 39b:	b8 07 00 00 00       	mov    $0x7,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <open>:
SYSCALL(open)
 3a3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <mknod>:
SYSCALL(mknod)
 3ab:	b8 11 00 00 00       	mov    $0x11,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <unlink>:
SYSCALL(unlink)
 3b3:	b8 12 00 00 00       	mov    $0x12,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <fstat>:
SYSCALL(fstat)
 3bb:	b8 08 00 00 00       	mov    $0x8,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <link>:
SYSCALL(link)
 3c3:	b8 13 00 00 00       	mov    $0x13,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <mkdir>:
SYSCALL(mkdir)
 3cb:	b8 14 00 00 00       	mov    $0x14,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <chdir>:
SYSCALL(chdir)
 3d3:	b8 09 00 00 00       	mov    $0x9,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <dup>:
SYSCALL(dup)
 3db:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <getpid>:
SYSCALL(getpid)
 3e3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <sbrk>:
SYSCALL(sbrk)
 3eb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <sleep>:
SYSCALL(sleep)
 3f3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <uptime>:
SYSCALL(uptime)
 3fb:	b8 0e 00 00 00       	mov    $0xe,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <shutdown>:
SYSCALL(shutdown)
 403:	b8 16 00 00 00       	mov    $0x16,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <cps>:
SYSCALL(cps)
 40b:	b8 17 00 00 00       	mov    $0x17,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <chpr>:
SYSCALL(chpr)
 413:	b8 18 00 00 00       	mov    $0x18,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <pstat>:
SYSCALL(pstat)
 41b:	b8 19 00 00 00       	mov    $0x19,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <term>:
SYSCALL(term)
 423:	b8 1a 00 00 00       	mov    $0x1a,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <mask>:
SYSCALL(mask)
 42b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <stop>:
SYSCALL(stop)
 433:	b8 1c 00 00 00       	mov    $0x1c,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <cont>:
SYSCALL(cont)
 43b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret
 443:	66 90                	xchg   %ax,%ax
 445:	66 90                	xchg   %ax,%ax
 447:	66 90                	xchg   %ax,%ax
 449:	66 90                	xchg   %ax,%ax
 44b:	66 90                	xchg   %ax,%ax
 44d:	66 90                	xchg   %ax,%ax
 44f:	90                   	nop

00000450 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 458:	89 d1                	mov    %edx,%ecx
{
 45a:	83 ec 3c             	sub    $0x3c,%esp
 45d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 460:	85 d2                	test   %edx,%edx
 462:	0f 89 80 00 00 00    	jns    4e8 <printint+0x98>
 468:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 46c:	74 7a                	je     4e8 <printint+0x98>
    x = -xx;
 46e:	f7 d9                	neg    %ecx
    neg = 1;
 470:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 475:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 478:	31 f6                	xor    %esi,%esi
 47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 480:	89 c8                	mov    %ecx,%eax
 482:	31 d2                	xor    %edx,%edx
 484:	89 f7                	mov    %esi,%edi
 486:	f7 f3                	div    %ebx
 488:	8d 76 01             	lea    0x1(%esi),%esi
 48b:	0f b6 92 9c 08 00 00 	movzbl 0x89c(%edx),%edx
 492:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 496:	89 ca                	mov    %ecx,%edx
 498:	89 c1                	mov    %eax,%ecx
 49a:	39 da                	cmp    %ebx,%edx
 49c:	73 e2                	jae    480 <printint+0x30>
  if(neg)
 49e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4a1:	85 c0                	test   %eax,%eax
 4a3:	74 07                	je     4ac <printint+0x5c>
    buf[i++] = '-';
 4a5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
 4aa:	89 f7                	mov    %esi,%edi
 4ac:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4af:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4b2:	01 df                	add    %ebx,%edi
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(--i >= 0)
    putc(fd, buf[i]);
 4b8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4bb:	83 ec 04             	sub    $0x4,%esp
 4be:	88 45 d7             	mov    %al,-0x29(%ebp)
 4c1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 4c4:	6a 01                	push   $0x1
 4c6:	50                   	push   %eax
 4c7:	56                   	push   %esi
 4c8:	e8 b6 fe ff ff       	call   383 <write>
  while(--i >= 0)
 4cd:	89 f8                	mov    %edi,%eax
 4cf:	83 c4 10             	add    $0x10,%esp
 4d2:	83 ef 01             	sub    $0x1,%edi
 4d5:	39 d8                	cmp    %ebx,%eax
 4d7:	75 df                	jne    4b8 <printint+0x68>
}
 4d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4dc:	5b                   	pop    %ebx
 4dd:	5e                   	pop    %esi
 4de:	5f                   	pop    %edi
 4df:	5d                   	pop    %ebp
 4e0:	c3                   	ret
 4e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4e8:	31 c0                	xor    %eax,%eax
 4ea:	eb 89                	jmp    475 <printint+0x25>
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
 4f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 4fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 4ff:	0f b6 1e             	movzbl (%esi),%ebx
 502:	83 c6 01             	add    $0x1,%esi
 505:	84 db                	test   %bl,%bl
 507:	74 67                	je     570 <printf+0x80>
 509:	8d 4d 10             	lea    0x10(%ebp),%ecx
 50c:	31 d2                	xor    %edx,%edx
 50e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 511:	eb 34                	jmp    547 <printf+0x57>
 513:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 517:	90                   	nop
 518:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 51b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 520:	83 f8 25             	cmp    $0x25,%eax
 523:	74 18                	je     53d <printf+0x4d>
  write(fd, &c, 1);
 525:	83 ec 04             	sub    $0x4,%esp
 528:	8d 45 e7             	lea    -0x19(%ebp),%eax
 52b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 52e:	6a 01                	push   $0x1
 530:	50                   	push   %eax
 531:	57                   	push   %edi
 532:	e8 4c fe ff ff       	call   383 <write>
 537:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 53a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 53d:	0f b6 1e             	movzbl (%esi),%ebx
 540:	83 c6 01             	add    $0x1,%esi
 543:	84 db                	test   %bl,%bl
 545:	74 29                	je     570 <printf+0x80>
    c = fmt[i] & 0xff;
 547:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 54a:	85 d2                	test   %edx,%edx
 54c:	74 ca                	je     518 <printf+0x28>
      }
    } else if(state == '%'){
 54e:	83 fa 25             	cmp    $0x25,%edx
 551:	75 ea                	jne    53d <printf+0x4d>
      if(c == 'd'){
 553:	83 f8 25             	cmp    $0x25,%eax
 556:	0f 84 24 01 00 00    	je     680 <printf+0x190>
 55c:	83 e8 63             	sub    $0x63,%eax
 55f:	83 f8 15             	cmp    $0x15,%eax
 562:	77 1c                	ja     580 <printf+0x90>
 564:	ff 24 85 44 08 00 00 	jmp    *0x844(,%eax,4)
 56b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 56f:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 570:	8d 65 f4             	lea    -0xc(%ebp),%esp
 573:	5b                   	pop    %ebx
 574:	5e                   	pop    %esi
 575:	5f                   	pop    %edi
 576:	5d                   	pop    %ebp
 577:	c3                   	ret
 578:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 57f:	90                   	nop
  write(fd, &c, 1);
 580:	83 ec 04             	sub    $0x4,%esp
 583:	8d 55 e7             	lea    -0x19(%ebp),%edx
 586:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 58a:	6a 01                	push   $0x1
 58c:	52                   	push   %edx
 58d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 590:	57                   	push   %edi
 591:	e8 ed fd ff ff       	call   383 <write>
 596:	83 c4 0c             	add    $0xc,%esp
 599:	88 5d e7             	mov    %bl,-0x19(%ebp)
 59c:	6a 01                	push   $0x1
 59e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5a1:	52                   	push   %edx
 5a2:	57                   	push   %edi
 5a3:	e8 db fd ff ff       	call   383 <write>
        putc(fd, c);
 5a8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ab:	31 d2                	xor    %edx,%edx
 5ad:	eb 8e                	jmp    53d <printf+0x4d>
 5af:	90                   	nop
        printint(fd, *ap, 16, 0);
 5b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5b3:	83 ec 0c             	sub    $0xc,%esp
 5b6:	b9 10 00 00 00       	mov    $0x10,%ecx
 5bb:	8b 13                	mov    (%ebx),%edx
 5bd:	6a 00                	push   $0x0
 5bf:	89 f8                	mov    %edi,%eax
        ap++;
 5c1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 5c4:	e8 87 fe ff ff       	call   450 <printint>
        ap++;
 5c9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5cc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5cf:	31 d2                	xor    %edx,%edx
 5d1:	e9 67 ff ff ff       	jmp    53d <printf+0x4d>
 5d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 5e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5e3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5e5:	83 c0 04             	add    $0x4,%eax
 5e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5eb:	85 db                	test   %ebx,%ebx
 5ed:	0f 84 9d 00 00 00    	je     690 <printf+0x1a0>
        while(*s != 0){
 5f3:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5f6:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5f8:	84 c0                	test   %al,%al
 5fa:	0f 84 3d ff ff ff    	je     53d <printf+0x4d>
 600:	8d 55 e7             	lea    -0x19(%ebp),%edx
 603:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 606:	89 de                	mov    %ebx,%esi
 608:	89 d3                	mov    %edx,%ebx
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 610:	83 ec 04             	sub    $0x4,%esp
 613:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 616:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 619:	6a 01                	push   $0x1
 61b:	53                   	push   %ebx
 61c:	57                   	push   %edi
 61d:	e8 61 fd ff ff       	call   383 <write>
        while(*s != 0){
 622:	0f b6 06             	movzbl (%esi),%eax
 625:	83 c4 10             	add    $0x10,%esp
 628:	84 c0                	test   %al,%al
 62a:	75 e4                	jne    610 <printf+0x120>
      state = 0;
 62c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 62f:	31 d2                	xor    %edx,%edx
 631:	e9 07 ff ff ff       	jmp    53d <printf+0x4d>
 636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 640:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 643:	83 ec 0c             	sub    $0xc,%esp
 646:	b9 0a 00 00 00       	mov    $0xa,%ecx
 64b:	8b 13                	mov    (%ebx),%edx
 64d:	6a 01                	push   $0x1
 64f:	e9 6b ff ff ff       	jmp    5bf <printf+0xcf>
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 658:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 65b:	83 ec 04             	sub    $0x4,%esp
 65e:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 661:	8b 03                	mov    (%ebx),%eax
        ap++;
 663:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 666:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 669:	6a 01                	push   $0x1
 66b:	52                   	push   %edx
 66c:	57                   	push   %edi
 66d:	e8 11 fd ff ff       	call   383 <write>
        ap++;
 672:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 675:	83 c4 10             	add    $0x10,%esp
      state = 0;
 678:	31 d2                	xor    %edx,%edx
 67a:	e9 be fe ff ff       	jmp    53d <printf+0x4d>
 67f:	90                   	nop
  write(fd, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
 683:	88 5d e7             	mov    %bl,-0x19(%ebp)
 686:	8d 55 e7             	lea    -0x19(%ebp),%edx
 689:	6a 01                	push   $0x1
 68b:	e9 11 ff ff ff       	jmp    5a1 <printf+0xb1>
 690:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 695:	bb 3b 08 00 00       	mov    $0x83b,%ebx
 69a:	e9 61 ff ff ff       	jmp    600 <printf+0x110>
 69f:	90                   	nop

000006a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	a1 48 0b 00 00       	mov    0xb48,%eax
{
 6a6:	89 e5                	mov    %esp,%ebp
 6a8:	57                   	push   %edi
 6a9:	56                   	push   %esi
 6aa:	53                   	push   %ebx
 6ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6b8:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ba:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6bc:	39 ca                	cmp    %ecx,%edx
 6be:	73 30                	jae    6f0 <free+0x50>
 6c0:	39 c1                	cmp    %eax,%ecx
 6c2:	72 04                	jb     6c8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c4:	39 c2                	cmp    %eax,%edx
 6c6:	72 f0                	jb     6b8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ce:	39 f8                	cmp    %edi,%eax
 6d0:	74 2e                	je     700 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6d2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6d5:	8b 42 04             	mov    0x4(%edx),%eax
 6d8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6db:	39 f1                	cmp    %esi,%ecx
 6dd:	74 38                	je     717 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6df:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6e1:	5b                   	pop    %ebx
  freep = p;
 6e2:	89 15 48 0b 00 00    	mov    %edx,0xb48
}
 6e8:	5e                   	pop    %esi
 6e9:	5f                   	pop    %edi
 6ea:	5d                   	pop    %ebp
 6eb:	c3                   	ret
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f0:	39 c1                	cmp    %eax,%ecx
 6f2:	72 d0                	jb     6c4 <free+0x24>
 6f4:	eb c2                	jmp    6b8 <free+0x18>
 6f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 700:	03 70 04             	add    0x4(%eax),%esi
 703:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 706:	8b 02                	mov    (%edx),%eax
 708:	8b 00                	mov    (%eax),%eax
 70a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 70d:	8b 42 04             	mov    0x4(%edx),%eax
 710:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 713:	39 f1                	cmp    %esi,%ecx
 715:	75 c8                	jne    6df <free+0x3f>
    p->s.size += bp->s.size;
 717:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 71a:	89 15 48 0b 00 00    	mov    %edx,0xb48
    p->s.size += bp->s.size;
 720:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 723:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 726:	89 0a                	mov    %ecx,(%edx)
}
 728:	5b                   	pop    %ebx
 729:	5e                   	pop    %esi
 72a:	5f                   	pop    %edi
 72b:	5d                   	pop    %ebp
 72c:	c3                   	ret
 72d:	8d 76 00             	lea    0x0(%esi),%esi

00000730 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	56                   	push   %esi
 735:	53                   	push   %ebx
 736:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 739:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 73c:	8b 15 48 0b 00 00    	mov    0xb48,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 742:	8d 78 07             	lea    0x7(%eax),%edi
 745:	c1 ef 03             	shr    $0x3,%edi
 748:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 74b:	85 d2                	test   %edx,%edx
 74d:	0f 84 8d 00 00 00    	je     7e0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 753:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 755:	8b 48 04             	mov    0x4(%eax),%ecx
 758:	39 f9                	cmp    %edi,%ecx
 75a:	73 64                	jae    7c0 <malloc+0x90>
  if(nu < 4096)
 75c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 761:	39 df                	cmp    %ebx,%edi
 763:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 766:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 76d:	eb 0a                	jmp    779 <malloc+0x49>
 76f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 770:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 772:	8b 48 04             	mov    0x4(%eax),%ecx
 775:	39 f9                	cmp    %edi,%ecx
 777:	73 47                	jae    7c0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 779:	89 c2                	mov    %eax,%edx
 77b:	39 05 48 0b 00 00    	cmp    %eax,0xb48
 781:	75 ed                	jne    770 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 783:	83 ec 0c             	sub    $0xc,%esp
 786:	56                   	push   %esi
 787:	e8 5f fc ff ff       	call   3eb <sbrk>
  if(p == (char*)-1)
 78c:	83 c4 10             	add    $0x10,%esp
 78f:	83 f8 ff             	cmp    $0xffffffff,%eax
 792:	74 1c                	je     7b0 <malloc+0x80>
  hp->s.size = nu;
 794:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 797:	83 ec 0c             	sub    $0xc,%esp
 79a:	83 c0 08             	add    $0x8,%eax
 79d:	50                   	push   %eax
 79e:	e8 fd fe ff ff       	call   6a0 <free>
  return freep;
 7a3:	8b 15 48 0b 00 00    	mov    0xb48,%edx
      if((p = morecore(nunits)) == 0)
 7a9:	83 c4 10             	add    $0x10,%esp
 7ac:	85 d2                	test   %edx,%edx
 7ae:	75 c0                	jne    770 <malloc+0x40>
        return 0;
  }
}
 7b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7b3:	31 c0                	xor    %eax,%eax
}
 7b5:	5b                   	pop    %ebx
 7b6:	5e                   	pop    %esi
 7b7:	5f                   	pop    %edi
 7b8:	5d                   	pop    %ebp
 7b9:	c3                   	ret
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7c0:	39 cf                	cmp    %ecx,%edi
 7c2:	74 4c                	je     810 <malloc+0xe0>
        p->s.size -= nunits;
 7c4:	29 f9                	sub    %edi,%ecx
 7c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7cc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7cf:	89 15 48 0b 00 00    	mov    %edx,0xb48
}
 7d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7d8:	83 c0 08             	add    $0x8,%eax
}
 7db:	5b                   	pop    %ebx
 7dc:	5e                   	pop    %esi
 7dd:	5f                   	pop    %edi
 7de:	5d                   	pop    %ebp
 7df:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 7e0:	c7 05 48 0b 00 00 4c 	movl   $0xb4c,0xb48
 7e7:	0b 00 00 
    base.s.size = 0;
 7ea:	b8 4c 0b 00 00       	mov    $0xb4c,%eax
    base.s.ptr = freep = prevp = &base;
 7ef:	c7 05 4c 0b 00 00 4c 	movl   $0xb4c,0xb4c
 7f6:	0b 00 00 
    base.s.size = 0;
 7f9:	c7 05 50 0b 00 00 00 	movl   $0x0,0xb50
 800:	00 00 00 
    if(p->s.size >= nunits){
 803:	e9 54 ff ff ff       	jmp    75c <malloc+0x2c>
 808:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 80f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 810:	8b 08                	mov    (%eax),%ecx
 812:	89 0a                	mov    %ecx,(%edx)
 814:	eb b9                	jmp    7cf <malloc+0x9f>
