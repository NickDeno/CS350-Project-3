
_signal_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  test_10();
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
  sig_test();
       6:	e8 55 10 00 00       	call   1060 <sig_test>
  exit();
       b:	e8 d3 12 00 00       	call   12e3 <exit>

00000010 <interrupt>:
int interrupt(int pid){}
      10:	c3                   	ret
      11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      1f:	90                   	nop

00000020 <printstat>:
printstat(int stat, int pid, int expected){
      20:	55                   	push   %ebp
      21:	b8 98 17 00 00       	mov    $0x1798,%eax
      26:	89 e5                	mov    %esp,%ebp
      28:	56                   	push   %esi
      29:	53                   	push   %ebx
      2a:	8b 5d 08             	mov    0x8(%ebp),%ebx
      2d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
      30:	8b 75 10             	mov    0x10(%ebp),%esi
      33:	8d 53 ff             	lea    -0x1(%ebx),%edx
      36:	83 fa 04             	cmp    $0x4,%edx
      39:	77 07                	ja     42 <printstat+0x22>
      3b:	8b 04 95 14 1b 00 00 	mov    0x1b14(,%edx,4),%eax
  printf(1, "PID %d is in state %s\n", pid, statstring);
      42:	50                   	push   %eax
      43:	51                   	push   %ecx
      44:	68 7c 1a 00 00       	push   $0x1a7c
      49:	6a 01                	push   $0x1
      4b:	e8 20 14 00 00       	call   1470 <printf>
  if(stat == expected){
      50:	83 c4 10             	add    $0x10,%esp
      53:	39 f3                	cmp    %esi,%ebx
      55:	74 19                	je     70 <printstat+0x50>
    printf(1, "Test Failed\n");
      57:	c7 45 0c a0 1a 00 00 	movl   $0x1aa0,0xc(%ebp)
      5e:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
      65:	8d 65 f8             	lea    -0x8(%ebp),%esp
      68:	5b                   	pop    %ebx
      69:	5e                   	pop    %esi
      6a:	5d                   	pop    %ebp
    printf(1, "Test Failed\n");
      6b:	e9 00 14 00 00       	jmp    1470 <printf>
    printf(1, "Test Passed\n");
      70:	c7 45 0c 93 1a 00 00 	movl   $0x1a93,0xc(%ebp)
      77:	eb e5                	jmp    5e <printstat+0x3e>
      79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000080 <test_header>:
test_header(int test_n, char* text){
      80:	55                   	push   %ebp
      81:	89 e5                	mov    %esp,%ebp
      83:	56                   	push   %esi
      84:	53                   	push   %ebx
      85:	8b 5d 08             	mov    0x8(%ebp),%ebx
      88:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(1, "######################################\n");
      8b:	83 ec 08             	sub    $0x8,%esp
      8e:	68 bc 17 00 00       	push   $0x17bc
      93:	6a 01                	push   $0x1
      95:	e8 d6 13 00 00       	call   1470 <printf>
  printf(1, "sig_test: Starting test %d\n", test_n);
      9a:	83 c4 0c             	add    $0xc,%esp
      9d:	53                   	push   %ebx
      9e:	68 ad 1a 00 00       	push   $0x1aad
      a3:	6a 01                	push   $0x1
      a5:	e8 c6 13 00 00       	call   1470 <printf>
  printf(1, "Test %d: %s\n", test_n, text);
      aa:	56                   	push   %esi
      ab:	53                   	push   %ebx
      ac:	68 c9 1a 00 00       	push   $0x1ac9
      b1:	6a 01                	push   $0x1
      b3:	e8 b8 13 00 00       	call   1470 <printf>
  printf(1, "######################################\n\n\n");
      b8:	c7 45 0c e4 17 00 00 	movl   $0x17e4,0xc(%ebp)
      bf:	83 c4 20             	add    $0x20,%esp
      c2:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
      c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
      cc:	5b                   	pop    %ebx
      cd:	5e                   	pop    %esi
      ce:	5d                   	pop    %ebp
  printf(1, "######################################\n\n\n");
      cf:	e9 9c 13 00 00       	jmp    1470 <printf>
      d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      df:	90                   	nop

000000e0 <test_footer>:
test_footer(){
      e0:	55                   	push   %ebp
      e1:	89 e5                	mov    %esp,%ebp
      e3:	83 ec 10             	sub    $0x10,%esp
  printf(1,"\n\n\n");
      e6:	68 d6 1a 00 00       	push   $0x1ad6
      eb:	6a 01                	push   $0x1
      ed:	e8 7e 13 00 00       	call   1470 <printf>
}
      f2:	83 c4 10             	add    $0x10,%esp
      f5:	c9                   	leave
      f6:	c3                   	ret
      f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fe:	66 90                	xchg   %ax,%ax

00000100 <test_1>:
test_1(void){
     100:	55                   	push   %ebp
     101:	89 e5                	mov    %esp,%ebp
     103:	56                   	push   %esi
     104:	53                   	push   %ebx
     105:	83 ec 18             	sub    $0x18,%esp
  printf(1, "######################################\n");
     108:	68 bc 17 00 00       	push   $0x17bc
     10d:	6a 01                	push   $0x1
     10f:	e8 5c 13 00 00       	call   1470 <printf>
  printf(1, "sig_test: Starting test %d\n", test_n);
     114:	83 c4 0c             	add    $0xc,%esp
     117:	6a 01                	push   $0x1
     119:	68 ad 1a 00 00       	push   $0x1aad
     11e:	6a 01                	push   $0x1
     120:	e8 4b 13 00 00       	call   1470 <printf>
  printf(1, "Test %d: %s\n", test_n, text);
     125:	68 10 18 00 00       	push   $0x1810
     12a:	6a 01                	push   $0x1
     12c:	68 c9 1a 00 00       	push   $0x1ac9
     131:	6a 01                	push   $0x1
     133:	e8 38 13 00 00       	call   1470 <printf>
  printf(1, "######################################\n\n\n");
     138:	83 c4 18             	add    $0x18,%esp
     13b:	68 e4 17 00 00       	push   $0x17e4
     140:	6a 01                	push   $0x1
     142:	e8 29 13 00 00       	call   1470 <printf>
  pid = fork();
     147:	e8 8f 11 00 00       	call   12db <fork>
  if(pid == 0){
     14c:	83 c4 10             	add    $0x10,%esp
     14f:	85 c0                	test   %eax,%eax
     151:	0f 84 b2 00 00 00    	je     209 <test_1+0x109>
  sleep(100);
     157:	83 ec 0c             	sub    $0xc,%esp
     15a:	89 c3                	mov    %eax,%ebx
     15c:	6a 64                	push   $0x64
     15e:	e8 10 12 00 00       	call   1373 <sleep>
  term(pid);
     163:	89 1c 24             	mov    %ebx,(%esp)
     166:	e8 38 12 00 00       	call   13a3 <term>
  sleep(100);
     16b:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     172:	e8 fc 11 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     177:	89 1c 24             	mov    %ebx,(%esp)
     17a:	e8 1c 12 00 00       	call   139b <pstat>
     17f:	83 c4 10             	add    $0x10,%esp
     182:	89 c6                	mov    %eax,%esi
  switch(stat){
     184:	8d 40 ff             	lea    -0x1(%eax),%eax
     187:	83 f8 04             	cmp    $0x4,%eax
     18a:	77 54                	ja     1e0 <test_1+0xe0>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     18c:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     193:	53                   	push   %ebx
     194:	68 7c 1a 00 00       	push   $0x1a7c
     199:	6a 01                	push   $0x1
     19b:	e8 d0 12 00 00       	call   1470 <printf>
  if(stat == expected){
     1a0:	83 c4 10             	add    $0x10,%esp
     1a3:	83 fe 03             	cmp    $0x3,%esi
     1a6:	75 4d                	jne    1f5 <test_1+0xf5>
    printf(1, "Test Passed\n");
     1a8:	83 ec 08             	sub    $0x8,%esp
     1ab:	68 93 1a 00 00       	push   $0x1a93
     1b0:	6a 01                	push   $0x1
     1b2:	e8 b9 12 00 00       	call   1470 <printf>
  return 0;
     1b7:	83 c4 10             	add    $0x10,%esp
  kill(pid);
     1ba:	83 ec 0c             	sub    $0xc,%esp
     1bd:	53                   	push   %ebx
     1be:	e8 50 11 00 00       	call   1313 <kill>
  printf(1,"\n\n\n");
     1c3:	58                   	pop    %eax
     1c4:	5a                   	pop    %edx
     1c5:	68 d6 1a 00 00       	push   $0x1ad6
     1ca:	6a 01                	push   $0x1
     1cc:	e8 9f 12 00 00       	call   1470 <printf>
}
     1d1:	83 c4 10             	add    $0x10,%esp
     1d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     1d7:	5b                   	pop    %ebx
     1d8:	5e                   	pop    %esi
     1d9:	5d                   	pop    %ebp
     1da:	c3                   	ret
     1db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     1df:	90                   	nop
  printf(1, "PID %d is in state %s\n", pid, statstring);
     1e0:	68 98 17 00 00       	push   $0x1798
     1e5:	53                   	push   %ebx
     1e6:	68 7c 1a 00 00       	push   $0x1a7c
     1eb:	6a 01                	push   $0x1
     1ed:	e8 7e 12 00 00       	call   1470 <printf>
     1f2:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     1f5:	83 ec 08             	sub    $0x8,%esp
     1f8:	68 a0 1a 00 00       	push   $0x1aa0
     1fd:	6a 01                	push   $0x1
     1ff:	e8 6c 12 00 00       	call   1470 <printf>
     204:	83 c4 10             	add    $0x10,%esp
     207:	eb b1                	jmp    1ba <test_1+0xba>
    char *args[] = {"mask", "0", 0};
     209:	31 c9                	xor    %ecx,%ecx
    exec("mask", args); 
     20b:	8d 45 ec             	lea    -0x14(%ebp),%eax
    char *args[] = {"mask", "0", 0};
     20e:	c7 45 ec da 1a 00 00 	movl   $0x1ada,-0x14(%ebp)
     215:	89 4d f4             	mov    %ecx,-0xc(%ebp)
     218:	c7 45 f0 df 1a 00 00 	movl   $0x1adf,-0x10(%ebp)
    exec("mask", args); 
     21f:	53                   	push   %ebx
     220:	53                   	push   %ebx
     221:	50                   	push   %eax
     222:	68 da 1a 00 00       	push   $0x1ada
     227:	e8 ef 10 00 00       	call   131b <exec>
    exit();
     22c:	e8 b2 10 00 00       	call   12e3 <exit>
     231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     23f:	90                   	nop

00000240 <test_2>:
test_2(void){
     240:	55                   	push   %ebp
     241:	89 e5                	mov    %esp,%ebp
     243:	56                   	push   %esi
     244:	53                   	push   %ebx
     245:	83 ec 18             	sub    $0x18,%esp
  printf(1, "######################################\n");
     248:	68 bc 17 00 00       	push   $0x17bc
     24d:	6a 01                	push   $0x1
     24f:	e8 1c 12 00 00       	call   1470 <printf>
  printf(1, "sig_test: Starting test %d\n", test_n);
     254:	83 c4 0c             	add    $0xc,%esp
     257:	6a 02                	push   $0x2
     259:	68 ad 1a 00 00       	push   $0x1aad
     25e:	6a 01                	push   $0x1
     260:	e8 0b 12 00 00       	call   1470 <printf>
  printf(1, "Test %d: %s\n", test_n, text);
     265:	68 4c 18 00 00       	push   $0x184c
     26a:	6a 02                	push   $0x2
     26c:	68 c9 1a 00 00       	push   $0x1ac9
     271:	6a 01                	push   $0x1
     273:	e8 f8 11 00 00       	call   1470 <printf>
  printf(1, "######################################\n\n\n");
     278:	83 c4 18             	add    $0x18,%esp
     27b:	68 e4 17 00 00       	push   $0x17e4
     280:	6a 01                	push   $0x1
     282:	e8 e9 11 00 00       	call   1470 <printf>
  pid = fork();
     287:	e8 4f 10 00 00       	call   12db <fork>
  if(pid == 0){
     28c:	83 c4 10             	add    $0x10,%esp
     28f:	85 c0                	test   %eax,%eax
     291:	0f 84 b2 00 00 00    	je     349 <test_2+0x109>
  sleep(100);
     297:	83 ec 0c             	sub    $0xc,%esp
     29a:	89 c3                	mov    %eax,%ebx
     29c:	6a 64                	push   $0x64
     29e:	e8 d0 10 00 00       	call   1373 <sleep>
  term(pid);
     2a3:	89 1c 24             	mov    %ebx,(%esp)
     2a6:	e8 f8 10 00 00       	call   13a3 <term>
  sleep(100);
     2ab:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     2b2:	e8 bc 10 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     2b7:	89 1c 24             	mov    %ebx,(%esp)
     2ba:	e8 dc 10 00 00       	call   139b <pstat>
     2bf:	83 c4 10             	add    $0x10,%esp
     2c2:	89 c6                	mov    %eax,%esi
  switch(stat){
     2c4:	8d 40 ff             	lea    -0x1(%eax),%eax
     2c7:	83 f8 04             	cmp    $0x4,%eax
     2ca:	77 54                	ja     320 <test_2+0xe0>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     2cc:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     2d3:	53                   	push   %ebx
     2d4:	68 7c 1a 00 00       	push   $0x1a7c
     2d9:	6a 01                	push   $0x1
     2db:	e8 90 11 00 00       	call   1470 <printf>
  if(stat == expected){
     2e0:	83 c4 10             	add    $0x10,%esp
     2e3:	83 fe 01             	cmp    $0x1,%esi
     2e6:	75 4d                	jne    335 <test_2+0xf5>
    printf(1, "Test Passed\n");
     2e8:	83 ec 08             	sub    $0x8,%esp
     2eb:	68 93 1a 00 00       	push   $0x1a93
     2f0:	6a 01                	push   $0x1
     2f2:	e8 79 11 00 00       	call   1470 <printf>
  return 0;
     2f7:	83 c4 10             	add    $0x10,%esp
  kill(pid);
     2fa:	83 ec 0c             	sub    $0xc,%esp
     2fd:	53                   	push   %ebx
     2fe:	e8 10 10 00 00       	call   1313 <kill>
  printf(1,"\n\n\n");
     303:	58                   	pop    %eax
     304:	5a                   	pop    %edx
     305:	68 d6 1a 00 00       	push   $0x1ad6
     30a:	6a 01                	push   $0x1
     30c:	e8 5f 11 00 00       	call   1470 <printf>
}
     311:	83 c4 10             	add    $0x10,%esp
     314:	8d 65 f8             	lea    -0x8(%ebp),%esp
     317:	5b                   	pop    %ebx
     318:	5e                   	pop    %esi
     319:	5d                   	pop    %ebp
     31a:	c3                   	ret
     31b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     31f:	90                   	nop
  printf(1, "PID %d is in state %s\n", pid, statstring);
     320:	68 98 17 00 00       	push   $0x1798
     325:	53                   	push   %ebx
     326:	68 7c 1a 00 00       	push   $0x1a7c
     32b:	6a 01                	push   $0x1
     32d:	e8 3e 11 00 00       	call   1470 <printf>
     332:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     335:	83 ec 08             	sub    $0x8,%esp
     338:	68 a0 1a 00 00       	push   $0x1aa0
     33d:	6a 01                	push   $0x1
     33f:	e8 2c 11 00 00       	call   1470 <printf>
     344:	83 c4 10             	add    $0x10,%esp
     347:	eb b1                	jmp    2fa <test_2+0xba>
    char *args[] = {"mask", "1", 0};
     349:	31 c9                	xor    %ecx,%ecx
    exec("mask", args); 
     34b:	8d 45 ec             	lea    -0x14(%ebp),%eax
    char *args[] = {"mask", "1", 0};
     34e:	c7 45 ec da 1a 00 00 	movl   $0x1ada,-0x14(%ebp)
     355:	89 4d f4             	mov    %ecx,-0xc(%ebp)
     358:	c7 45 f0 e1 1a 00 00 	movl   $0x1ae1,-0x10(%ebp)
    exec("mask", args); 
     35f:	53                   	push   %ebx
     360:	53                   	push   %ebx
     361:	50                   	push   %eax
     362:	68 da 1a 00 00       	push   $0x1ada
     367:	e8 af 0f 00 00       	call   131b <exec>
    exit();
     36c:	e8 72 0f 00 00       	call   12e3 <exit>
     371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     378:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     37f:	90                   	nop

00000380 <test_3>:
void test_3(void) {
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	56                   	push   %esi
     384:	53                   	push   %ebx
     385:	83 ec 18             	sub    $0x18,%esp
  printf(1, "######################################\n");
     388:	68 bc 17 00 00       	push   $0x17bc
     38d:	6a 01                	push   $0x1
     38f:	e8 dc 10 00 00       	call   1470 <printf>
  printf(1, "sig_test: Starting test %d\n", test_n);
     394:	83 c4 0c             	add    $0xc,%esp
     397:	6a 03                	push   $0x3
     399:	68 ad 1a 00 00       	push   $0x1aad
     39e:	6a 01                	push   $0x1
     3a0:	e8 cb 10 00 00       	call   1470 <printf>
  printf(1, "Test %d: %s\n", test_n, text);
     3a5:	68 8c 18 00 00       	push   $0x188c
     3aa:	6a 03                	push   $0x3
     3ac:	68 c9 1a 00 00       	push   $0x1ac9
     3b1:	6a 01                	push   $0x1
     3b3:	e8 b8 10 00 00       	call   1470 <printf>
  printf(1, "######################################\n\n\n");
     3b8:	83 c4 18             	add    $0x18,%esp
     3bb:	68 e4 17 00 00       	push   $0x17e4
     3c0:	6a 01                	push   $0x1
     3c2:	e8 a9 10 00 00       	call   1470 <printf>
  pid = fork();
     3c7:	e8 0f 0f 00 00       	call   12db <fork>
  if(pid == 0){
     3cc:	83 c4 10             	add    $0x10,%esp
     3cf:	85 c0                	test   %eax,%eax
     3d1:	0f 84 b2 00 00 00    	je     489 <test_3+0x109>
  sleep(100);
     3d7:	83 ec 0c             	sub    $0xc,%esp
     3da:	89 c3                	mov    %eax,%ebx
     3dc:	6a 64                	push   $0x64
     3de:	e8 90 0f 00 00       	call   1373 <sleep>
  term(pid);
     3e3:	89 1c 24             	mov    %ebx,(%esp)
     3e6:	e8 b8 0f 00 00       	call   13a3 <term>
  sleep(100);
     3eb:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     3f2:	e8 7c 0f 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     3f7:	89 1c 24             	mov    %ebx,(%esp)
     3fa:	e8 9c 0f 00 00       	call   139b <pstat>
     3ff:	83 c4 10             	add    $0x10,%esp
     402:	89 c6                	mov    %eax,%esi
  switch(stat){
     404:	8d 40 ff             	lea    -0x1(%eax),%eax
     407:	83 f8 04             	cmp    $0x4,%eax
     40a:	77 54                	ja     460 <test_3+0xe0>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     40c:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     413:	53                   	push   %ebx
     414:	68 7c 1a 00 00       	push   $0x1a7c
     419:	6a 01                	push   $0x1
     41b:	e8 50 10 00 00       	call   1470 <printf>
  if(stat == expected){
     420:	83 c4 10             	add    $0x10,%esp
     423:	83 fe 03             	cmp    $0x3,%esi
     426:	75 4d                	jne    475 <test_3+0xf5>
    printf(1, "Test Passed\n");
     428:	83 ec 08             	sub    $0x8,%esp
     42b:	68 93 1a 00 00       	push   $0x1a93
     430:	6a 01                	push   $0x1
     432:	e8 39 10 00 00       	call   1470 <printf>
  return 0;
     437:	83 c4 10             	add    $0x10,%esp
  kill(pid);
     43a:	83 ec 0c             	sub    $0xc,%esp
     43d:	53                   	push   %ebx
     43e:	e8 d0 0e 00 00       	call   1313 <kill>
  printf(1,"\n\n\n");
     443:	58                   	pop    %eax
     444:	5a                   	pop    %edx
     445:	68 d6 1a 00 00       	push   $0x1ad6
     44a:	6a 01                	push   $0x1
     44c:	e8 1f 10 00 00       	call   1470 <printf>
}
     451:	83 c4 10             	add    $0x10,%esp
     454:	8d 65 f8             	lea    -0x8(%ebp),%esp
     457:	5b                   	pop    %ebx
     458:	5e                   	pop    %esi
     459:	5d                   	pop    %ebp
     45a:	c3                   	ret
     45b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     45f:	90                   	nop
  printf(1, "PID %d is in state %s\n", pid, statstring);
     460:	68 98 17 00 00       	push   $0x1798
     465:	53                   	push   %ebx
     466:	68 7c 1a 00 00       	push   $0x1a7c
     46b:	6a 01                	push   $0x1
     46d:	e8 fe 0f 00 00       	call   1470 <printf>
     472:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     475:	83 ec 08             	sub    $0x8,%esp
     478:	68 a0 1a 00 00       	push   $0x1aa0
     47d:	6a 01                	push   $0x1
     47f:	e8 ec 0f 00 00       	call   1470 <printf>
     484:	83 c4 10             	add    $0x10,%esp
     487:	eb b1                	jmp    43a <test_3+0xba>
    char *args[] = {"mask", "96", 0};
     489:	31 c9                	xor    %ecx,%ecx
    exec("mask", args); 
     48b:	8d 45 ec             	lea    -0x14(%ebp),%eax
    char *args[] = {"mask", "96", 0};
     48e:	c7 45 ec da 1a 00 00 	movl   $0x1ada,-0x14(%ebp)
     495:	89 4d f4             	mov    %ecx,-0xc(%ebp)
     498:	c7 45 f0 e3 1a 00 00 	movl   $0x1ae3,-0x10(%ebp)
    exec("mask", args); 
     49f:	53                   	push   %ebx
     4a0:	53                   	push   %ebx
     4a1:	50                   	push   %eax
     4a2:	68 da 1a 00 00       	push   $0x1ada
     4a7:	e8 6f 0e 00 00       	call   131b <exec>
    exit();
     4ac:	e8 32 0e 00 00       	call   12e3 <exit>
     4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4bf:	90                   	nop

000004c0 <test_4>:
void test_4(void){
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	56                   	push   %esi
     4c4:	53                   	push   %ebx
     4c5:	83 ec 18             	sub    $0x18,%esp
  printf(1, "######################################\n");
     4c8:	68 bc 17 00 00       	push   $0x17bc
     4cd:	6a 01                	push   $0x1
     4cf:	e8 9c 0f 00 00       	call   1470 <printf>
  printf(1, "sig_test: Starting test %d\n", test_n);
     4d4:	83 c4 0c             	add    $0xc,%esp
     4d7:	6a 04                	push   $0x4
     4d9:	68 ad 1a 00 00       	push   $0x1aad
     4de:	6a 01                	push   $0x1
     4e0:	e8 8b 0f 00 00       	call   1470 <printf>
  printf(1, "Test %d: %s\n", test_n, text);
     4e5:	68 c8 18 00 00       	push   $0x18c8
     4ea:	6a 04                	push   $0x4
     4ec:	68 c9 1a 00 00       	push   $0x1ac9
     4f1:	6a 01                	push   $0x1
     4f3:	e8 78 0f 00 00       	call   1470 <printf>
  printf(1, "######################################\n\n\n");
     4f8:	83 c4 18             	add    $0x18,%esp
     4fb:	68 e4 17 00 00       	push   $0x17e4
     500:	6a 01                	push   $0x1
     502:	e8 69 0f 00 00       	call   1470 <printf>
  pid = fork();
     507:	e8 cf 0d 00 00       	call   12db <fork>
  if(pid == 0){
     50c:	83 c4 10             	add    $0x10,%esp
     50f:	85 c0                	test   %eax,%eax
     511:	0f 84 b2 00 00 00    	je     5c9 <test_4+0x109>
  sleep(100);
     517:	83 ec 0c             	sub    $0xc,%esp
     51a:	89 c3                	mov    %eax,%ebx
     51c:	6a 64                	push   $0x64
     51e:	e8 50 0e 00 00       	call   1373 <sleep>
  term(pid);
     523:	89 1c 24             	mov    %ebx,(%esp)
     526:	e8 78 0e 00 00       	call   13a3 <term>
  sleep(100);
     52b:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     532:	e8 3c 0e 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     537:	89 1c 24             	mov    %ebx,(%esp)
     53a:	e8 5c 0e 00 00       	call   139b <pstat>
     53f:	83 c4 10             	add    $0x10,%esp
     542:	89 c6                	mov    %eax,%esi
  switch(stat){
     544:	8d 40 ff             	lea    -0x1(%eax),%eax
     547:	83 f8 04             	cmp    $0x4,%eax
     54a:	77 54                	ja     5a0 <test_4+0xe0>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     54c:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     553:	53                   	push   %ebx
     554:	68 7c 1a 00 00       	push   $0x1a7c
     559:	6a 01                	push   $0x1
     55b:	e8 10 0f 00 00       	call   1470 <printf>
  if(stat == expected){
     560:	83 c4 10             	add    $0x10,%esp
     563:	83 fe 01             	cmp    $0x1,%esi
     566:	75 4d                	jne    5b5 <test_4+0xf5>
    printf(1, "Test Passed\n");
     568:	83 ec 08             	sub    $0x8,%esp
     56b:	68 93 1a 00 00       	push   $0x1a93
     570:	6a 01                	push   $0x1
     572:	e8 f9 0e 00 00       	call   1470 <printf>
  return 0;
     577:	83 c4 10             	add    $0x10,%esp
  kill(pid);
     57a:	83 ec 0c             	sub    $0xc,%esp
     57d:	53                   	push   %ebx
     57e:	e8 90 0d 00 00       	call   1313 <kill>
  printf(1,"\n\n\n");
     583:	58                   	pop    %eax
     584:	5a                   	pop    %edx
     585:	68 d6 1a 00 00       	push   $0x1ad6
     58a:	6a 01                	push   $0x1
     58c:	e8 df 0e 00 00       	call   1470 <printf>
}
     591:	83 c4 10             	add    $0x10,%esp
     594:	8d 65 f8             	lea    -0x8(%ebp),%esp
     597:	5b                   	pop    %ebx
     598:	5e                   	pop    %esi
     599:	5d                   	pop    %ebp
     59a:	c3                   	ret
     59b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     59f:	90                   	nop
  printf(1, "PID %d is in state %s\n", pid, statstring);
     5a0:	68 98 17 00 00       	push   $0x1798
     5a5:	53                   	push   %ebx
     5a6:	68 7c 1a 00 00       	push   $0x1a7c
     5ab:	6a 01                	push   $0x1
     5ad:	e8 be 0e 00 00       	call   1470 <printf>
     5b2:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     5b5:	83 ec 08             	sub    $0x8,%esp
     5b8:	68 a0 1a 00 00       	push   $0x1aa0
     5bd:	6a 01                	push   $0x1
     5bf:	e8 ac 0e 00 00       	call   1470 <printf>
     5c4:	83 c4 10             	add    $0x10,%esp
     5c7:	eb b1                	jmp    57a <test_4+0xba>
    char *args[] = {"mask", "3", 0};
     5c9:	31 c9                	xor    %ecx,%ecx
    exec("mask", args); 
     5cb:	8d 45 ec             	lea    -0x14(%ebp),%eax
    char *args[] = {"mask", "3", 0};
     5ce:	c7 45 ec da 1a 00 00 	movl   $0x1ada,-0x14(%ebp)
     5d5:	89 4d f4             	mov    %ecx,-0xc(%ebp)
     5d8:	c7 45 f0 e6 1a 00 00 	movl   $0x1ae6,-0x10(%ebp)
    exec("mask", args); 
     5df:	53                   	push   %ebx
     5e0:	53                   	push   %ebx
     5e1:	50                   	push   %eax
     5e2:	68 da 1a 00 00       	push   $0x1ada
     5e7:	e8 2f 0d 00 00       	call   131b <exec>
    exit();
     5ec:	e8 f2 0c 00 00       	call   12e3 <exit>
     5f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5ff:	90                   	nop

00000600 <test_5>:
void test_5(void){
     600:	55                   	push   %ebp
     601:	89 e5                	mov    %esp,%ebp
     603:	56                   	push   %esi
     604:	53                   	push   %ebx
     605:	83 ec 18             	sub    $0x18,%esp
  printf(1, "######################################\n");
     608:	68 bc 17 00 00       	push   $0x17bc
     60d:	6a 01                	push   $0x1
     60f:	e8 5c 0e 00 00       	call   1470 <printf>
  printf(1, "sig_test: Starting test %d\n", test_n);
     614:	83 c4 0c             	add    $0xc,%esp
     617:	6a 05                	push   $0x5
     619:	68 ad 1a 00 00       	push   $0x1aad
     61e:	6a 01                	push   $0x1
     620:	e8 4b 0e 00 00       	call   1470 <printf>
  printf(1, "Test %d: %s\n", test_n, text);
     625:	68 08 19 00 00       	push   $0x1908
     62a:	6a 05                	push   $0x5
     62c:	68 c9 1a 00 00       	push   $0x1ac9
     631:	6a 01                	push   $0x1
     633:	e8 38 0e 00 00       	call   1470 <printf>
  printf(1, "######################################\n\n\n");
     638:	83 c4 18             	add    $0x18,%esp
     63b:	68 e4 17 00 00       	push   $0x17e4
     640:	6a 01                	push   $0x1
     642:	e8 29 0e 00 00       	call   1470 <printf>
  pid = fork();
     647:	e8 8f 0c 00 00       	call   12db <fork>
  if(pid == 0){
     64c:	83 c4 10             	add    $0x10,%esp
     64f:	85 c0                	test   %eax,%eax
     651:	0f 84 70 01 00 00    	je     7c7 <test_5+0x1c7>
  sleep(100);
     657:	83 ec 0c             	sub    $0xc,%esp
     65a:	89 c3                	mov    %eax,%ebx
     65c:	6a 64                	push   $0x64
     65e:	e8 10 0d 00 00       	call   1373 <sleep>
  stop(pid);
     663:	89 1c 24             	mov    %ebx,(%esp)
     666:	e8 48 0d 00 00       	call   13b3 <stop>
  sleep(100);
     66b:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     672:	e8 fc 0c 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     677:	89 1c 24             	mov    %ebx,(%esp)
     67a:	e8 1c 0d 00 00       	call   139b <pstat>
  printf(1, "%d\n", stat);
     67f:	83 c4 0c             	add    $0xc,%esp
     682:	50                   	push   %eax
  stat = pstat(pid);
     683:	89 c6                	mov    %eax,%esi
  printf(1, "%d\n", stat);
     685:	68 c5 1a 00 00       	push   $0x1ac5
     68a:	6a 01                	push   $0x1
     68c:	e8 df 0d 00 00       	call   1470 <printf>
  switch(stat){
     691:	8d 46 ff             	lea    -0x1(%esi),%eax
     694:	83 c4 10             	add    $0x10,%esp
     697:	83 f8 04             	cmp    $0x4,%eax
     69a:	0f 87 c0 00 00 00    	ja     760 <test_5+0x160>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     6a0:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     6a7:	53                   	push   %ebx
     6a8:	68 7c 1a 00 00       	push   $0x1a7c
     6ad:	6a 01                	push   $0x1
     6af:	e8 bc 0d 00 00       	call   1470 <printf>
  if(stat == expected){
     6b4:	83 c4 10             	add    $0x10,%esp
     6b7:	83 fe 05             	cmp    $0x5,%esi
     6ba:	0f 85 b5 00 00 00    	jne    775 <test_5+0x175>
    printf(1, "Test Passed\n");
     6c0:	83 ec 08             	sub    $0x8,%esp
     6c3:	68 93 1a 00 00       	push   $0x1a93
     6c8:	6a 01                	push   $0x1
     6ca:	e8 a1 0d 00 00       	call   1470 <printf>
  return 0;
     6cf:	83 c4 10             	add    $0x10,%esp
  sleep(100);
     6d2:	83 ec 0c             	sub    $0xc,%esp
     6d5:	6a 64                	push   $0x64
     6d7:	e8 97 0c 00 00       	call   1373 <sleep>
  cont(pid);
     6dc:	89 1c 24             	mov    %ebx,(%esp)
     6df:	e8 d7 0c 00 00       	call   13bb <cont>
  sleep(100);
     6e4:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     6eb:	e8 83 0c 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     6f0:	89 1c 24             	mov    %ebx,(%esp)
     6f3:	e8 a3 0c 00 00       	call   139b <pstat>
  printf(1, "%d\n", stat);
     6f8:	83 c4 0c             	add    $0xc,%esp
     6fb:	50                   	push   %eax
  stat = pstat(pid);
     6fc:	89 c6                	mov    %eax,%esi
  printf(1, "%d\n", stat);
     6fe:	68 c5 1a 00 00       	push   $0x1ac5
     703:	6a 01                	push   $0x1
     705:	e8 66 0d 00 00       	call   1470 <printf>
  switch(stat){
     70a:	8d 46 ff             	lea    -0x1(%esi),%eax
     70d:	83 c4 10             	add    $0x10,%esp
     710:	83 f8 04             	cmp    $0x4,%eax
     713:	76 7b                	jbe    790 <test_5+0x190>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     715:	68 98 17 00 00       	push   $0x1798
     71a:	53                   	push   %ebx
     71b:	68 7c 1a 00 00       	push   $0x1a7c
     720:	6a 01                	push   $0x1
     722:	e8 49 0d 00 00       	call   1470 <printf>
     727:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     72a:	83 ec 08             	sub    $0x8,%esp
     72d:	68 a0 1a 00 00       	push   $0x1aa0
     732:	6a 01                	push   $0x1
     734:	e8 37 0d 00 00       	call   1470 <printf>
     739:	83 c4 10             	add    $0x10,%esp
  kill(pid);
     73c:	83 ec 0c             	sub    $0xc,%esp
     73f:	53                   	push   %ebx
     740:	e8 ce 0b 00 00       	call   1313 <kill>
  printf(1,"\n\n\n");
     745:	58                   	pop    %eax
     746:	5a                   	pop    %edx
     747:	68 d6 1a 00 00       	push   $0x1ad6
     74c:	6a 01                	push   $0x1
     74e:	e8 1d 0d 00 00       	call   1470 <printf>
}
     753:	83 c4 10             	add    $0x10,%esp
     756:	8d 65 f8             	lea    -0x8(%ebp),%esp
     759:	5b                   	pop    %ebx
     75a:	5e                   	pop    %esi
     75b:	5d                   	pop    %ebp
     75c:	c3                   	ret
     75d:	8d 76 00             	lea    0x0(%esi),%esi
  printf(1, "PID %d is in state %s\n", pid, statstring);
     760:	68 98 17 00 00       	push   $0x1798
     765:	53                   	push   %ebx
     766:	68 7c 1a 00 00       	push   $0x1a7c
     76b:	6a 01                	push   $0x1
     76d:	e8 fe 0c 00 00       	call   1470 <printf>
     772:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     775:	83 ec 08             	sub    $0x8,%esp
     778:	68 a0 1a 00 00       	push   $0x1aa0
     77d:	6a 01                	push   $0x1
     77f:	e8 ec 0c 00 00       	call   1470 <printf>
     784:	83 c4 10             	add    $0x10,%esp
     787:	e9 46 ff ff ff       	jmp    6d2 <test_5+0xd2>
     78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "PID %d is in state %s\n", pid, statstring);
     790:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     797:	53                   	push   %ebx
     798:	68 7c 1a 00 00       	push   $0x1a7c
     79d:	6a 01                	push   $0x1
     79f:	e8 cc 0c 00 00       	call   1470 <printf>
  if(stat == expected){
     7a4:	83 c4 10             	add    $0x10,%esp
     7a7:	83 fe 01             	cmp    $0x1,%esi
     7aa:	0f 85 7a ff ff ff    	jne    72a <test_5+0x12a>
    printf(1, "Test Passed\n");
     7b0:	83 ec 08             	sub    $0x8,%esp
     7b3:	68 93 1a 00 00       	push   $0x1a93
     7b8:	6a 01                	push   $0x1
     7ba:	e8 b1 0c 00 00       	call   1470 <printf>
  return 0;
     7bf:	83 c4 10             	add    $0x10,%esp
     7c2:	e9 75 ff ff ff       	jmp    73c <test_5+0x13c>
    char *args[] = {"mask", "0", 0};
     7c7:	31 c9                	xor    %ecx,%ecx
    exec("mask", args); 
     7c9:	8d 45 ec             	lea    -0x14(%ebp),%eax
    char *args[] = {"mask", "0", 0};
     7cc:	c7 45 ec da 1a 00 00 	movl   $0x1ada,-0x14(%ebp)
     7d3:	89 4d f4             	mov    %ecx,-0xc(%ebp)
     7d6:	c7 45 f0 df 1a 00 00 	movl   $0x1adf,-0x10(%ebp)
    exec("mask", args); 
     7dd:	53                   	push   %ebx
     7de:	53                   	push   %ebx
     7df:	50                   	push   %eax
     7e0:	68 da 1a 00 00       	push   $0x1ada
     7e5:	e8 31 0b 00 00       	call   131b <exec>
    exit();
     7ea:	e8 f4 0a 00 00       	call   12e3 <exit>
     7ef:	90                   	nop

000007f0 <test_6>:
void test_6(void){
     7f0:	55                   	push   %ebp
     7f1:	89 e5                	mov    %esp,%ebp
     7f3:	56                   	push   %esi
     7f4:	53                   	push   %ebx
     7f5:	83 ec 18             	sub    $0x18,%esp
  printf(1, "######################################\n");
     7f8:	68 bc 17 00 00       	push   $0x17bc
     7fd:	6a 01                	push   $0x1
     7ff:	e8 6c 0c 00 00       	call   1470 <printf>
  printf(1, "sig_test: Starting test %d\n", test_n);
     804:	83 c4 0c             	add    $0xc,%esp
     807:	6a 06                	push   $0x6
     809:	68 ad 1a 00 00       	push   $0x1aad
     80e:	6a 01                	push   $0x1
     810:	e8 5b 0c 00 00       	call   1470 <printf>
  printf(1, "Test %d: %s\n", test_n, text);
     815:	68 44 19 00 00       	push   $0x1944
     81a:	6a 06                	push   $0x6
     81c:	68 c9 1a 00 00       	push   $0x1ac9
     821:	6a 01                	push   $0x1
     823:	e8 48 0c 00 00       	call   1470 <printf>
  printf(1, "######################################\n\n\n");
     828:	83 c4 18             	add    $0x18,%esp
     82b:	68 e4 17 00 00       	push   $0x17e4
     830:	6a 01                	push   $0x1
     832:	e8 39 0c 00 00       	call   1470 <printf>
  pid = fork();
     837:	e8 9f 0a 00 00       	call   12db <fork>
  if(pid == 0){
     83c:	83 c4 10             	add    $0x10,%esp
     83f:	85 c0                	test   %eax,%eax
     841:	0f 84 50 01 00 00    	je     997 <test_6+0x1a7>
  sleep(100);
     847:	83 ec 0c             	sub    $0xc,%esp
     84a:	89 c3                	mov    %eax,%ebx
     84c:	6a 64                	push   $0x64
     84e:	e8 20 0b 00 00       	call   1373 <sleep>
  stop(pid);
     853:	89 1c 24             	mov    %ebx,(%esp)
     856:	e8 58 0b 00 00       	call   13b3 <stop>
  sleep(100);
     85b:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     862:	e8 0c 0b 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     867:	89 1c 24             	mov    %ebx,(%esp)
     86a:	e8 2c 0b 00 00       	call   139b <pstat>
     86f:	83 c4 10             	add    $0x10,%esp
     872:	89 c6                	mov    %eax,%esi
  switch(stat){
     874:	8d 40 ff             	lea    -0x1(%eax),%eax
     877:	83 f8 04             	cmp    $0x4,%eax
     87a:	0f 87 b0 00 00 00    	ja     930 <test_6+0x140>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     880:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     887:	53                   	push   %ebx
     888:	68 7c 1a 00 00       	push   $0x1a7c
     88d:	6a 01                	push   $0x1
     88f:	e8 dc 0b 00 00       	call   1470 <printf>
  if(stat == expected){
     894:	83 c4 10             	add    $0x10,%esp
     897:	83 fe 01             	cmp    $0x1,%esi
     89a:	0f 85 a5 00 00 00    	jne    945 <test_6+0x155>
    printf(1, "Test Passed\n");
     8a0:	83 ec 08             	sub    $0x8,%esp
     8a3:	68 93 1a 00 00       	push   $0x1a93
     8a8:	6a 01                	push   $0x1
     8aa:	e8 c1 0b 00 00       	call   1470 <printf>
  return 0;
     8af:	83 c4 10             	add    $0x10,%esp
  sleep(100);
     8b2:	83 ec 0c             	sub    $0xc,%esp
     8b5:	6a 64                	push   $0x64
     8b7:	e8 b7 0a 00 00       	call   1373 <sleep>
  cont(pid);
     8bc:	89 1c 24             	mov    %ebx,(%esp)
     8bf:	e8 f7 0a 00 00       	call   13bb <cont>
  sleep(100);
     8c4:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     8cb:	e8 a3 0a 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     8d0:	89 1c 24             	mov    %ebx,(%esp)
     8d3:	e8 c3 0a 00 00       	call   139b <pstat>
     8d8:	83 c4 10             	add    $0x10,%esp
     8db:	89 c6                	mov    %eax,%esi
  switch(stat){
     8dd:	8d 40 ff             	lea    -0x1(%eax),%eax
     8e0:	83 f8 04             	cmp    $0x4,%eax
     8e3:	76 7b                	jbe    960 <test_6+0x170>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     8e5:	68 98 17 00 00       	push   $0x1798
     8ea:	53                   	push   %ebx
     8eb:	68 7c 1a 00 00       	push   $0x1a7c
     8f0:	6a 01                	push   $0x1
     8f2:	e8 79 0b 00 00       	call   1470 <printf>
     8f7:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     8fa:	83 ec 08             	sub    $0x8,%esp
     8fd:	68 a0 1a 00 00       	push   $0x1aa0
     902:	6a 01                	push   $0x1
     904:	e8 67 0b 00 00       	call   1470 <printf>
     909:	83 c4 10             	add    $0x10,%esp
  kill(pid);
     90c:	83 ec 0c             	sub    $0xc,%esp
     90f:	53                   	push   %ebx
     910:	e8 fe 09 00 00       	call   1313 <kill>
  printf(1,"\n\n\n");
     915:	58                   	pop    %eax
     916:	5a                   	pop    %edx
     917:	68 d6 1a 00 00       	push   $0x1ad6
     91c:	6a 01                	push   $0x1
     91e:	e8 4d 0b 00 00       	call   1470 <printf>
}
     923:	83 c4 10             	add    $0x10,%esp
     926:	8d 65 f8             	lea    -0x8(%ebp),%esp
     929:	5b                   	pop    %ebx
     92a:	5e                   	pop    %esi
     92b:	5d                   	pop    %ebp
     92c:	c3                   	ret
     92d:	8d 76 00             	lea    0x0(%esi),%esi
  printf(1, "PID %d is in state %s\n", pid, statstring);
     930:	68 98 17 00 00       	push   $0x1798
     935:	53                   	push   %ebx
     936:	68 7c 1a 00 00       	push   $0x1a7c
     93b:	6a 01                	push   $0x1
     93d:	e8 2e 0b 00 00       	call   1470 <printf>
     942:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     945:	83 ec 08             	sub    $0x8,%esp
     948:	68 a0 1a 00 00       	push   $0x1aa0
     94d:	6a 01                	push   $0x1
     94f:	e8 1c 0b 00 00       	call   1470 <printf>
     954:	83 c4 10             	add    $0x10,%esp
     957:	e9 56 ff ff ff       	jmp    8b2 <test_6+0xc2>
     95c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "PID %d is in state %s\n", pid, statstring);
     960:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     967:	53                   	push   %ebx
     968:	68 7c 1a 00 00       	push   $0x1a7c
     96d:	6a 01                	push   $0x1
     96f:	e8 fc 0a 00 00       	call   1470 <printf>
  if(stat == expected){
     974:	83 c4 10             	add    $0x10,%esp
     977:	83 fe 01             	cmp    $0x1,%esi
     97a:	0f 85 7a ff ff ff    	jne    8fa <test_6+0x10a>
    printf(1, "Test Passed\n");
     980:	83 ec 08             	sub    $0x8,%esp
     983:	68 93 1a 00 00       	push   $0x1a93
     988:	6a 01                	push   $0x1
     98a:	e8 e1 0a 00 00       	call   1470 <printf>
  return 0;
     98f:	83 c4 10             	add    $0x10,%esp
     992:	e9 75 ff ff ff       	jmp    90c <test_6+0x11c>
    char *args[] = {"mask", "7", 0};
     997:	31 c9                	xor    %ecx,%ecx
    exec("mask", args); 
     999:	8d 45 ec             	lea    -0x14(%ebp),%eax
    char *args[] = {"mask", "7", 0};
     99c:	c7 45 ec da 1a 00 00 	movl   $0x1ada,-0x14(%ebp)
     9a3:	89 4d f4             	mov    %ecx,-0xc(%ebp)
     9a6:	c7 45 f0 e8 1a 00 00 	movl   $0x1ae8,-0x10(%ebp)
    exec("mask", args); 
     9ad:	53                   	push   %ebx
     9ae:	53                   	push   %ebx
     9af:	50                   	push   %eax
     9b0:	68 da 1a 00 00       	push   $0x1ada
     9b5:	e8 61 09 00 00       	call   131b <exec>
    exit();
     9ba:	e8 24 09 00 00       	call   12e3 <exit>
     9bf:	90                   	nop

000009c0 <test_7>:
void test_7(void){
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	56                   	push   %esi
     9c4:	53                   	push   %ebx
     9c5:	83 ec 18             	sub    $0x18,%esp
  printf(1, "######################################\n");
     9c8:	68 bc 17 00 00       	push   $0x17bc
     9cd:	6a 01                	push   $0x1
     9cf:	e8 9c 0a 00 00       	call   1470 <printf>
  printf(1, "sig_test: Starting test %d\n", test_n);
     9d4:	83 c4 0c             	add    $0xc,%esp
     9d7:	6a 07                	push   $0x7
     9d9:	68 ad 1a 00 00       	push   $0x1aad
     9de:	6a 01                	push   $0x1
     9e0:	e8 8b 0a 00 00       	call   1470 <printf>
  printf(1, "Test %d: %s\n", test_n, text);
     9e5:	68 80 19 00 00       	push   $0x1980
     9ea:	6a 07                	push   $0x7
     9ec:	68 c9 1a 00 00       	push   $0x1ac9
     9f1:	6a 01                	push   $0x1
     9f3:	e8 78 0a 00 00       	call   1470 <printf>
  printf(1, "######################################\n\n\n");
     9f8:	83 c4 18             	add    $0x18,%esp
     9fb:	68 e4 17 00 00       	push   $0x17e4
     a00:	6a 01                	push   $0x1
     a02:	e8 69 0a 00 00       	call   1470 <printf>
  pid = fork();
     a07:	e8 cf 08 00 00       	call   12db <fork>
  if(pid == 0){
     a0c:	83 c4 10             	add    $0x10,%esp
     a0f:	85 c0                	test   %eax,%eax
     a11:	0f 84 50 01 00 00    	je     b67 <test_7+0x1a7>
  sleep(100);
     a17:	83 ec 0c             	sub    $0xc,%esp
     a1a:	89 c3                	mov    %eax,%ebx
     a1c:	6a 64                	push   $0x64
     a1e:	e8 50 09 00 00       	call   1373 <sleep>
  cont(pid);
     a23:	89 1c 24             	mov    %ebx,(%esp)
     a26:	e8 90 09 00 00       	call   13bb <cont>
  sleep(100);
     a2b:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     a32:	e8 3c 09 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     a37:	89 1c 24             	mov    %ebx,(%esp)
     a3a:	e8 5c 09 00 00       	call   139b <pstat>
     a3f:	83 c4 10             	add    $0x10,%esp
     a42:	89 c6                	mov    %eax,%esi
  switch(stat){
     a44:	8d 40 ff             	lea    -0x1(%eax),%eax
     a47:	83 f8 04             	cmp    $0x4,%eax
     a4a:	0f 87 b0 00 00 00    	ja     b00 <test_7+0x140>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     a50:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     a57:	53                   	push   %ebx
     a58:	68 7c 1a 00 00       	push   $0x1a7c
     a5d:	6a 01                	push   $0x1
     a5f:	e8 0c 0a 00 00       	call   1470 <printf>
  if(stat == expected){
     a64:	83 c4 10             	add    $0x10,%esp
     a67:	83 fe 01             	cmp    $0x1,%esi
     a6a:	0f 85 a5 00 00 00    	jne    b15 <test_7+0x155>
    printf(1, "Test Passed\n");
     a70:	83 ec 08             	sub    $0x8,%esp
     a73:	68 93 1a 00 00       	push   $0x1a93
     a78:	6a 01                	push   $0x1
     a7a:	e8 f1 09 00 00       	call   1470 <printf>
  return 0;
     a7f:	83 c4 10             	add    $0x10,%esp
  sleep(100);
     a82:	83 ec 0c             	sub    $0xc,%esp
     a85:	6a 64                	push   $0x64
     a87:	e8 e7 08 00 00       	call   1373 <sleep>
  stop(pid);
     a8c:	89 1c 24             	mov    %ebx,(%esp)
     a8f:	e8 1f 09 00 00       	call   13b3 <stop>
  sleep(100);
     a94:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     a9b:	e8 d3 08 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     aa0:	89 1c 24             	mov    %ebx,(%esp)
     aa3:	e8 f3 08 00 00       	call   139b <pstat>
     aa8:	83 c4 10             	add    $0x10,%esp
     aab:	89 c6                	mov    %eax,%esi
  switch(stat){
     aad:	8d 40 ff             	lea    -0x1(%eax),%eax
     ab0:	83 f8 04             	cmp    $0x4,%eax
     ab3:	76 7b                	jbe    b30 <test_7+0x170>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     ab5:	68 98 17 00 00       	push   $0x1798
     aba:	53                   	push   %ebx
     abb:	68 7c 1a 00 00       	push   $0x1a7c
     ac0:	6a 01                	push   $0x1
     ac2:	e8 a9 09 00 00       	call   1470 <printf>
     ac7:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     aca:	83 ec 08             	sub    $0x8,%esp
     acd:	68 a0 1a 00 00       	push   $0x1aa0
     ad2:	6a 01                	push   $0x1
     ad4:	e8 97 09 00 00       	call   1470 <printf>
     ad9:	83 c4 10             	add    $0x10,%esp
  kill(pid);
     adc:	83 ec 0c             	sub    $0xc,%esp
     adf:	53                   	push   %ebx
     ae0:	e8 2e 08 00 00       	call   1313 <kill>
  printf(1,"\n\n\n");
     ae5:	58                   	pop    %eax
     ae6:	5a                   	pop    %edx
     ae7:	68 d6 1a 00 00       	push   $0x1ad6
     aec:	6a 01                	push   $0x1
     aee:	e8 7d 09 00 00       	call   1470 <printf>
}
     af3:	83 c4 10             	add    $0x10,%esp
     af6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     af9:	5b                   	pop    %ebx
     afa:	5e                   	pop    %esi
     afb:	5d                   	pop    %ebp
     afc:	c3                   	ret
     afd:	8d 76 00             	lea    0x0(%esi),%esi
  printf(1, "PID %d is in state %s\n", pid, statstring);
     b00:	68 98 17 00 00       	push   $0x1798
     b05:	53                   	push   %ebx
     b06:	68 7c 1a 00 00       	push   $0x1a7c
     b0b:	6a 01                	push   $0x1
     b0d:	e8 5e 09 00 00       	call   1470 <printf>
     b12:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     b15:	83 ec 08             	sub    $0x8,%esp
     b18:	68 a0 1a 00 00       	push   $0x1aa0
     b1d:	6a 01                	push   $0x1
     b1f:	e8 4c 09 00 00       	call   1470 <printf>
     b24:	83 c4 10             	add    $0x10,%esp
     b27:	e9 56 ff ff ff       	jmp    a82 <test_7+0xc2>
     b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "PID %d is in state %s\n", pid, statstring);
     b30:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     b37:	53                   	push   %ebx
     b38:	68 7c 1a 00 00       	push   $0x1a7c
     b3d:	6a 01                	push   $0x1
     b3f:	e8 2c 09 00 00       	call   1470 <printf>
  if(stat == expected){
     b44:	83 c4 10             	add    $0x10,%esp
     b47:	83 fe 05             	cmp    $0x5,%esi
     b4a:	0f 85 7a ff ff ff    	jne    aca <test_7+0x10a>
    printf(1, "Test Passed\n");
     b50:	83 ec 08             	sub    $0x8,%esp
     b53:	68 93 1a 00 00       	push   $0x1a93
     b58:	6a 01                	push   $0x1
     b5a:	e8 11 09 00 00       	call   1470 <printf>
  return 0;
     b5f:	83 c4 10             	add    $0x10,%esp
     b62:	e9 75 ff ff ff       	jmp    adc <test_7+0x11c>
    char *args[] = {"mask", "0", 0};
     b67:	31 c9                	xor    %ecx,%ecx
    exec("mask", args); 
     b69:	8d 45 ec             	lea    -0x14(%ebp),%eax
    char *args[] = {"mask", "0", 0};
     b6c:	c7 45 ec da 1a 00 00 	movl   $0x1ada,-0x14(%ebp)
     b73:	89 4d f4             	mov    %ecx,-0xc(%ebp)
     b76:	c7 45 f0 df 1a 00 00 	movl   $0x1adf,-0x10(%ebp)
    exec("mask", args); 
     b7d:	53                   	push   %ebx
     b7e:	53                   	push   %ebx
     b7f:	50                   	push   %eax
     b80:	68 da 1a 00 00       	push   $0x1ada
     b85:	e8 91 07 00 00       	call   131b <exec>
    exit();
     b8a:	e8 54 07 00 00       	call   12e3 <exit>
     b8f:	90                   	nop

00000b90 <test_8>:
void test_8(void){
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	56                   	push   %esi
     b94:	53                   	push   %ebx
     b95:	83 ec 18             	sub    $0x18,%esp
  printf(1, "######################################\n");
     b98:	68 bc 17 00 00       	push   $0x17bc
     b9d:	6a 01                	push   $0x1
     b9f:	e8 cc 08 00 00       	call   1470 <printf>
  printf(1, "sig_test: Starting test %d\n", test_n);
     ba4:	83 c4 0c             	add    $0xc,%esp
     ba7:	6a 08                	push   $0x8
     ba9:	68 ad 1a 00 00       	push   $0x1aad
     bae:	6a 01                	push   $0x1
     bb0:	e8 bb 08 00 00       	call   1470 <printf>
  printf(1, "Test %d: %s\n", test_n, text);
     bb5:	68 c4 19 00 00       	push   $0x19c4
     bba:	6a 08                	push   $0x8
     bbc:	68 c9 1a 00 00       	push   $0x1ac9
     bc1:	6a 01                	push   $0x1
     bc3:	e8 a8 08 00 00       	call   1470 <printf>
  printf(1, "######################################\n\n\n");
     bc8:	83 c4 18             	add    $0x18,%esp
     bcb:	68 e4 17 00 00       	push   $0x17e4
     bd0:	6a 01                	push   $0x1
     bd2:	e8 99 08 00 00       	call   1470 <printf>
  pid = fork();
     bd7:	e8 ff 06 00 00       	call   12db <fork>
  if(pid == 0){
     bdc:	83 c4 10             	add    $0x10,%esp
     bdf:	85 c0                	test   %eax,%eax
     be1:	0f 84 f0 01 00 00    	je     dd7 <test_8+0x247>
  sleep(100);
     be7:	83 ec 0c             	sub    $0xc,%esp
     bea:	89 c3                	mov    %eax,%ebx
     bec:	6a 64                	push   $0x64
     bee:	e8 80 07 00 00       	call   1373 <sleep>
  stop(pid);
     bf3:	89 1c 24             	mov    %ebx,(%esp)
     bf6:	e8 b8 07 00 00       	call   13b3 <stop>
  sleep(100);
     bfb:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     c02:	e8 6c 07 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     c07:	89 1c 24             	mov    %ebx,(%esp)
     c0a:	e8 8c 07 00 00       	call   139b <pstat>
     c0f:	83 c4 10             	add    $0x10,%esp
     c12:	89 c6                	mov    %eax,%esi
  switch(stat){
     c14:	8d 40 ff             	lea    -0x1(%eax),%eax
     c17:	83 f8 04             	cmp    $0x4,%eax
     c1a:	0f 87 10 01 00 00    	ja     d30 <test_8+0x1a0>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     c20:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     c27:	53                   	push   %ebx
     c28:	68 7c 1a 00 00       	push   $0x1a7c
     c2d:	6a 01                	push   $0x1
     c2f:	e8 3c 08 00 00       	call   1470 <printf>
  if(stat == expected){
     c34:	83 c4 10             	add    $0x10,%esp
     c37:	83 fe 05             	cmp    $0x5,%esi
     c3a:	0f 85 05 01 00 00    	jne    d45 <test_8+0x1b5>
    printf(1, "Test Passed\n");
     c40:	83 ec 08             	sub    $0x8,%esp
     c43:	68 93 1a 00 00       	push   $0x1a93
     c48:	6a 01                	push   $0x1
     c4a:	e8 21 08 00 00       	call   1470 <printf>
  return 0;
     c4f:	83 c4 10             	add    $0x10,%esp
  sleep(100);
     c52:	83 ec 0c             	sub    $0xc,%esp
     c55:	6a 64                	push   $0x64
     c57:	e8 17 07 00 00       	call   1373 <sleep>
  stop(pid);
     c5c:	89 1c 24             	mov    %ebx,(%esp)
     c5f:	e8 4f 07 00 00       	call   13b3 <stop>
  sleep(100);
     c64:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     c6b:	e8 03 07 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     c70:	89 1c 24             	mov    %ebx,(%esp)
     c73:	e8 23 07 00 00       	call   139b <pstat>
     c78:	83 c4 10             	add    $0x10,%esp
     c7b:	89 c6                	mov    %eax,%esi
  switch(stat){
     c7d:	8d 40 ff             	lea    -0x1(%eax),%eax
     c80:	83 f8 04             	cmp    $0x4,%eax
     c83:	0f 86 d7 00 00 00    	jbe    d60 <test_8+0x1d0>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     c89:	68 98 17 00 00       	push   $0x1798
     c8e:	53                   	push   %ebx
     c8f:	68 7c 1a 00 00       	push   $0x1a7c
     c94:	6a 01                	push   $0x1
     c96:	e8 d5 07 00 00       	call   1470 <printf>
     c9b:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     c9e:	83 ec 08             	sub    $0x8,%esp
     ca1:	68 a0 1a 00 00       	push   $0x1aa0
     ca6:	6a 01                	push   $0x1
     ca8:	e8 c3 07 00 00       	call   1470 <printf>
     cad:	83 c4 10             	add    $0x10,%esp
  sleep(100);
     cb0:	83 ec 0c             	sub    $0xc,%esp
     cb3:	6a 64                	push   $0x64
     cb5:	e8 b9 06 00 00       	call   1373 <sleep>
  cont(pid);
     cba:	89 1c 24             	mov    %ebx,(%esp)
     cbd:	e8 f9 06 00 00       	call   13bb <cont>
  sleep(100);
     cc2:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     cc9:	e8 a5 06 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     cce:	89 1c 24             	mov    %ebx,(%esp)
     cd1:	e8 c5 06 00 00       	call   139b <pstat>
     cd6:	83 c4 10             	add    $0x10,%esp
     cd9:	89 c6                	mov    %eax,%esi
  switch(stat){
     cdb:	8d 40 ff             	lea    -0x1(%eax),%eax
     cde:	83 f8 04             	cmp    $0x4,%eax
     ce1:	0f 86 b9 00 00 00    	jbe    da0 <test_8+0x210>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     ce7:	68 98 17 00 00       	push   $0x1798
     cec:	53                   	push   %ebx
     ced:	68 7c 1a 00 00       	push   $0x1a7c
     cf2:	6a 01                	push   $0x1
     cf4:	e8 77 07 00 00       	call   1470 <printf>
     cf9:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     cfc:	83 ec 08             	sub    $0x8,%esp
     cff:	68 a0 1a 00 00       	push   $0x1aa0
     d04:	6a 01                	push   $0x1
     d06:	e8 65 07 00 00       	call   1470 <printf>
     d0b:	83 c4 10             	add    $0x10,%esp
  kill(pid);
     d0e:	83 ec 0c             	sub    $0xc,%esp
     d11:	53                   	push   %ebx
     d12:	e8 fc 05 00 00       	call   1313 <kill>
  printf(1,"\n\n\n");
     d17:	58                   	pop    %eax
     d18:	5a                   	pop    %edx
     d19:	68 d6 1a 00 00       	push   $0x1ad6
     d1e:	6a 01                	push   $0x1
     d20:	e8 4b 07 00 00       	call   1470 <printf>
}
     d25:	83 c4 10             	add    $0x10,%esp
     d28:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d2b:	5b                   	pop    %ebx
     d2c:	5e                   	pop    %esi
     d2d:	5d                   	pop    %ebp
     d2e:	c3                   	ret
     d2f:	90                   	nop
  printf(1, "PID %d is in state %s\n", pid, statstring);
     d30:	68 98 17 00 00       	push   $0x1798
     d35:	53                   	push   %ebx
     d36:	68 7c 1a 00 00       	push   $0x1a7c
     d3b:	6a 01                	push   $0x1
     d3d:	e8 2e 07 00 00       	call   1470 <printf>
     d42:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     d45:	83 ec 08             	sub    $0x8,%esp
     d48:	68 a0 1a 00 00       	push   $0x1aa0
     d4d:	6a 01                	push   $0x1
     d4f:	e8 1c 07 00 00       	call   1470 <printf>
     d54:	83 c4 10             	add    $0x10,%esp
     d57:	e9 f6 fe ff ff       	jmp    c52 <test_8+0xc2>
     d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "PID %d is in state %s\n", pid, statstring);
     d60:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     d67:	53                   	push   %ebx
     d68:	68 7c 1a 00 00       	push   $0x1a7c
     d6d:	6a 01                	push   $0x1
     d6f:	e8 fc 06 00 00       	call   1470 <printf>
  if(stat == expected){
     d74:	83 c4 10             	add    $0x10,%esp
     d77:	83 fe 05             	cmp    $0x5,%esi
     d7a:	0f 85 1e ff ff ff    	jne    c9e <test_8+0x10e>
    printf(1, "Test Passed\n");
     d80:	83 ec 08             	sub    $0x8,%esp
     d83:	68 93 1a 00 00       	push   $0x1a93
     d88:	6a 01                	push   $0x1
     d8a:	e8 e1 06 00 00       	call   1470 <printf>
  return 0;
     d8f:	83 c4 10             	add    $0x10,%esp
     d92:	e9 19 ff ff ff       	jmp    cb0 <test_8+0x120>
     d97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d9e:	66 90                	xchg   %ax,%ax
  printf(1, "PID %d is in state %s\n", pid, statstring);
     da0:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     da7:	53                   	push   %ebx
     da8:	68 7c 1a 00 00       	push   $0x1a7c
     dad:	6a 01                	push   $0x1
     daf:	e8 bc 06 00 00       	call   1470 <printf>
  if(stat == expected){
     db4:	83 c4 10             	add    $0x10,%esp
     db7:	83 fe 01             	cmp    $0x1,%esi
     dba:	0f 85 3c ff ff ff    	jne    cfc <test_8+0x16c>
    printf(1, "Test Passed\n");
     dc0:	83 ec 08             	sub    $0x8,%esp
     dc3:	68 93 1a 00 00       	push   $0x1a93
     dc8:	6a 01                	push   $0x1
     dca:	e8 a1 06 00 00       	call   1470 <printf>
  return 0;
     dcf:	83 c4 10             	add    $0x10,%esp
     dd2:	e9 37 ff ff ff       	jmp    d0e <test_8+0x17e>
    char *args[] = {"mask", "5", 0};
     dd7:	31 c9                	xor    %ecx,%ecx
    exec("mask", args); 
     dd9:	8d 45 ec             	lea    -0x14(%ebp),%eax
    char *args[] = {"mask", "5", 0};
     ddc:	c7 45 ec da 1a 00 00 	movl   $0x1ada,-0x14(%ebp)
     de3:	89 4d f4             	mov    %ecx,-0xc(%ebp)
     de6:	c7 45 f0 ea 1a 00 00 	movl   $0x1aea,-0x10(%ebp)
    exec("mask", args); 
     ded:	53                   	push   %ebx
     dee:	53                   	push   %ebx
     def:	50                   	push   %eax
     df0:	68 da 1a 00 00       	push   $0x1ada
     df5:	e8 21 05 00 00       	call   131b <exec>
    exit();
     dfa:	e8 e4 04 00 00       	call   12e3 <exit>
     dff:	90                   	nop

00000e00 <test_9>:
test_9(void){
     e00:	55                   	push   %ebp
     e01:	89 e5                	mov    %esp,%ebp
     e03:	56                   	push   %esi
     e04:	53                   	push   %ebx
     e05:	83 ec 18             	sub    $0x18,%esp
  printf(1, "######################################\n");
     e08:	68 bc 17 00 00       	push   $0x17bc
     e0d:	6a 01                	push   $0x1
     e0f:	e8 5c 06 00 00       	call   1470 <printf>
  printf(1, "sig_test: Starting test %d\n", test_n);
     e14:	83 c4 0c             	add    $0xc,%esp
     e17:	6a 09                	push   $0x9
     e19:	68 ad 1a 00 00       	push   $0x1aad
     e1e:	6a 01                	push   $0x1
     e20:	e8 4b 06 00 00       	call   1470 <printf>
  printf(1, "Test %d: %s\n", test_n, text);
     e25:	68 08 1a 00 00       	push   $0x1a08
     e2a:	6a 09                	push   $0x9
     e2c:	68 c9 1a 00 00       	push   $0x1ac9
     e31:	6a 01                	push   $0x1
     e33:	e8 38 06 00 00       	call   1470 <printf>
  printf(1, "######################################\n\n\n");
     e38:	83 c4 18             	add    $0x18,%esp
     e3b:	68 e4 17 00 00       	push   $0x17e4
     e40:	6a 01                	push   $0x1
     e42:	e8 29 06 00 00       	call   1470 <printf>
  pid = fork();
     e47:	e8 8f 04 00 00       	call   12db <fork>
  if(pid == 0){
     e4c:	83 c4 10             	add    $0x10,%esp
     e4f:	85 c0                	test   %eax,%eax
     e51:	0f 84 aa 00 00 00    	je     f01 <test_9+0x101>
  sleep(100);
     e57:	83 ec 0c             	sub    $0xc,%esp
     e5a:	89 c3                	mov    %eax,%ebx
     e5c:	6a 64                	push   $0x64
     e5e:	e8 10 05 00 00       	call   1373 <sleep>
  sleep(100);
     e63:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     e6a:	e8 04 05 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     e6f:	89 1c 24             	mov    %ebx,(%esp)
     e72:	e8 24 05 00 00       	call   139b <pstat>
     e77:	83 c4 10             	add    $0x10,%esp
     e7a:	89 c6                	mov    %eax,%esi
  switch(stat){
     e7c:	8d 40 ff             	lea    -0x1(%eax),%eax
     e7f:	83 f8 04             	cmp    $0x4,%eax
     e82:	77 54                	ja     ed8 <test_9+0xd8>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     e84:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     e8b:	53                   	push   %ebx
     e8c:	68 7c 1a 00 00       	push   $0x1a7c
     e91:	6a 01                	push   $0x1
     e93:	e8 d8 05 00 00       	call   1470 <printf>
  if(stat == expected){
     e98:	83 c4 10             	add    $0x10,%esp
     e9b:	83 fe 03             	cmp    $0x3,%esi
     e9e:	75 4d                	jne    eed <test_9+0xed>
    printf(1, "Test Passed\n");
     ea0:	83 ec 08             	sub    $0x8,%esp
     ea3:	68 93 1a 00 00       	push   $0x1a93
     ea8:	6a 01                	push   $0x1
     eaa:	e8 c1 05 00 00       	call   1470 <printf>
  return 0;
     eaf:	83 c4 10             	add    $0x10,%esp
  kill(pid);
     eb2:	83 ec 0c             	sub    $0xc,%esp
     eb5:	53                   	push   %ebx
     eb6:	e8 58 04 00 00       	call   1313 <kill>
  printf(1,"\n\n\n");
     ebb:	58                   	pop    %eax
     ebc:	5a                   	pop    %edx
     ebd:	68 d6 1a 00 00       	push   $0x1ad6
     ec2:	6a 01                	push   $0x1
     ec4:	e8 a7 05 00 00       	call   1470 <printf>
}
     ec9:	83 c4 10             	add    $0x10,%esp
     ecc:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ecf:	5b                   	pop    %ebx
     ed0:	5e                   	pop    %esi
     ed1:	5d                   	pop    %ebp
     ed2:	c3                   	ret
     ed3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ed7:	90                   	nop
  printf(1, "PID %d is in state %s\n", pid, statstring);
     ed8:	68 98 17 00 00       	push   $0x1798
     edd:	53                   	push   %ebx
     ede:	68 7c 1a 00 00       	push   $0x1a7c
     ee3:	6a 01                	push   $0x1
     ee5:	e8 86 05 00 00       	call   1470 <printf>
     eea:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
     eed:	83 ec 08             	sub    $0x8,%esp
     ef0:	68 a0 1a 00 00       	push   $0x1aa0
     ef5:	6a 01                	push   $0x1
     ef7:	e8 74 05 00 00       	call   1470 <printf>
     efc:	83 c4 10             	add    $0x10,%esp
     eff:	eb b1                	jmp    eb2 <test_9+0xb2>
    char *args[] = {"mask", "0", 0};
     f01:	31 c9                	xor    %ecx,%ecx
    exec("mask", args); 
     f03:	8d 45 ec             	lea    -0x14(%ebp),%eax
    char *args[] = {"mask", "0", 0};
     f06:	c7 45 ec da 1a 00 00 	movl   $0x1ada,-0x14(%ebp)
     f0d:	89 4d f4             	mov    %ecx,-0xc(%ebp)
     f10:	c7 45 f0 df 1a 00 00 	movl   $0x1adf,-0x10(%ebp)
    exec("mask", args); 
     f17:	53                   	push   %ebx
     f18:	53                   	push   %ebx
     f19:	50                   	push   %eax
     f1a:	68 da 1a 00 00       	push   $0x1ada
     f1f:	e8 f7 03 00 00       	call   131b <exec>
    exit();
     f24:	e8 ba 03 00 00       	call   12e3 <exit>
     f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f30 <test_10>:
test_10(void){
     f30:	55                   	push   %ebp
     f31:	89 e5                	mov    %esp,%ebp
     f33:	56                   	push   %esi
     f34:	53                   	push   %ebx
     f35:	83 ec 18             	sub    $0x18,%esp
  printf(1, "######################################\n");
     f38:	68 bc 17 00 00       	push   $0x17bc
     f3d:	6a 01                	push   $0x1
     f3f:	e8 2c 05 00 00       	call   1470 <printf>
  printf(1, "sig_test: Starting test %d\n", test_n);
     f44:	83 c4 0c             	add    $0xc,%esp
     f47:	6a 0a                	push   $0xa
     f49:	68 ad 1a 00 00       	push   $0x1aad
     f4e:	6a 01                	push   $0x1
     f50:	e8 1b 05 00 00       	call   1470 <printf>
  printf(1, "Test %d: %s\n", test_n, text);
     f55:	68 40 1a 00 00       	push   $0x1a40
     f5a:	6a 0a                	push   $0xa
     f5c:	68 c9 1a 00 00       	push   $0x1ac9
     f61:	6a 01                	push   $0x1
     f63:	e8 08 05 00 00       	call   1470 <printf>
  printf(1, "######################################\n\n\n");
     f68:	83 c4 18             	add    $0x18,%esp
     f6b:	68 e4 17 00 00       	push   $0x17e4
     f70:	6a 01                	push   $0x1
     f72:	e8 f9 04 00 00       	call   1470 <printf>
  pid = fork();
     f77:	e8 5f 03 00 00       	call   12db <fork>
  if(pid == 0){
     f7c:	83 c4 10             	add    $0x10,%esp
     f7f:	85 c0                	test   %eax,%eax
     f81:	0f 84 aa 00 00 00    	je     1031 <test_10+0x101>
  sleep(100);
     f87:	83 ec 0c             	sub    $0xc,%esp
     f8a:	89 c3                	mov    %eax,%ebx
     f8c:	6a 64                	push   $0x64
     f8e:	e8 e0 03 00 00       	call   1373 <sleep>
  sleep(100);
     f93:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     f9a:	e8 d4 03 00 00       	call   1373 <sleep>
  stat = pstat(pid);
     f9f:	89 1c 24             	mov    %ebx,(%esp)
     fa2:	e8 f4 03 00 00       	call   139b <pstat>
     fa7:	83 c4 10             	add    $0x10,%esp
     faa:	89 c6                	mov    %eax,%esi
  switch(stat){
     fac:	8d 40 ff             	lea    -0x1(%eax),%eax
     faf:	83 f8 04             	cmp    $0x4,%eax
     fb2:	77 54                	ja     1008 <test_10+0xd8>
  printf(1, "PID %d is in state %s\n", pid, statstring);
     fb4:	ff 34 85 14 1b 00 00 	push   0x1b14(,%eax,4)
     fbb:	53                   	push   %ebx
     fbc:	68 7c 1a 00 00       	push   $0x1a7c
     fc1:	6a 01                	push   $0x1
     fc3:	e8 a8 04 00 00       	call   1470 <printf>
  if(stat == expected){
     fc8:	83 c4 10             	add    $0x10,%esp
     fcb:	83 fe 01             	cmp    $0x1,%esi
     fce:	75 4d                	jne    101d <test_10+0xed>
    printf(1, "Test Passed\n");
     fd0:	83 ec 08             	sub    $0x8,%esp
     fd3:	68 93 1a 00 00       	push   $0x1a93
     fd8:	6a 01                	push   $0x1
     fda:	e8 91 04 00 00       	call   1470 <printf>
  return 0;
     fdf:	83 c4 10             	add    $0x10,%esp
  kill(pid);
     fe2:	83 ec 0c             	sub    $0xc,%esp
     fe5:	53                   	push   %ebx
     fe6:	e8 28 03 00 00       	call   1313 <kill>
  printf(1,"\n\n\n");
     feb:	58                   	pop    %eax
     fec:	5a                   	pop    %edx
     fed:	68 d6 1a 00 00       	push   $0x1ad6
     ff2:	6a 01                	push   $0x1
     ff4:	e8 77 04 00 00       	call   1470 <printf>
}
     ff9:	83 c4 10             	add    $0x10,%esp
     ffc:	8d 65 f8             	lea    -0x8(%ebp),%esp
     fff:	5b                   	pop    %ebx
    1000:	5e                   	pop    %esi
    1001:	5d                   	pop    %ebp
    1002:	c3                   	ret
    1003:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1007:	90                   	nop
  printf(1, "PID %d is in state %s\n", pid, statstring);
    1008:	68 98 17 00 00       	push   $0x1798
    100d:	53                   	push   %ebx
    100e:	68 7c 1a 00 00       	push   $0x1a7c
    1013:	6a 01                	push   $0x1
    1015:	e8 56 04 00 00       	call   1470 <printf>
    101a:	83 c4 10             	add    $0x10,%esp
    printf(1, "Test Failed\n");
    101d:	83 ec 08             	sub    $0x8,%esp
    1020:	68 a0 1a 00 00       	push   $0x1aa0
    1025:	6a 01                	push   $0x1
    1027:	e8 44 04 00 00       	call   1470 <printf>
    102c:	83 c4 10             	add    $0x10,%esp
    102f:	eb b1                	jmp    fe2 <test_10+0xb2>
    char *args[] = {"mask", "4", 0};
    1031:	31 c9                	xor    %ecx,%ecx
    exec("mask", args); 
    1033:	8d 45 ec             	lea    -0x14(%ebp),%eax
    char *args[] = {"mask", "4", 0};
    1036:	c7 45 ec da 1a 00 00 	movl   $0x1ada,-0x14(%ebp)
    103d:	89 4d f4             	mov    %ecx,-0xc(%ebp)
    1040:	c7 45 f0 ec 1a 00 00 	movl   $0x1aec,-0x10(%ebp)
    exec("mask", args); 
    1047:	53                   	push   %ebx
    1048:	53                   	push   %ebx
    1049:	50                   	push   %eax
    104a:	68 da 1a 00 00       	push   $0x1ada
    104f:	e8 c7 02 00 00       	call   131b <exec>
    exit();
    1054:	e8 8a 02 00 00       	call   12e3 <exit>
    1059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001060 <sig_test>:
{
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	83 ec 08             	sub    $0x8,%esp
  test_1();
    1066:	e8 95 f0 ff ff       	call   100 <test_1>
  test_2();
    106b:	e8 d0 f1 ff ff       	call   240 <test_2>
  test_3();
    1070:	e8 0b f3 ff ff       	call   380 <test_3>
  test_4();
    1075:	e8 46 f4 ff ff       	call   4c0 <test_4>
  test_5();
    107a:	e8 81 f5 ff ff       	call   600 <test_5>
  test_6();
    107f:	e8 6c f7 ff ff       	call   7f0 <test_6>
  test_7();
    1084:	e8 37 f9 ff ff       	call   9c0 <test_7>
  test_8();
    1089:	e8 02 fb ff ff       	call   b90 <test_8>
  test_9();
    108e:	e8 6d fd ff ff       	call   e00 <test_9>
}
    1093:	c9                   	leave
  test_10();
    1094:	e9 97 fe ff ff       	jmp    f30 <test_10>
    1099:	66 90                	xchg   %ax,%ax
    109b:	66 90                	xchg   %ax,%ax
    109d:	66 90                	xchg   %ax,%ax
    109f:	90                   	nop

000010a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10a1:	31 c0                	xor    %eax,%eax
{
    10a3:	89 e5                	mov    %esp,%ebp
    10a5:	53                   	push   %ebx
    10a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    10b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    10b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    10b7:	83 c0 01             	add    $0x1,%eax
    10ba:	84 d2                	test   %dl,%dl
    10bc:	75 f2                	jne    10b0 <strcpy+0x10>
    ;
  return os;
}
    10be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10c1:	89 c8                	mov    %ecx,%eax
    10c3:	c9                   	leave
    10c4:	c3                   	ret
    10c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000010d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
    10d3:	53                   	push   %ebx
    10d4:	8b 55 08             	mov    0x8(%ebp),%edx
    10d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    10da:	0f b6 02             	movzbl (%edx),%eax
    10dd:	84 c0                	test   %al,%al
    10df:	75 17                	jne    10f8 <strcmp+0x28>
    10e1:	eb 3a                	jmp    111d <strcmp+0x4d>
    10e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10e7:	90                   	nop
    10e8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    10ec:	83 c2 01             	add    $0x1,%edx
    10ef:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    10f2:	84 c0                	test   %al,%al
    10f4:	74 1a                	je     1110 <strcmp+0x40>
    p++, q++;
    10f6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    10f8:	0f b6 19             	movzbl (%ecx),%ebx
    10fb:	38 c3                	cmp    %al,%bl
    10fd:	74 e9                	je     10e8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    10ff:	29 d8                	sub    %ebx,%eax
}
    1101:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1104:	c9                   	leave
    1105:	c3                   	ret
    1106:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    110d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    1110:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    1114:	31 c0                	xor    %eax,%eax
    1116:	29 d8                	sub    %ebx,%eax
}
    1118:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    111b:	c9                   	leave
    111c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
    111d:	0f b6 19             	movzbl (%ecx),%ebx
    1120:	31 c0                	xor    %eax,%eax
    1122:	eb db                	jmp    10ff <strcmp+0x2f>
    1124:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    112b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    112f:	90                   	nop

00001130 <strlen>:

uint
strlen(char *s)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    1136:	80 3a 00             	cmpb   $0x0,(%edx)
    1139:	74 15                	je     1150 <strlen+0x20>
    113b:	31 c0                	xor    %eax,%eax
    113d:	8d 76 00             	lea    0x0(%esi),%esi
    1140:	83 c0 01             	add    $0x1,%eax
    1143:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    1147:	89 c1                	mov    %eax,%ecx
    1149:	75 f5                	jne    1140 <strlen+0x10>
    ;
  return n;
}
    114b:	89 c8                	mov    %ecx,%eax
    114d:	5d                   	pop    %ebp
    114e:	c3                   	ret
    114f:	90                   	nop
  for(n = 0; s[n]; n++)
    1150:	31 c9                	xor    %ecx,%ecx
}
    1152:	5d                   	pop    %ebp
    1153:	89 c8                	mov    %ecx,%eax
    1155:	c3                   	ret
    1156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    115d:	8d 76 00             	lea    0x0(%esi),%esi

00001160 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
    1163:	57                   	push   %edi
    1164:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1167:	8b 4d 10             	mov    0x10(%ebp),%ecx
    116a:	8b 45 0c             	mov    0xc(%ebp),%eax
    116d:	89 d7                	mov    %edx,%edi
    116f:	fc                   	cld
    1170:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1172:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1175:	89 d0                	mov    %edx,%eax
    1177:	c9                   	leave
    1178:	c3                   	ret
    1179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001180 <strchr>:

char*
strchr(const char *s, char c)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	8b 45 08             	mov    0x8(%ebp),%eax
    1186:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    118a:	0f b6 10             	movzbl (%eax),%edx
    118d:	84 d2                	test   %dl,%dl
    118f:	75 12                	jne    11a3 <strchr+0x23>
    1191:	eb 1d                	jmp    11b0 <strchr+0x30>
    1193:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1197:	90                   	nop
    1198:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    119c:	83 c0 01             	add    $0x1,%eax
    119f:	84 d2                	test   %dl,%dl
    11a1:	74 0d                	je     11b0 <strchr+0x30>
    if(*s == c)
    11a3:	38 d1                	cmp    %dl,%cl
    11a5:	75 f1                	jne    1198 <strchr+0x18>
      return (char*)s;
  return 0;
}
    11a7:	5d                   	pop    %ebp
    11a8:	c3                   	ret
    11a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    11b0:	31 c0                	xor    %eax,%eax
}
    11b2:	5d                   	pop    %ebp
    11b3:	c3                   	ret
    11b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11bf:	90                   	nop

000011c0 <gets>:

char*
gets(char *buf, int max)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	57                   	push   %edi
    11c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    11c5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
    11c8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    11c9:	31 db                	xor    %ebx,%ebx
{
    11cb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    11ce:	eb 27                	jmp    11f7 <gets+0x37>
    cc = read(0, &c, 1);
    11d0:	83 ec 04             	sub    $0x4,%esp
    11d3:	6a 01                	push   $0x1
    11d5:	56                   	push   %esi
    11d6:	6a 00                	push   $0x0
    11d8:	e8 1e 01 00 00       	call   12fb <read>
    if(cc < 1)
    11dd:	83 c4 10             	add    $0x10,%esp
    11e0:	85 c0                	test   %eax,%eax
    11e2:	7e 1d                	jle    1201 <gets+0x41>
      break;
    buf[i++] = c;
    11e4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    11e8:	8b 55 08             	mov    0x8(%ebp),%edx
    11eb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    11ef:	3c 0a                	cmp    $0xa,%al
    11f1:	74 10                	je     1203 <gets+0x43>
    11f3:	3c 0d                	cmp    $0xd,%al
    11f5:	74 0c                	je     1203 <gets+0x43>
  for(i=0; i+1 < max; ){
    11f7:	89 df                	mov    %ebx,%edi
    11f9:	83 c3 01             	add    $0x1,%ebx
    11fc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11ff:	7c cf                	jl     11d0 <gets+0x10>
    1201:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
    1203:	8b 45 08             	mov    0x8(%ebp),%eax
    1206:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
    120a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    120d:	5b                   	pop    %ebx
    120e:	5e                   	pop    %esi
    120f:	5f                   	pop    %edi
    1210:	5d                   	pop    %ebp
    1211:	c3                   	ret
    1212:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001220 <stat>:

int
stat(char *n, struct stat *st)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	56                   	push   %esi
    1224:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1225:	83 ec 08             	sub    $0x8,%esp
    1228:	6a 00                	push   $0x0
    122a:	ff 75 08             	push   0x8(%ebp)
    122d:	e8 f1 00 00 00       	call   1323 <open>
  if(fd < 0)
    1232:	83 c4 10             	add    $0x10,%esp
    1235:	85 c0                	test   %eax,%eax
    1237:	78 27                	js     1260 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1239:	83 ec 08             	sub    $0x8,%esp
    123c:	ff 75 0c             	push   0xc(%ebp)
    123f:	89 c3                	mov    %eax,%ebx
    1241:	50                   	push   %eax
    1242:	e8 f4 00 00 00       	call   133b <fstat>
  close(fd);
    1247:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    124a:	89 c6                	mov    %eax,%esi
  close(fd);
    124c:	e8 ba 00 00 00       	call   130b <close>
  return r;
    1251:	83 c4 10             	add    $0x10,%esp
}
    1254:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1257:	89 f0                	mov    %esi,%eax
    1259:	5b                   	pop    %ebx
    125a:	5e                   	pop    %esi
    125b:	5d                   	pop    %ebp
    125c:	c3                   	ret
    125d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1260:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1265:	eb ed                	jmp    1254 <stat+0x34>
    1267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    126e:	66 90                	xchg   %ax,%ax

00001270 <atoi>:

int
atoi(const char *s)
{
    1270:	55                   	push   %ebp
    1271:	89 e5                	mov    %esp,%ebp
    1273:	53                   	push   %ebx
    1274:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1277:	0f be 02             	movsbl (%edx),%eax
    127a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    127d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1280:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1285:	77 1e                	ja     12a5 <atoi+0x35>
    1287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    128e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    1290:	83 c2 01             	add    $0x1,%edx
    1293:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1296:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    129a:	0f be 02             	movsbl (%edx),%eax
    129d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    12a0:	80 fb 09             	cmp    $0x9,%bl
    12a3:	76 eb                	jbe    1290 <atoi+0x20>
  return n;
}
    12a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12a8:	89 c8                	mov    %ecx,%eax
    12aa:	c9                   	leave
    12ab:	c3                   	ret
    12ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000012b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12b0:	55                   	push   %ebp
    12b1:	89 e5                	mov    %esp,%ebp
    12b3:	57                   	push   %edi
    12b4:	56                   	push   %esi
    12b5:	8b 45 10             	mov    0x10(%ebp),%eax
    12b8:	8b 55 08             	mov    0x8(%ebp),%edx
    12bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12be:	85 c0                	test   %eax,%eax
    12c0:	7e 13                	jle    12d5 <memmove+0x25>
    12c2:	01 d0                	add    %edx,%eax
  dst = vdst;
    12c4:	89 d7                	mov    %edx,%edi
    12c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12cd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    12d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    12d1:	39 f8                	cmp    %edi,%eax
    12d3:	75 fb                	jne    12d0 <memmove+0x20>
  return vdst;
}
    12d5:	5e                   	pop    %esi
    12d6:	89 d0                	mov    %edx,%eax
    12d8:	5f                   	pop    %edi
    12d9:	5d                   	pop    %ebp
    12da:	c3                   	ret

000012db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12db:	b8 01 00 00 00       	mov    $0x1,%eax
    12e0:	cd 40                	int    $0x40
    12e2:	c3                   	ret

000012e3 <exit>:
SYSCALL(exit)
    12e3:	b8 02 00 00 00       	mov    $0x2,%eax
    12e8:	cd 40                	int    $0x40
    12ea:	c3                   	ret

000012eb <wait>:
SYSCALL(wait)
    12eb:	b8 03 00 00 00       	mov    $0x3,%eax
    12f0:	cd 40                	int    $0x40
    12f2:	c3                   	ret

000012f3 <pipe>:
SYSCALL(pipe)
    12f3:	b8 04 00 00 00       	mov    $0x4,%eax
    12f8:	cd 40                	int    $0x40
    12fa:	c3                   	ret

000012fb <read>:
SYSCALL(read)
    12fb:	b8 05 00 00 00       	mov    $0x5,%eax
    1300:	cd 40                	int    $0x40
    1302:	c3                   	ret

00001303 <write>:
SYSCALL(write)
    1303:	b8 10 00 00 00       	mov    $0x10,%eax
    1308:	cd 40                	int    $0x40
    130a:	c3                   	ret

0000130b <close>:
SYSCALL(close)
    130b:	b8 15 00 00 00       	mov    $0x15,%eax
    1310:	cd 40                	int    $0x40
    1312:	c3                   	ret

00001313 <kill>:
SYSCALL(kill)
    1313:	b8 06 00 00 00       	mov    $0x6,%eax
    1318:	cd 40                	int    $0x40
    131a:	c3                   	ret

0000131b <exec>:
SYSCALL(exec)
    131b:	b8 07 00 00 00       	mov    $0x7,%eax
    1320:	cd 40                	int    $0x40
    1322:	c3                   	ret

00001323 <open>:
SYSCALL(open)
    1323:	b8 0f 00 00 00       	mov    $0xf,%eax
    1328:	cd 40                	int    $0x40
    132a:	c3                   	ret

0000132b <mknod>:
SYSCALL(mknod)
    132b:	b8 11 00 00 00       	mov    $0x11,%eax
    1330:	cd 40                	int    $0x40
    1332:	c3                   	ret

00001333 <unlink>:
SYSCALL(unlink)
    1333:	b8 12 00 00 00       	mov    $0x12,%eax
    1338:	cd 40                	int    $0x40
    133a:	c3                   	ret

0000133b <fstat>:
SYSCALL(fstat)
    133b:	b8 08 00 00 00       	mov    $0x8,%eax
    1340:	cd 40                	int    $0x40
    1342:	c3                   	ret

00001343 <link>:
SYSCALL(link)
    1343:	b8 13 00 00 00       	mov    $0x13,%eax
    1348:	cd 40                	int    $0x40
    134a:	c3                   	ret

0000134b <mkdir>:
SYSCALL(mkdir)
    134b:	b8 14 00 00 00       	mov    $0x14,%eax
    1350:	cd 40                	int    $0x40
    1352:	c3                   	ret

00001353 <chdir>:
SYSCALL(chdir)
    1353:	b8 09 00 00 00       	mov    $0x9,%eax
    1358:	cd 40                	int    $0x40
    135a:	c3                   	ret

0000135b <dup>:
SYSCALL(dup)
    135b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1360:	cd 40                	int    $0x40
    1362:	c3                   	ret

00001363 <getpid>:
SYSCALL(getpid)
    1363:	b8 0b 00 00 00       	mov    $0xb,%eax
    1368:	cd 40                	int    $0x40
    136a:	c3                   	ret

0000136b <sbrk>:
SYSCALL(sbrk)
    136b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1370:	cd 40                	int    $0x40
    1372:	c3                   	ret

00001373 <sleep>:
SYSCALL(sleep)
    1373:	b8 0d 00 00 00       	mov    $0xd,%eax
    1378:	cd 40                	int    $0x40
    137a:	c3                   	ret

0000137b <uptime>:
SYSCALL(uptime)
    137b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1380:	cd 40                	int    $0x40
    1382:	c3                   	ret

00001383 <shutdown>:
SYSCALL(shutdown)
    1383:	b8 16 00 00 00       	mov    $0x16,%eax
    1388:	cd 40                	int    $0x40
    138a:	c3                   	ret

0000138b <cps>:
SYSCALL(cps)
    138b:	b8 17 00 00 00       	mov    $0x17,%eax
    1390:	cd 40                	int    $0x40
    1392:	c3                   	ret

00001393 <chpr>:
SYSCALL(chpr)
    1393:	b8 18 00 00 00       	mov    $0x18,%eax
    1398:	cd 40                	int    $0x40
    139a:	c3                   	ret

0000139b <pstat>:
SYSCALL(pstat)
    139b:	b8 19 00 00 00       	mov    $0x19,%eax
    13a0:	cd 40                	int    $0x40
    13a2:	c3                   	ret

000013a3 <term>:
SYSCALL(term)
    13a3:	b8 1a 00 00 00       	mov    $0x1a,%eax
    13a8:	cd 40                	int    $0x40
    13aa:	c3                   	ret

000013ab <mask>:
SYSCALL(mask)
    13ab:	b8 1b 00 00 00       	mov    $0x1b,%eax
    13b0:	cd 40                	int    $0x40
    13b2:	c3                   	ret

000013b3 <stop>:
SYSCALL(stop)
    13b3:	b8 1c 00 00 00       	mov    $0x1c,%eax
    13b8:	cd 40                	int    $0x40
    13ba:	c3                   	ret

000013bb <cont>:
SYSCALL(cont)
    13bb:	b8 1d 00 00 00       	mov    $0x1d,%eax
    13c0:	cd 40                	int    $0x40
    13c2:	c3                   	ret
    13c3:	66 90                	xchg   %ax,%ax
    13c5:	66 90                	xchg   %ax,%ax
    13c7:	66 90                	xchg   %ax,%ax
    13c9:	66 90                	xchg   %ax,%ax
    13cb:	66 90                	xchg   %ax,%ax
    13cd:	66 90                	xchg   %ax,%ax
    13cf:	90                   	nop

000013d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	57                   	push   %edi
    13d4:	56                   	push   %esi
    13d5:	53                   	push   %ebx
    13d6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    13d8:	89 d1                	mov    %edx,%ecx
{
    13da:	83 ec 3c             	sub    $0x3c,%esp
    13dd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
    13e0:	85 d2                	test   %edx,%edx
    13e2:	0f 89 80 00 00 00    	jns    1468 <printint+0x98>
    13e8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    13ec:	74 7a                	je     1468 <printint+0x98>
    x = -xx;
    13ee:	f7 d9                	neg    %ecx
    neg = 1;
    13f0:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
    13f5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    13f8:	31 f6                	xor    %esi,%esi
    13fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1400:	89 c8                	mov    %ecx,%eax
    1402:	31 d2                	xor    %edx,%edx
    1404:	89 f7                	mov    %esi,%edi
    1406:	f7 f3                	div    %ebx
    1408:	8d 76 01             	lea    0x1(%esi),%esi
    140b:	0f b6 92 88 1b 00 00 	movzbl 0x1b88(%edx),%edx
    1412:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
    1416:	89 ca                	mov    %ecx,%edx
    1418:	89 c1                	mov    %eax,%ecx
    141a:	39 da                	cmp    %ebx,%edx
    141c:	73 e2                	jae    1400 <printint+0x30>
  if(neg)
    141e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1421:	85 c0                	test   %eax,%eax
    1423:	74 07                	je     142c <printint+0x5c>
    buf[i++] = '-';
    1425:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
    142a:	89 f7                	mov    %esi,%edi
    142c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    142f:	8b 75 c0             	mov    -0x40(%ebp),%esi
    1432:	01 df                	add    %ebx,%edi
    1434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(--i >= 0)
    putc(fd, buf[i]);
    1438:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
    143b:	83 ec 04             	sub    $0x4,%esp
    143e:	88 45 d7             	mov    %al,-0x29(%ebp)
    1441:	8d 45 d7             	lea    -0x29(%ebp),%eax
    1444:	6a 01                	push   $0x1
    1446:	50                   	push   %eax
    1447:	56                   	push   %esi
    1448:	e8 b6 fe ff ff       	call   1303 <write>
  while(--i >= 0)
    144d:	89 f8                	mov    %edi,%eax
    144f:	83 c4 10             	add    $0x10,%esp
    1452:	83 ef 01             	sub    $0x1,%edi
    1455:	39 d8                	cmp    %ebx,%eax
    1457:	75 df                	jne    1438 <printint+0x68>
}
    1459:	8d 65 f4             	lea    -0xc(%ebp),%esp
    145c:	5b                   	pop    %ebx
    145d:	5e                   	pop    %esi
    145e:	5f                   	pop    %edi
    145f:	5d                   	pop    %ebp
    1460:	c3                   	ret
    1461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1468:	31 c0                	xor    %eax,%eax
    146a:	eb 89                	jmp    13f5 <printint+0x25>
    146c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001470 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1470:	55                   	push   %ebp
    1471:	89 e5                	mov    %esp,%ebp
    1473:	57                   	push   %edi
    1474:	56                   	push   %esi
    1475:	53                   	push   %ebx
    1476:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1479:	8b 75 0c             	mov    0xc(%ebp),%esi
{
    147c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
    147f:	0f b6 1e             	movzbl (%esi),%ebx
    1482:	83 c6 01             	add    $0x1,%esi
    1485:	84 db                	test   %bl,%bl
    1487:	74 67                	je     14f0 <printf+0x80>
    1489:	8d 4d 10             	lea    0x10(%ebp),%ecx
    148c:	31 d2                	xor    %edx,%edx
    148e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1491:	eb 34                	jmp    14c7 <printf+0x57>
    1493:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1497:	90                   	nop
    1498:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    149b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    14a0:	83 f8 25             	cmp    $0x25,%eax
    14a3:	74 18                	je     14bd <printf+0x4d>
  write(fd, &c, 1);
    14a5:	83 ec 04             	sub    $0x4,%esp
    14a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    14ab:	88 5d e7             	mov    %bl,-0x19(%ebp)
    14ae:	6a 01                	push   $0x1
    14b0:	50                   	push   %eax
    14b1:	57                   	push   %edi
    14b2:	e8 4c fe ff ff       	call   1303 <write>
    14b7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    14ba:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    14bd:	0f b6 1e             	movzbl (%esi),%ebx
    14c0:	83 c6 01             	add    $0x1,%esi
    14c3:	84 db                	test   %bl,%bl
    14c5:	74 29                	je     14f0 <printf+0x80>
    c = fmt[i] & 0xff;
    14c7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    14ca:	85 d2                	test   %edx,%edx
    14cc:	74 ca                	je     1498 <printf+0x28>
      }
    } else if(state == '%'){
    14ce:	83 fa 25             	cmp    $0x25,%edx
    14d1:	75 ea                	jne    14bd <printf+0x4d>
      if(c == 'd'){
    14d3:	83 f8 25             	cmp    $0x25,%eax
    14d6:	0f 84 24 01 00 00    	je     1600 <printf+0x190>
    14dc:	83 e8 63             	sub    $0x63,%eax
    14df:	83 f8 15             	cmp    $0x15,%eax
    14e2:	77 1c                	ja     1500 <printf+0x90>
    14e4:	ff 24 85 30 1b 00 00 	jmp    *0x1b30(,%eax,4)
    14eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    14ef:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    14f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14f3:	5b                   	pop    %ebx
    14f4:	5e                   	pop    %esi
    14f5:	5f                   	pop    %edi
    14f6:	5d                   	pop    %ebp
    14f7:	c3                   	ret
    14f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14ff:	90                   	nop
  write(fd, &c, 1);
    1500:	83 ec 04             	sub    $0x4,%esp
    1503:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1506:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    150a:	6a 01                	push   $0x1
    150c:	52                   	push   %edx
    150d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    1510:	57                   	push   %edi
    1511:	e8 ed fd ff ff       	call   1303 <write>
    1516:	83 c4 0c             	add    $0xc,%esp
    1519:	88 5d e7             	mov    %bl,-0x19(%ebp)
    151c:	6a 01                	push   $0x1
    151e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1521:	52                   	push   %edx
    1522:	57                   	push   %edi
    1523:	e8 db fd ff ff       	call   1303 <write>
        putc(fd, c);
    1528:	83 c4 10             	add    $0x10,%esp
      state = 0;
    152b:	31 d2                	xor    %edx,%edx
    152d:	eb 8e                	jmp    14bd <printf+0x4d>
    152f:	90                   	nop
        printint(fd, *ap, 16, 0);
    1530:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1533:	83 ec 0c             	sub    $0xc,%esp
    1536:	b9 10 00 00 00       	mov    $0x10,%ecx
    153b:	8b 13                	mov    (%ebx),%edx
    153d:	6a 00                	push   $0x0
    153f:	89 f8                	mov    %edi,%eax
        ap++;
    1541:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
    1544:	e8 87 fe ff ff       	call   13d0 <printint>
        ap++;
    1549:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    154c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    154f:	31 d2                	xor    %edx,%edx
    1551:	e9 67 ff ff ff       	jmp    14bd <printf+0x4d>
    1556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    155d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
    1560:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1563:	8b 18                	mov    (%eax),%ebx
        ap++;
    1565:	83 c0 04             	add    $0x4,%eax
    1568:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    156b:	85 db                	test   %ebx,%ebx
    156d:	0f 84 9d 00 00 00    	je     1610 <printf+0x1a0>
        while(*s != 0){
    1573:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1576:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1578:	84 c0                	test   %al,%al
    157a:	0f 84 3d ff ff ff    	je     14bd <printf+0x4d>
    1580:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1583:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    1586:	89 de                	mov    %ebx,%esi
    1588:	89 d3                	mov    %edx,%ebx
    158a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1590:	83 ec 04             	sub    $0x4,%esp
    1593:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    1596:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1599:	6a 01                	push   $0x1
    159b:	53                   	push   %ebx
    159c:	57                   	push   %edi
    159d:	e8 61 fd ff ff       	call   1303 <write>
        while(*s != 0){
    15a2:	0f b6 06             	movzbl (%esi),%eax
    15a5:	83 c4 10             	add    $0x10,%esp
    15a8:	84 c0                	test   %al,%al
    15aa:	75 e4                	jne    1590 <printf+0x120>
      state = 0;
    15ac:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    15af:	31 d2                	xor    %edx,%edx
    15b1:	e9 07 ff ff ff       	jmp    14bd <printf+0x4d>
    15b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15bd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    15c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    15c3:	83 ec 0c             	sub    $0xc,%esp
    15c6:	b9 0a 00 00 00       	mov    $0xa,%ecx
    15cb:	8b 13                	mov    (%ebx),%edx
    15cd:	6a 01                	push   $0x1
    15cf:	e9 6b ff ff ff       	jmp    153f <printf+0xcf>
    15d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    15d8:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    15db:	83 ec 04             	sub    $0x4,%esp
    15de:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
    15e1:	8b 03                	mov    (%ebx),%eax
        ap++;
    15e3:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
    15e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    15e9:	6a 01                	push   $0x1
    15eb:	52                   	push   %edx
    15ec:	57                   	push   %edi
    15ed:	e8 11 fd ff ff       	call   1303 <write>
        ap++;
    15f2:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    15f5:	83 c4 10             	add    $0x10,%esp
      state = 0;
    15f8:	31 d2                	xor    %edx,%edx
    15fa:	e9 be fe ff ff       	jmp    14bd <printf+0x4d>
    15ff:	90                   	nop
  write(fd, &c, 1);
    1600:	83 ec 04             	sub    $0x4,%esp
    1603:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1606:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1609:	6a 01                	push   $0x1
    160b:	e9 11 ff ff ff       	jmp    1521 <printf+0xb1>
    1610:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    1615:	bb 28 1b 00 00       	mov    $0x1b28,%ebx
    161a:	e9 61 ff ff ff       	jmp    1580 <printf+0x110>
    161f:	90                   	nop

00001620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1621:	a1 7c 20 00 00       	mov    0x207c,%eax
{
    1626:	89 e5                	mov    %esp,%ebp
    1628:	57                   	push   %edi
    1629:	56                   	push   %esi
    162a:	53                   	push   %ebx
    162b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    162e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1638:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    163a:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    163c:	39 ca                	cmp    %ecx,%edx
    163e:	73 30                	jae    1670 <free+0x50>
    1640:	39 c1                	cmp    %eax,%ecx
    1642:	72 04                	jb     1648 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1644:	39 c2                	cmp    %eax,%edx
    1646:	72 f0                	jb     1638 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1648:	8b 73 fc             	mov    -0x4(%ebx),%esi
    164b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    164e:	39 f8                	cmp    %edi,%eax
    1650:	74 2e                	je     1680 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    1652:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1655:	8b 42 04             	mov    0x4(%edx),%eax
    1658:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    165b:	39 f1                	cmp    %esi,%ecx
    165d:	74 38                	je     1697 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    165f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    1661:	5b                   	pop    %ebx
  freep = p;
    1662:	89 15 7c 20 00 00    	mov    %edx,0x207c
}
    1668:	5e                   	pop    %esi
    1669:	5f                   	pop    %edi
    166a:	5d                   	pop    %ebp
    166b:	c3                   	ret
    166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1670:	39 c1                	cmp    %eax,%ecx
    1672:	72 d0                	jb     1644 <free+0x24>
    1674:	eb c2                	jmp    1638 <free+0x18>
    1676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    167d:	8d 76 00             	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
    1680:	03 70 04             	add    0x4(%eax),%esi
    1683:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1686:	8b 02                	mov    (%edx),%eax
    1688:	8b 00                	mov    (%eax),%eax
    168a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    168d:	8b 42 04             	mov    0x4(%edx),%eax
    1690:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1693:	39 f1                	cmp    %esi,%ecx
    1695:	75 c8                	jne    165f <free+0x3f>
    p->s.size += bp->s.size;
    1697:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    169a:	89 15 7c 20 00 00    	mov    %edx,0x207c
    p->s.size += bp->s.size;
    16a0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    16a3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    16a6:	89 0a                	mov    %ecx,(%edx)
}
    16a8:	5b                   	pop    %ebx
    16a9:	5e                   	pop    %esi
    16aa:	5f                   	pop    %edi
    16ab:	5d                   	pop    %ebp
    16ac:	c3                   	ret
    16ad:	8d 76 00             	lea    0x0(%esi),%esi

000016b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    16b0:	55                   	push   %ebp
    16b1:	89 e5                	mov    %esp,%ebp
    16b3:	57                   	push   %edi
    16b4:	56                   	push   %esi
    16b5:	53                   	push   %ebx
    16b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    16bc:	8b 15 7c 20 00 00    	mov    0x207c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16c2:	8d 78 07             	lea    0x7(%eax),%edi
    16c5:	c1 ef 03             	shr    $0x3,%edi
    16c8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    16cb:	85 d2                	test   %edx,%edx
    16cd:	0f 84 8d 00 00 00    	je     1760 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16d3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    16d5:	8b 48 04             	mov    0x4(%eax),%ecx
    16d8:	39 f9                	cmp    %edi,%ecx
    16da:	73 64                	jae    1740 <malloc+0x90>
  if(nu < 4096)
    16dc:	bb 00 10 00 00       	mov    $0x1000,%ebx
    16e1:	39 df                	cmp    %ebx,%edi
    16e3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    16e6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    16ed:	eb 0a                	jmp    16f9 <malloc+0x49>
    16ef:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    16f2:	8b 48 04             	mov    0x4(%eax),%ecx
    16f5:	39 f9                	cmp    %edi,%ecx
    16f7:	73 47                	jae    1740 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    16f9:	89 c2                	mov    %eax,%edx
    16fb:	39 05 7c 20 00 00    	cmp    %eax,0x207c
    1701:	75 ed                	jne    16f0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    1703:	83 ec 0c             	sub    $0xc,%esp
    1706:	56                   	push   %esi
    1707:	e8 5f fc ff ff       	call   136b <sbrk>
  if(p == (char*)-1)
    170c:	83 c4 10             	add    $0x10,%esp
    170f:	83 f8 ff             	cmp    $0xffffffff,%eax
    1712:	74 1c                	je     1730 <malloc+0x80>
  hp->s.size = nu;
    1714:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1717:	83 ec 0c             	sub    $0xc,%esp
    171a:	83 c0 08             	add    $0x8,%eax
    171d:	50                   	push   %eax
    171e:	e8 fd fe ff ff       	call   1620 <free>
  return freep;
    1723:	8b 15 7c 20 00 00    	mov    0x207c,%edx
      if((p = morecore(nunits)) == 0)
    1729:	83 c4 10             	add    $0x10,%esp
    172c:	85 d2                	test   %edx,%edx
    172e:	75 c0                	jne    16f0 <malloc+0x40>
        return 0;
  }
}
    1730:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1733:	31 c0                	xor    %eax,%eax
}
    1735:	5b                   	pop    %ebx
    1736:	5e                   	pop    %esi
    1737:	5f                   	pop    %edi
    1738:	5d                   	pop    %ebp
    1739:	c3                   	ret
    173a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1740:	39 cf                	cmp    %ecx,%edi
    1742:	74 4c                	je     1790 <malloc+0xe0>
        p->s.size -= nunits;
    1744:	29 f9                	sub    %edi,%ecx
    1746:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1749:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    174c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    174f:	89 15 7c 20 00 00    	mov    %edx,0x207c
}
    1755:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1758:	83 c0 08             	add    $0x8,%eax
}
    175b:	5b                   	pop    %ebx
    175c:	5e                   	pop    %esi
    175d:	5f                   	pop    %edi
    175e:	5d                   	pop    %ebp
    175f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    1760:	c7 05 7c 20 00 00 80 	movl   $0x2080,0x207c
    1767:	20 00 00 
    base.s.size = 0;
    176a:	b8 80 20 00 00       	mov    $0x2080,%eax
    base.s.ptr = freep = prevp = &base;
    176f:	c7 05 80 20 00 00 80 	movl   $0x2080,0x2080
    1776:	20 00 00 
    base.s.size = 0;
    1779:	c7 05 84 20 00 00 00 	movl   $0x0,0x2084
    1780:	00 00 00 
    if(p->s.size >= nunits){
    1783:	e9 54 ff ff ff       	jmp    16dc <malloc+0x2c>
    1788:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    178f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
    1790:	8b 08                	mov    (%eax),%ecx
    1792:	89 0a                	mov    %ecx,(%edx)
    1794:	eb b9                	jmp    174f <malloc+0x9f>
