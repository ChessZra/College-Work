
bomb:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64 
    1004:	48 83 ec 08          	sub    $0x8,%rsp
    1008:	48 8b 05 d9 3f 00 00 	mov    0x3fd9(%rip),%rax        # 4fe8 <__gmon_start__>
    100f:	48 85 c0             	test   %rax,%rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	callq  *%rax
    1016:	48 83 c4 08          	add    $0x8,%rsp
    101a:	c3                   	retq   

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	ff 35 ca 3e 00 00    	pushq  0x3eca(%rip)        # 4ef0 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	f2 ff 25 cb 3e 00 00 	bnd jmpq *0x3ecb(%rip)        # 4ef8 <_GLOBAL_OFFSET_TABLE_+0x10>
    102d:	0f 1f 00             	nopl   (%rax)
    1030:	f3 0f 1e fa          	endbr64 
    1034:	68 00 00 00 00       	pushq  $0x0
    1039:	f2 e9 e1 ff ff ff    	bnd jmpq 1020 <.plt>
    103f:	90                   	nop
    1040:	f3 0f 1e fa          	endbr64 
    1044:	68 01 00 00 00       	pushq  $0x1
    1049:	f2 e9 d1 ff ff ff    	bnd jmpq 1020 <.plt>
    104f:	90                   	nop
    1050:	f3 0f 1e fa          	endbr64 
    1054:	68 02 00 00 00       	pushq  $0x2
    1059:	f2 e9 c1 ff ff ff    	bnd jmpq 1020 <.plt>
    105f:	90                   	nop
    1060:	f3 0f 1e fa          	endbr64 
    1064:	68 03 00 00 00       	pushq  $0x3
    1069:	f2 e9 b1 ff ff ff    	bnd jmpq 1020 <.plt>
    106f:	90                   	nop
    1070:	f3 0f 1e fa          	endbr64 
    1074:	68 04 00 00 00       	pushq  $0x4
    1079:	f2 e9 a1 ff ff ff    	bnd jmpq 1020 <.plt>
    107f:	90                   	nop
    1080:	f3 0f 1e fa          	endbr64 
    1084:	68 05 00 00 00       	pushq  $0x5
    1089:	f2 e9 91 ff ff ff    	bnd jmpq 1020 <.plt>
    108f:	90                   	nop
    1090:	f3 0f 1e fa          	endbr64 
    1094:	68 06 00 00 00       	pushq  $0x6
    1099:	f2 e9 81 ff ff ff    	bnd jmpq 1020 <.plt>
    109f:	90                   	nop
    10a0:	f3 0f 1e fa          	endbr64 
    10a4:	68 07 00 00 00       	pushq  $0x7
    10a9:	f2 e9 71 ff ff ff    	bnd jmpq 1020 <.plt>
    10af:	90                   	nop
    10b0:	f3 0f 1e fa          	endbr64 
    10b4:	68 08 00 00 00       	pushq  $0x8
    10b9:	f2 e9 61 ff ff ff    	bnd jmpq 1020 <.plt>
    10bf:	90                   	nop
    10c0:	f3 0f 1e fa          	endbr64 
    10c4:	68 09 00 00 00       	pushq  $0x9
    10c9:	f2 e9 51 ff ff ff    	bnd jmpq 1020 <.plt>
    10cf:	90                   	nop
    10d0:	f3 0f 1e fa          	endbr64 
    10d4:	68 0a 00 00 00       	pushq  $0xa
    10d9:	f2 e9 41 ff ff ff    	bnd jmpq 1020 <.plt>
    10df:	90                   	nop
    10e0:	f3 0f 1e fa          	endbr64 
    10e4:	68 0b 00 00 00       	pushq  $0xb
    10e9:	f2 e9 31 ff ff ff    	bnd jmpq 1020 <.plt>
    10ef:	90                   	nop
    10f0:	f3 0f 1e fa          	endbr64 
    10f4:	68 0c 00 00 00       	pushq  $0xc
    10f9:	f2 e9 21 ff ff ff    	bnd jmpq 1020 <.plt>
    10ff:	90                   	nop
    1100:	f3 0f 1e fa          	endbr64 
    1104:	68 0d 00 00 00       	pushq  $0xd
    1109:	f2 e9 11 ff ff ff    	bnd jmpq 1020 <.plt>
    110f:	90                   	nop
    1110:	f3 0f 1e fa          	endbr64 
    1114:	68 0e 00 00 00       	pushq  $0xe
    1119:	f2 e9 01 ff ff ff    	bnd jmpq 1020 <.plt>
    111f:	90                   	nop
    1120:	f3 0f 1e fa          	endbr64 
    1124:	68 0f 00 00 00       	pushq  $0xf
    1129:	f2 e9 f1 fe ff ff    	bnd jmpq 1020 <.plt>
    112f:	90                   	nop
    1130:	f3 0f 1e fa          	endbr64 
    1134:	68 10 00 00 00       	pushq  $0x10
    1139:	f2 e9 e1 fe ff ff    	bnd jmpq 1020 <.plt>
    113f:	90                   	nop
    1140:	f3 0f 1e fa          	endbr64 
    1144:	68 11 00 00 00       	pushq  $0x11
    1149:	f2 e9 d1 fe ff ff    	bnd jmpq 1020 <.plt>
    114f:	90                   	nop
    1150:	f3 0f 1e fa          	endbr64 
    1154:	68 12 00 00 00       	pushq  $0x12
    1159:	f2 e9 c1 fe ff ff    	bnd jmpq 1020 <.plt>
    115f:	90                   	nop
    1160:	f3 0f 1e fa          	endbr64 
    1164:	68 13 00 00 00       	pushq  $0x13
    1169:	f2 e9 b1 fe ff ff    	bnd jmpq 1020 <.plt>
    116f:	90                   	nop
    1170:	f3 0f 1e fa          	endbr64 
    1174:	68 14 00 00 00       	pushq  $0x14
    1179:	f2 e9 a1 fe ff ff    	bnd jmpq 1020 <.plt>
    117f:	90                   	nop
    1180:	f3 0f 1e fa          	endbr64 
    1184:	68 15 00 00 00       	pushq  $0x15
    1189:	f2 e9 91 fe ff ff    	bnd jmpq 1020 <.plt>
    118f:	90                   	nop
    1190:	f3 0f 1e fa          	endbr64 
    1194:	68 16 00 00 00       	pushq  $0x16
    1199:	f2 e9 81 fe ff ff    	bnd jmpq 1020 <.plt>
    119f:	90                   	nop
    11a0:	f3 0f 1e fa          	endbr64 
    11a4:	68 17 00 00 00       	pushq  $0x17
    11a9:	f2 e9 71 fe ff ff    	bnd jmpq 1020 <.plt>
    11af:	90                   	nop
    11b0:	f3 0f 1e fa          	endbr64 
    11b4:	68 18 00 00 00       	pushq  $0x18
    11b9:	f2 e9 61 fe ff ff    	bnd jmpq 1020 <.plt>
    11bf:	90                   	nop
    11c0:	f3 0f 1e fa          	endbr64 
    11c4:	68 19 00 00 00       	pushq  $0x19
    11c9:	f2 e9 51 fe ff ff    	bnd jmpq 1020 <.plt>
    11cf:	90                   	nop
    11d0:	f3 0f 1e fa          	endbr64 
    11d4:	68 1a 00 00 00       	pushq  $0x1a
    11d9:	f2 e9 41 fe ff ff    	bnd jmpq 1020 <.plt>
    11df:	90                   	nop

Disassembly of section .plt.got:

00000000000011e0 <__cxa_finalize@plt>:
    11e0:	f3 0f 1e fa          	endbr64 
    11e4:	f2 ff 25 0d 3e 00 00 	bnd jmpq *0x3e0d(%rip)        # 4ff8 <__cxa_finalize@GLIBC_2.2.5>
    11eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

Disassembly of section .plt.sec:

00000000000011f0 <getenv@plt>:
    11f0:	f3 0f 1e fa          	endbr64 
    11f4:	f2 ff 25 05 3d 00 00 	bnd jmpq *0x3d05(%rip)        # 4f00 <getenv@GLIBC_2.2.5>
    11fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001200 <strcasecmp@plt>:
    1200:	f3 0f 1e fa          	endbr64 
    1204:	f2 ff 25 fd 3c 00 00 	bnd jmpq *0x3cfd(%rip)        # 4f08 <strcasecmp@GLIBC_2.2.5>
    120b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001210 <__errno_location@plt>:
    1210:	f3 0f 1e fa          	endbr64 
    1214:	f2 ff 25 f5 3c 00 00 	bnd jmpq *0x3cf5(%rip)        # 4f10 <__errno_location@GLIBC_2.2.5>
    121b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001220 <strcpy@plt>:
    1220:	f3 0f 1e fa          	endbr64 
    1224:	f2 ff 25 ed 3c 00 00 	bnd jmpq *0x3ced(%rip)        # 4f18 <strcpy@GLIBC_2.2.5>
    122b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001230 <puts@plt>:
    1230:	f3 0f 1e fa          	endbr64 
    1234:	f2 ff 25 e5 3c 00 00 	bnd jmpq *0x3ce5(%rip)        # 4f20 <puts@GLIBC_2.2.5>
    123b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001240 <write@plt>:
    1240:	f3 0f 1e fa          	endbr64 
    1244:	f2 ff 25 dd 3c 00 00 	bnd jmpq *0x3cdd(%rip)        # 4f28 <write@GLIBC_2.2.5>
    124b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001250 <__stack_chk_fail@plt>:
    1250:	f3 0f 1e fa          	endbr64 
    1254:	f2 ff 25 d5 3c 00 00 	bnd jmpq *0x3cd5(%rip)        # 4f30 <__stack_chk_fail@GLIBC_2.4>
    125b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001260 <alarm@plt>:
    1260:	f3 0f 1e fa          	endbr64 
    1264:	f2 ff 25 cd 3c 00 00 	bnd jmpq *0x3ccd(%rip)        # 4f38 <alarm@GLIBC_2.2.5>
    126b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001270 <close@plt>:
    1270:	f3 0f 1e fa          	endbr64 
    1274:	f2 ff 25 c5 3c 00 00 	bnd jmpq *0x3cc5(%rip)        # 4f40 <close@GLIBC_2.2.5>
    127b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001280 <read@plt>:
    1280:	f3 0f 1e fa          	endbr64 
    1284:	f2 ff 25 bd 3c 00 00 	bnd jmpq *0x3cbd(%rip)        # 4f48 <read@GLIBC_2.2.5>
    128b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001290 <fgets@plt>:
    1290:	f3 0f 1e fa          	endbr64 
    1294:	f2 ff 25 b5 3c 00 00 	bnd jmpq *0x3cb5(%rip)        # 4f50 <fgets@GLIBC_2.2.5>
    129b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012a0 <signal@plt>:
    12a0:	f3 0f 1e fa          	endbr64 
    12a4:	f2 ff 25 ad 3c 00 00 	bnd jmpq *0x3cad(%rip)        # 4f58 <signal@GLIBC_2.2.5>
    12ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012b0 <gethostbyname@plt>:
    12b0:	f3 0f 1e fa          	endbr64 
    12b4:	f2 ff 25 a5 3c 00 00 	bnd jmpq *0x3ca5(%rip)        # 4f60 <gethostbyname@GLIBC_2.2.5>
    12bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012c0 <__memmove_chk@plt>:
    12c0:	f3 0f 1e fa          	endbr64 
    12c4:	f2 ff 25 9d 3c 00 00 	bnd jmpq *0x3c9d(%rip)        # 4f68 <__memmove_chk@GLIBC_2.3.4>
    12cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012d0 <strtol@plt>:
    12d0:	f3 0f 1e fa          	endbr64 
    12d4:	f2 ff 25 95 3c 00 00 	bnd jmpq *0x3c95(%rip)        # 4f70 <strtol@GLIBC_2.2.5>
    12db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012e0 <fflush@plt>:
    12e0:	f3 0f 1e fa          	endbr64 
    12e4:	f2 ff 25 8d 3c 00 00 	bnd jmpq *0x3c8d(%rip)        # 4f78 <fflush@GLIBC_2.2.5>
    12eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012f0 <__isoc99_sscanf@plt>:
    12f0:	f3 0f 1e fa          	endbr64 
    12f4:	f2 ff 25 85 3c 00 00 	bnd jmpq *0x3c85(%rip)        # 4f80 <__isoc99_sscanf@GLIBC_2.7>
    12fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001300 <__printf_chk@plt>:
    1300:	f3 0f 1e fa          	endbr64 
    1304:	f2 ff 25 7d 3c 00 00 	bnd jmpq *0x3c7d(%rip)        # 4f88 <__printf_chk@GLIBC_2.3.4>
    130b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001310 <fopen@plt>:
    1310:	f3 0f 1e fa          	endbr64 
    1314:	f2 ff 25 75 3c 00 00 	bnd jmpq *0x3c75(%rip)        # 4f90 <fopen@GLIBC_2.2.5>
    131b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001320 <gethostname@plt>:
    1320:	f3 0f 1e fa          	endbr64 
    1324:	f2 ff 25 6d 3c 00 00 	bnd jmpq *0x3c6d(%rip)        # 4f98 <gethostname@GLIBC_2.2.5>
    132b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001330 <exit@plt>:
    1330:	f3 0f 1e fa          	endbr64 
    1334:	f2 ff 25 65 3c 00 00 	bnd jmpq *0x3c65(%rip)        # 4fa0 <exit@GLIBC_2.2.5>
    133b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001340 <connect@plt>:
    1340:	f3 0f 1e fa          	endbr64 
    1344:	f2 ff 25 5d 3c 00 00 	bnd jmpq *0x3c5d(%rip)        # 4fa8 <connect@GLIBC_2.2.5>
    134b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001350 <__fprintf_chk@plt>:
    1350:	f3 0f 1e fa          	endbr64 
    1354:	f2 ff 25 55 3c 00 00 	bnd jmpq *0x3c55(%rip)        # 4fb0 <__fprintf_chk@GLIBC_2.3.4>
    135b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001360 <sleep@plt>:
    1360:	f3 0f 1e fa          	endbr64 
    1364:	f2 ff 25 4d 3c 00 00 	bnd jmpq *0x3c4d(%rip)        # 4fb8 <sleep@GLIBC_2.2.5>
    136b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001370 <__ctype_b_loc@plt>:
    1370:	f3 0f 1e fa          	endbr64 
    1374:	f2 ff 25 45 3c 00 00 	bnd jmpq *0x3c45(%rip)        # 4fc0 <__ctype_b_loc@GLIBC_2.3>
    137b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001380 <__sprintf_chk@plt>:
    1380:	f3 0f 1e fa          	endbr64 
    1384:	f2 ff 25 3d 3c 00 00 	bnd jmpq *0x3c3d(%rip)        # 4fc8 <__sprintf_chk@GLIBC_2.3.4>
    138b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001390 <socket@plt>:
    1390:	f3 0f 1e fa          	endbr64 
    1394:	f2 ff 25 35 3c 00 00 	bnd jmpq *0x3c35(%rip)        # 4fd0 <socket@GLIBC_2.2.5>
    139b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

Disassembly of section .text:

00000000000013a0 <_start>:
    13a0:	f3 0f 1e fa          	endbr64 
    13a4:	31 ed                	xor    %ebp,%ebp
    13a6:	49 89 d1             	mov    %rdx,%r9
    13a9:	5e                   	pop    %rsi
    13aa:	48 89 e2             	mov    %rsp,%rdx
    13ad:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    13b1:	50                   	push   %rax
    13b2:	54                   	push   %rsp
    13b3:	4c 8d 05 36 1a 00 00 	lea    0x1a36(%rip),%r8        # 2df0 <__libc_csu_fini>
    13ba:	48 8d 0d bf 19 00 00 	lea    0x19bf(%rip),%rcx        # 2d80 <__libc_csu_init>
    13c1:	48 8d 3d c1 00 00 00 	lea    0xc1(%rip),%rdi        # 1489 <main>
    13c8:	ff 15 12 3c 00 00    	callq  *0x3c12(%rip)        # 4fe0 <__libc_start_main@GLIBC_2.2.5>
    13ce:	f4                   	hlt    
    13cf:	90                   	nop

00000000000013d0 <deregister_tm_clones>:
    13d0:	48 8d 3d 49 42 00 00 	lea    0x4249(%rip),%rdi        # 5620 <stdout@@GLIBC_2.2.5>
    13d7:	48 8d 05 42 42 00 00 	lea    0x4242(%rip),%rax        # 5620 <stdout@@GLIBC_2.2.5>
    13de:	48 39 f8             	cmp    %rdi,%rax
    13e1:	74 15                	je     13f8 <deregister_tm_clones+0x28>
    13e3:	48 8b 05 ee 3b 00 00 	mov    0x3bee(%rip),%rax        # 4fd8 <_ITM_deregisterTMCloneTable>
    13ea:	48 85 c0             	test   %rax,%rax
    13ed:	74 09                	je     13f8 <deregister_tm_clones+0x28>
    13ef:	ff e0                	jmpq   *%rax
    13f1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    13f8:	c3                   	retq   
    13f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001400 <register_tm_clones>:
    1400:	48 8d 3d 19 42 00 00 	lea    0x4219(%rip),%rdi        # 5620 <stdout@@GLIBC_2.2.5>
    1407:	48 8d 35 12 42 00 00 	lea    0x4212(%rip),%rsi        # 5620 <stdout@@GLIBC_2.2.5>
    140e:	48 29 fe             	sub    %rdi,%rsi
    1411:	48 89 f0             	mov    %rsi,%rax
    1414:	48 c1 ee 3f          	shr    $0x3f,%rsi
    1418:	48 c1 f8 03          	sar    $0x3,%rax
    141c:	48 01 c6             	add    %rax,%rsi
    141f:	48 d1 fe             	sar    %rsi
    1422:	74 14                	je     1438 <register_tm_clones+0x38>
    1424:	48 8b 05 c5 3b 00 00 	mov    0x3bc5(%rip),%rax        # 4ff0 <_ITM_registerTMCloneTable>
    142b:	48 85 c0             	test   %rax,%rax
    142e:	74 08                	je     1438 <register_tm_clones+0x38>
    1430:	ff e0                	jmpq   *%rax
    1432:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1438:	c3                   	retq   
    1439:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001440 <__do_global_dtors_aux>:
    1440:	f3 0f 1e fa          	endbr64 
    1444:	80 3d fd 41 00 00 00 	cmpb   $0x0,0x41fd(%rip)        # 5648 <completed.8061>
    144b:	75 2b                	jne    1478 <__do_global_dtors_aux+0x38>
    144d:	55                   	push   %rbp
    144e:	48 83 3d a2 3b 00 00 	cmpq   $0x0,0x3ba2(%rip)        # 4ff8 <__cxa_finalize@GLIBC_2.2.5>
    1455:	00 
    1456:	48 89 e5             	mov    %rsp,%rbp
    1459:	74 0c                	je     1467 <__do_global_dtors_aux+0x27>
    145b:	48 8b 3d a6 3b 00 00 	mov    0x3ba6(%rip),%rdi        # 5008 <__dso_handle>
    1462:	e8 79 fd ff ff       	callq  11e0 <__cxa_finalize@plt>
    1467:	e8 64 ff ff ff       	callq  13d0 <deregister_tm_clones>
    146c:	c6 05 d5 41 00 00 01 	movb   $0x1,0x41d5(%rip)        # 5648 <completed.8061>
    1473:	5d                   	pop    %rbp
    1474:	c3                   	retq   
    1475:	0f 1f 00             	nopl   (%rax)
    1478:	c3                   	retq   
    1479:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001480 <frame_dummy>:
    1480:	f3 0f 1e fa          	endbr64 
    1484:	e9 77 ff ff ff       	jmpq   1400 <register_tm_clones>

0000000000001489 <main>:
    1489:	f3 0f 1e fa          	endbr64 
    148d:	53                   	push   %rbx
    148e:	83 ff 01             	cmp    $0x1,%edi
    1491:	0f 84 f8 00 00 00    	je     158f <main+0x106>
    1497:	48 89 f3             	mov    %rsi,%rbx
    149a:	83 ff 02             	cmp    $0x2,%edi
    149d:	0f 85 21 01 00 00    	jne    15c4 <main+0x13b>
    14a3:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    14a7:	48 8d 35 56 1b 00 00 	lea    0x1b56(%rip),%rsi        # 3004 <_IO_stdin_used+0x4>
    14ae:	e8 5d fe ff ff       	callq  1310 <fopen@plt>
    14b3:	48 89 05 96 41 00 00 	mov    %rax,0x4196(%rip)        # 5650 <infile>
    14ba:	48 85 c0             	test   %rax,%rax
    14bd:	0f 84 df 00 00 00    	je     15a2 <main+0x119>
    14c3:	e8 ca 07 00 00       	callq  1c92 <initialize_bomb>
    14c8:	48 8d 3d b9 1b 00 00 	lea    0x1bb9(%rip),%rdi        # 3088 <_IO_stdin_used+0x88>
    14cf:	e8 5c fd ff ff       	callq  1230 <puts@plt>
    14d4:	48 8d 3d ed 1b 00 00 	lea    0x1bed(%rip),%rdi        # 30c8 <_IO_stdin_used+0xc8>
    14db:	e8 50 fd ff ff       	callq  1230 <puts@plt>
    14e0:	e8 c4 0a 00 00       	callq  1fa9 <read_line>
    14e5:	48 89 c7             	mov    %rax,%rdi
    14e8:	e8 fa 00 00 00       	callq  15e7 <phase_1>
    14ed:	e8 ff 0b 00 00       	callq  20f1 <phase_defused>
    14f2:	48 8d 3d ff 1b 00 00 	lea    0x1bff(%rip),%rdi        # 30f8 <_IO_stdin_used+0xf8>
    14f9:	e8 32 fd ff ff       	callq  1230 <puts@plt>
    14fe:	e8 a6 0a 00 00       	callq  1fa9 <read_line>
    1503:	48 89 c7             	mov    %rax,%rdi
    1506:	e8 00 01 00 00       	callq  160b <phase_2>
    150b:	e8 e1 0b 00 00       	callq  20f1 <phase_defused>
    1510:	48 8d 3d 26 1b 00 00 	lea    0x1b26(%rip),%rdi        # 303d <_IO_stdin_used+0x3d>
    1517:	e8 14 fd ff ff       	callq  1230 <puts@plt>
    151c:	e8 88 0a 00 00       	callq  1fa9 <read_line>
    1521:	48 89 c7             	mov    %rax,%rdi
    1524:	e8 57 01 00 00       	callq  1680 <phase_3>
    1529:	e8 c3 0b 00 00       	callq  20f1 <phase_defused>
    152e:	48 8d 3d 26 1b 00 00 	lea    0x1b26(%rip),%rdi        # 305b <_IO_stdin_used+0x5b>
    1535:	e8 f6 fc ff ff       	callq  1230 <puts@plt>
    153a:	e8 6a 0a 00 00       	callq  1fa9 <read_line>
    153f:	48 89 c7             	mov    %rax,%rdi
    1542:	e8 0e 02 00 00       	callq  1755 <phase_4>
    1547:	e8 a5 0b 00 00       	callq  20f1 <phase_defused>
    154c:	48 8d 3d d5 1b 00 00 	lea    0x1bd5(%rip),%rdi        # 3128 <_IO_stdin_used+0x128>
    1553:	e8 d8 fc ff ff       	callq  1230 <puts@plt>
    1558:	e8 4c 0a 00 00       	callq  1fa9 <read_line>
    155d:	48 89 c7             	mov    %rax,%rdi
    1560:	e8 60 02 00 00       	callq  17c5 <phase_5>
    1565:	e8 87 0b 00 00       	callq  20f1 <phase_defused>
    156a:	48 8d 3d f9 1a 00 00 	lea    0x1af9(%rip),%rdi        # 306a <_IO_stdin_used+0x6a>
    1571:	e8 ba fc ff ff       	callq  1230 <puts@plt>
    1576:	e8 2e 0a 00 00       	callq  1fa9 <read_line>
    157b:	48 89 c7             	mov    %rax,%rdi
    157e:	e8 d3 04 00 00       	callq  1a56 <phase_6>
    1583:	e8 69 0b 00 00       	callq  20f1 <phase_defused>
    1588:	b8 00 00 00 00       	mov    $0x0,%eax
    158d:	5b                   	pop    %rbx
    158e:	c3                   	retq   
    158f:	48 8b 05 9a 40 00 00 	mov    0x409a(%rip),%rax        # 5630 <stdin@@GLIBC_2.2.5>
    1596:	48 89 05 b3 40 00 00 	mov    %rax,0x40b3(%rip)        # 5650 <infile>
    159d:	e9 21 ff ff ff       	jmpq   14c3 <main+0x3a>
    15a2:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    15a6:	48 8b 13             	mov    (%rbx),%rdx
    15a9:	48 8d 35 56 1a 00 00 	lea    0x1a56(%rip),%rsi        # 3006 <_IO_stdin_used+0x6>
    15b0:	bf 01 00 00 00       	mov    $0x1,%edi
    15b5:	e8 46 fd ff ff       	callq  1300 <__printf_chk@plt>
    15ba:	bf 08 00 00 00       	mov    $0x8,%edi
    15bf:	e8 6c fd ff ff       	callq  1330 <exit@plt>
    15c4:	48 8b 16             	mov    (%rsi),%rdx
    15c7:	48 8d 35 55 1a 00 00 	lea    0x1a55(%rip),%rsi        # 3023 <_IO_stdin_used+0x23>
    15ce:	bf 01 00 00 00       	mov    $0x1,%edi
    15d3:	b8 00 00 00 00       	mov    $0x0,%eax
    15d8:	e8 23 fd ff ff       	callq  1300 <__printf_chk@plt>
    15dd:	bf 08 00 00 00       	mov    $0x8,%edi
    15e2:	e8 49 fd ff ff       	callq  1330 <exit@plt>

00000000000015e7 <phase_1>:
    15e7:	f3 0f 1e fa          	endbr64 
    15eb:	48 83 ec 08          	sub    $0x8,%rsp
    15ef:	48 8d 35 5a 1b 00 00 	lea    0x1b5a(%rip),%rsi        # 3150 <_IO_stdin_used+0x150>
    15f6:	e8 37 06 00 00       	callq  1c32 <strings_not_equal>
    15fb:	85 c0                	test   %eax,%eax
    15fd:	75 05                	jne    1604 <phase_1+0x1d>
    15ff:	48 83 c4 08          	add    $0x8,%rsp
    1603:	c3                   	retq   
    1604:	e8 19 09 00 00       	callq  1f22 <explode_bomb>
    1609:	eb f4                	jmp    15ff <phase_1+0x18>

000000000000160b <phase_2>:
    160b:	f3 0f 1e fa          	endbr64 
    160f:	55                   	push   %rbp
    1610:	53                   	push   %rbx
    1611:	48 83 ec 28          	sub    $0x28,%rsp
    1615:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    161c:	00 00 
    161e:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    1623:	31 c0                	xor    %eax,%eax
    1625:	48 89 e6             	mov    %rsp,%rsi
    1628:	e8 37 09 00 00       	callq  1f64 <read_six_numbers>
    162d:	83 3c 24 06          	cmpl   $0x6,(%rsp)
    1631:	7e 0a                	jle    163d <phase_2+0x32>
    1633:	48 89 e5             	mov    %rsp,%rbp
    1636:	bb 01 00 00 00       	mov    $0x1,%ebx
    163b:	eb 18                	jmp    1655 <phase_2+0x4a>
    163d:	e8 e0 08 00 00       	callq  1f22 <explode_bomb>
    1642:	eb ef                	jmp    1633 <phase_2+0x28>
    1644:	e8 d9 08 00 00       	callq  1f22 <explode_bomb>
    1649:	83 c3 01             	add    $0x1,%ebx
    164c:	48 83 c5 04          	add    $0x4,%rbp
    1650:	83 fb 06             	cmp    $0x6,%ebx
    1653:	74 0f                	je     1664 <phase_2+0x59>
    1655:	89 d8                	mov    %ebx,%eax
    1657:	03 45 00             	add    0x0(%rbp),%eax
    165a:	8d 04 40             	lea    (%rax,%rax,2),%eax
    165d:	39 45 04             	cmp    %eax,0x4(%rbp)
    1660:	74 e7                	je     1649 <phase_2+0x3e>
    1662:	eb e0                	jmp    1644 <phase_2+0x39>
    1664:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    1669:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    1670:	00 00 
    1672:	75 07                	jne    167b <phase_2+0x70>
    1674:	48 83 c4 28          	add    $0x28,%rsp
    1678:	5b                   	pop    %rbx
    1679:	5d                   	pop    %rbp
    167a:	c3                   	retq   
    167b:	e8 d0 fb ff ff       	callq  1250 <__stack_chk_fail@plt>

0000000000001680 <phase_3>:
    1680:	f3 0f 1e fa          	endbr64 
    1684:	48 83 ec 18          	sub    $0x18,%rsp
    1688:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    168f:	00 00 
    1691:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    1696:	31 c0                	xor    %eax,%eax
    1698:	48 8d 4c 24 03       	lea    0x3(%rsp),%rcx
    169d:	48 8d 54 24 04       	lea    0x4(%rsp),%rdx
    16a2:	48 8d 35 ed 1a 00 00 	lea    0x1aed(%rip),%rsi        # 3196 <_IO_stdin_used+0x196>
    16a9:	e8 42 fc ff ff       	callq  12f0 <__isoc99_sscanf@plt>
    16ae:	83 f8 01             	cmp    $0x1,%eax
    16b1:	7e 1c                	jle    16cf <phase_3+0x4f>
    16b3:	83 7c 24 04 07       	cmpl   $0x7,0x4(%rsp)
    16b8:	77 5f                	ja     1719 <phase_3+0x99>
    16ba:	8b 44 24 04          	mov    0x4(%rsp),%eax
    16be:	48 8d 15 eb 1a 00 00 	lea    0x1aeb(%rip),%rdx        # 31b0 <_IO_stdin_used+0x1b0>
    16c5:	48 63 04 82          	movslq (%rdx,%rax,4),%rax
    16c9:	48 01 d0             	add    %rdx,%rax
    16cc:	3e ff e0             	notrack jmpq *%rax
    16cf:	e8 4e 08 00 00       	callq  1f22 <explode_bomb>
    16d4:	eb dd                	jmp    16b3 <phase_3+0x33>
    16d6:	b8 6c 00 00 00       	mov    $0x6c,%eax
    16db:	38 44 24 03          	cmp    %al,0x3(%rsp)
    16df:	75 4b                	jne    172c <phase_3+0xac>
    16e1:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    16e6:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    16ed:	00 00 
    16ef:	75 42                	jne    1733 <phase_3+0xb3>
    16f1:	48 83 c4 18          	add    $0x18,%rsp
    16f5:	c3                   	retq   
    16f6:	b8 67 00 00 00       	mov    $0x67,%eax
    16fb:	eb de                	jmp    16db <phase_3+0x5b>
    16fd:	b8 78 00 00 00       	mov    $0x78,%eax
    1702:	eb d7                	jmp    16db <phase_3+0x5b>
    1704:	b8 6f 00 00 00       	mov    $0x6f,%eax
    1709:	eb d0                	jmp    16db <phase_3+0x5b>
    170b:	b8 65 00 00 00       	mov    $0x65,%eax
    1710:	eb c9                	jmp    16db <phase_3+0x5b>
    1712:	b8 71 00 00 00       	mov    $0x71,%eax
    1717:	eb c2                	jmp    16db <phase_3+0x5b>
    1719:	e8 04 08 00 00       	callq  1f22 <explode_bomb>
    171e:	b8 7a 00 00 00       	mov    $0x7a,%eax
    1723:	eb b6                	jmp    16db <phase_3+0x5b>
    1725:	b8 62 00 00 00       	mov    $0x62,%eax
    172a:	eb af                	jmp    16db <phase_3+0x5b>
    172c:	e8 f1 07 00 00       	callq  1f22 <explode_bomb>
    1731:	eb ae                	jmp    16e1 <phase_3+0x61>
    1733:	e8 18 fb ff ff       	callq  1250 <__stack_chk_fail@plt>

0000000000001738 <foo4>:
    1738:	f3 0f 1e fa          	endbr64 
    173c:	b8 00 00 00 00       	mov    $0x0,%eax
    1741:	39 f7                	cmp    %esi,%edi
    1743:	7c 01                	jl     1746 <foo4+0xe>
    1745:	c3                   	retq   
    1746:	53                   	push   %rbx
    1747:	89 fb                	mov    %edi,%ebx
    1749:	8d 7f 01             	lea    0x1(%rdi),%edi
    174c:	e8 e7 ff ff ff       	callq  1738 <foo4>
    1751:	01 d8                	add    %ebx,%eax
    1753:	5b                   	pop    %rbx
    1754:	c3                   	retq   

0000000000001755 <phase_4>:
    1755:	f3 0f 1e fa          	endbr64 
    1759:	48 83 ec 18          	sub    $0x18,%rsp
    175d:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    1764:	00 00 
    1766:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    176b:	31 c0                	xor    %eax,%eax
    176d:	48 8d 54 24 04       	lea    0x4(%rsp),%rdx
    1772:	48 8d 35 8f 1c 00 00 	lea    0x1c8f(%rip),%rsi        # 3408 <array.3499+0x238>
    1779:	e8 72 fb ff ff       	callq  12f0 <__isoc99_sscanf@plt>
    177e:	83 f8 01             	cmp    $0x1,%eax
    1781:	75 07                	jne    178a <phase_4+0x35>
    1783:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    1788:	79 05                	jns    178f <phase_4+0x3a>
    178a:	e8 93 07 00 00       	callq  1f22 <explode_bomb>
    178f:	be 0e 00 00 00       	mov    $0xe,%esi
    1794:	bf 00 00 00 00       	mov    $0x0,%edi
    1799:	e8 9a ff ff ff       	callq  1738 <foo4>
    179e:	39 44 24 04          	cmp    %eax,0x4(%rsp)
    17a2:	75 15                	jne    17b9 <phase_4+0x64>
    17a4:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    17a9:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    17b0:	00 00 
    17b2:	75 0c                	jne    17c0 <phase_4+0x6b>
    17b4:	48 83 c4 18          	add    $0x18,%rsp
    17b8:	c3                   	retq   
    17b9:	e8 64 07 00 00       	callq  1f22 <explode_bomb>
    17be:	eb e4                	jmp    17a4 <phase_4+0x4f>
    17c0:	e8 8b fa ff ff       	callq  1250 <__stack_chk_fail@plt>

00000000000017c5 <phase_5>:
    17c5:	f3 0f 1e fa          	endbr64 
    17c9:	55                   	push   %rbp
    17ca:	53                   	push   %rbx
    17cb:	48 81 ec b8 01 00 00 	sub    $0x1b8,%rsp
    17d2:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    17d9:	00 00 
    17db:	48 89 84 24 a8 01 00 	mov    %rax,0x1a8(%rsp)
    17e2:	00 
    17e3:	31 c0                	xor    %eax,%eax
    17e5:	c7 44 24 10 0b 00 00 	movl   $0xb,0x10(%rsp)
    17ec:	00 
    17ed:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    17f4:	00 00 
    17f6:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
    17fd:	00 00 
    17ff:	c7 44 24 30 ea ff ff 	movl   $0xffffffea,0x30(%rsp)
    1806:	ff 
    1807:	4c 8d 5c 24 10       	lea    0x10(%rsp),%r11
    180c:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
    1811:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
    1818:	00 00 
    181a:	c7 44 24 50 05 00 00 	movl   $0x5,0x50(%rsp)
    1821:	00 
    1822:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
    1827:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    182c:	4c 89 5c 24 68       	mov    %r11,0x68(%rsp)
    1831:	c7 44 24 70 fb ff ff 	movl   $0xfffffffb,0x70(%rsp)
    1838:	ff 
    1839:	48 8d 54 24 50       	lea    0x50(%rsp),%rdx
    183e:	48 89 54 24 78       	mov    %rdx,0x78(%rsp)
    1843:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
    184a:	00 
    184b:	c7 84 24 90 00 00 00 	movl   $0xfffffff9,0x90(%rsp)
    1852:	f9 ff ff ff 
    1856:	48 8d 4c 24 70       	lea    0x70(%rsp),%rcx
    185b:	48 89 8c 24 98 00 00 	mov    %rcx,0x98(%rsp)
    1862:	00 
    1863:	48 89 94 24 a8 00 00 	mov    %rdx,0xa8(%rsp)
    186a:	00 
    186b:	c7 84 24 b0 00 00 00 	movl   $0x12,0xb0(%rsp)
    1872:	12 00 00 00 
    1876:	48 8d b4 24 90 00 00 	lea    0x90(%rsp),%rsi
    187d:	00 
    187e:	48 89 b4 24 b8 00 00 	mov    %rsi,0xb8(%rsp)
    1885:	00 
    1886:	48 89 8c 24 c8 00 00 	mov    %rcx,0xc8(%rsp)
    188d:	00 
    188e:	c7 84 24 d0 00 00 00 	movl   $0xfffffffc,0xd0(%rsp)
    1895:	fc ff ff ff 
    1899:	4c 8d 84 24 b0 00 00 	lea    0xb0(%rsp),%r8
    18a0:	00 
    18a1:	4c 89 84 24 d8 00 00 	mov    %r8,0xd8(%rsp)
    18a8:	00 
    18a9:	48 89 b4 24 e8 00 00 	mov    %rsi,0xe8(%rsp)
    18b0:	00 
    18b1:	c7 84 24 f0 00 00 00 	movl   $0xfffffffa,0xf0(%rsp)
    18b8:	fa ff ff ff 
    18bc:	4c 8d 8c 24 d0 00 00 	lea    0xd0(%rsp),%r9
    18c3:	00 
    18c4:	4c 89 8c 24 f8 00 00 	mov    %r9,0xf8(%rsp)
    18cb:	00 
    18cc:	4c 89 84 24 08 01 00 	mov    %r8,0x108(%rsp)
    18d3:	00 
    18d4:	c7 84 24 10 01 00 00 	movl   $0xf,0x110(%rsp)
    18db:	0f 00 00 00 
    18df:	4c 8d 94 24 f0 00 00 	lea    0xf0(%rsp),%r10
    18e6:	00 
    18e7:	4c 89 94 24 18 01 00 	mov    %r10,0x118(%rsp)
    18ee:	00 
    18ef:	4c 89 8c 24 28 01 00 	mov    %r9,0x128(%rsp)
    18f6:	00 
    18f7:	c7 84 24 30 01 00 00 	movl   $0xfffffffd,0x130(%rsp)
    18fe:	fd ff ff ff 
    1902:	48 8d 9c 24 10 01 00 	lea    0x110(%rsp),%rbx
    1909:	00 
    190a:	48 89 9c 24 38 01 00 	mov    %rbx,0x138(%rsp)
    1911:	00 
    1912:	48 c7 84 24 40 01 00 	movq   $0x0,0x140(%rsp)
    1919:	00 00 00 00 00 
    191e:	4c 89 94 24 48 01 00 	mov    %r10,0x148(%rsp)
    1925:	00 
    1926:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    192b:	48 89 54 24 40       	mov    %rdx,0x40(%rsp)
    1930:	48 89 4c 24 60       	mov    %rcx,0x60(%rsp)
    1935:	48 89 b4 24 80 00 00 	mov    %rsi,0x80(%rsp)
    193c:	00 
    193d:	4c 89 84 24 a0 00 00 	mov    %r8,0xa0(%rsp)
    1944:	00 
    1945:	4c 89 8c 24 c0 00 00 	mov    %r9,0xc0(%rsp)
    194c:	00 
    194d:	4c 89 94 24 e0 00 00 	mov    %r10,0xe0(%rsp)
    1954:	00 
    1955:	48 89 9c 24 00 01 00 	mov    %rbx,0x100(%rsp)
    195c:	00 
    195d:	48 8d ac 24 30 01 00 	lea    0x130(%rsp),%rbp
    1964:	00 
    1965:	48 89 ac 24 20 01 00 	mov    %rbp,0x120(%rsp)
    196c:	00 
    196d:	48 c7 84 24 50 01 00 	movq   $0x0,0x150(%rsp)
    1974:	00 00 00 00 00 
    1979:	48 89 ac 24 58 01 00 	mov    %rbp,0x158(%rsp)
    1980:	00 
    1981:	48 89 9c 24 60 01 00 	mov    %rbx,0x160(%rsp)
    1988:	00 
    1989:	4c 89 94 24 68 01 00 	mov    %r10,0x168(%rsp)
    1990:	00 
    1991:	4c 89 8c 24 70 01 00 	mov    %r9,0x170(%rsp)
    1998:	00 
    1999:	4c 89 84 24 78 01 00 	mov    %r8,0x178(%rsp)
    19a0:	00 
    19a1:	48 89 b4 24 80 01 00 	mov    %rsi,0x180(%rsp)
    19a8:	00 
    19a9:	48 89 8c 24 88 01 00 	mov    %rcx,0x188(%rsp)
    19b0:	00 
    19b1:	48 89 94 24 90 01 00 	mov    %rdx,0x190(%rsp)
    19b8:	00 
    19b9:	48 89 84 24 98 01 00 	mov    %rax,0x198(%rsp)
    19c0:	00 
    19c1:	4c 89 9c 24 a0 01 00 	mov    %r11,0x1a0(%rsp)
    19c8:	00 
    19c9:	48 8d 4c 24 0c       	lea    0xc(%rsp),%rcx
    19ce:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    19d3:	48 8d 35 2b 1a 00 00 	lea    0x1a2b(%rip),%rsi        # 3405 <array.3499+0x235>
    19da:	b8 00 00 00 00       	mov    $0x0,%eax
    19df:	e8 0c f9 ff ff       	callq  12f0 <__isoc99_sscanf@plt>
    19e4:	83 f8 01             	cmp    $0x1,%eax
    19e7:	7e 4c                	jle    1a35 <phase_5+0x270>
    19e9:	83 7c 24 08 0a       	cmpl   $0xa,0x8(%rsp)
    19ee:	77 4c                	ja     1a3c <phase_5+0x277>
    19f0:	48 63 44 24 08       	movslq 0x8(%rsp),%rax
    19f5:	48 8b 84 c4 50 01 00 	mov    0x150(%rsp,%rax,8),%rax
    19fc:	00 
    19fd:	48 85 c0             	test   %rax,%rax
    1a00:	74 41                	je     1a43 <phase_5+0x27e>
    1a02:	ba 00 00 00 00       	mov    $0x0,%edx
    1a07:	03 10                	add    (%rax),%edx
    1a09:	48 8b 40 10          	mov    0x10(%rax),%rax
    1a0d:	48 85 c0             	test   %rax,%rax
    1a10:	75 f5                	jne    1a07 <phase_5+0x242>
    1a12:	39 54 24 0c          	cmp    %edx,0xc(%rsp)
    1a16:	75 32                	jne    1a4a <phase_5+0x285>
    1a18:	48 8b 84 24 a8 01 00 	mov    0x1a8(%rsp),%rax
    1a1f:	00 
    1a20:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    1a27:	00 00 
    1a29:	75 26                	jne    1a51 <phase_5+0x28c>
    1a2b:	48 81 c4 b8 01 00 00 	add    $0x1b8,%rsp
    1a32:	5b                   	pop    %rbx
    1a33:	5d                   	pop    %rbp
    1a34:	c3                   	retq   
    1a35:	e8 e8 04 00 00       	callq  1f22 <explode_bomb>
    1a3a:	eb ad                	jmp    19e9 <phase_5+0x224>
    1a3c:	e8 e1 04 00 00       	callq  1f22 <explode_bomb>
    1a41:	eb ad                	jmp    19f0 <phase_5+0x22b>
    1a43:	ba 00 00 00 00       	mov    $0x0,%edx
    1a48:	eb c8                	jmp    1a12 <phase_5+0x24d>
    1a4a:	e8 d3 04 00 00       	callq  1f22 <explode_bomb>
    1a4f:	eb c7                	jmp    1a18 <phase_5+0x253>
    1a51:	e8 fa f7 ff ff       	callq  1250 <__stack_chk_fail@plt>

0000000000001a56 <phase_6>:
    1a56:	f3 0f 1e fa          	endbr64 
    1a5a:	53                   	push   %rbx
    1a5b:	48 83 ec 10          	sub    $0x10,%rsp
    1a5f:	48 89 fb             	mov    %rdi,%rbx
    1a62:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    1a69:	00 00 
    1a6b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    1a70:	31 c0                	xor    %eax,%eax
    1a72:	e8 9a 01 00 00       	callq  1c11 <string_length>
    1a77:	83 f8 06             	cmp    $0x6,%eax
    1a7a:	75 55                	jne    1ad1 <phase_6+0x7b>
    1a7c:	b8 00 00 00 00       	mov    $0x0,%eax
    1a81:	48 8d 0d 48 17 00 00 	lea    0x1748(%rip),%rcx        # 31d0 <array.3499>
    1a88:	0f b6 14 03          	movzbl (%rbx,%rax,1),%edx
    1a8c:	83 e2 0f             	and    $0xf,%edx
    1a8f:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1a93:	88 54 04 01          	mov    %dl,0x1(%rsp,%rax,1)
    1a97:	48 83 c0 01          	add    $0x1,%rax
    1a9b:	48 83 f8 06          	cmp    $0x6,%rax
    1a9f:	75 e7                	jne    1a88 <phase_6+0x32>
    1aa1:	c6 44 24 07 00       	movb   $0x0,0x7(%rsp)
    1aa6:	48 8d 7c 24 01       	lea    0x1(%rsp),%rdi
    1aab:	48 8d 35 eb 16 00 00 	lea    0x16eb(%rip),%rsi        # 319d <_IO_stdin_used+0x19d>
    1ab2:	e8 7b 01 00 00       	callq  1c32 <strings_not_equal>
    1ab7:	85 c0                	test   %eax,%eax
    1ab9:	75 1d                	jne    1ad8 <phase_6+0x82>
    1abb:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    1ac0:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    1ac7:	00 00 
    1ac9:	75 14                	jne    1adf <phase_6+0x89>
    1acb:	48 83 c4 10          	add    $0x10,%rsp
    1acf:	5b                   	pop    %rbx
    1ad0:	c3                   	retq   
    1ad1:	e8 4c 04 00 00       	callq  1f22 <explode_bomb>
    1ad6:	eb a4                	jmp    1a7c <phase_6+0x26>
    1ad8:	e8 45 04 00 00       	callq  1f22 <explode_bomb>
    1add:	eb dc                	jmp    1abb <phase_6+0x65>
    1adf:	e8 6c f7 ff ff       	callq  1250 <__stack_chk_fail@plt>

0000000000001ae4 <fun7>:
    1ae4:	f3 0f 1e fa          	endbr64 
    1ae8:	48 85 ff             	test   %rdi,%rdi
    1aeb:	74 32                	je     1b1f <fun7+0x3b>
    1aed:	48 83 ec 08          	sub    $0x8,%rsp
    1af1:	8b 17                	mov    (%rdi),%edx
    1af3:	39 f2                	cmp    %esi,%edx
    1af5:	7f 0c                	jg     1b03 <fun7+0x1f>
    1af7:	b8 00 00 00 00       	mov    $0x0,%eax
    1afc:	75 12                	jne    1b10 <fun7+0x2c>
    1afe:	48 83 c4 08          	add    $0x8,%rsp
    1b02:	c3                   	retq   
    1b03:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    1b07:	e8 d8 ff ff ff       	callq  1ae4 <fun7>
    1b0c:	01 c0                	add    %eax,%eax
    1b0e:	eb ee                	jmp    1afe <fun7+0x1a>
    1b10:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
    1b14:	e8 cb ff ff ff       	callq  1ae4 <fun7>
    1b19:	8d 44 00 01          	lea    0x1(%rax,%rax,1),%eax
    1b1d:	eb df                	jmp    1afe <fun7+0x1a>
    1b1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1b24:	c3                   	retq   

0000000000001b25 <secret_phase>:
    1b25:	f3 0f 1e fa          	endbr64 
    1b29:	53                   	push   %rbx
    1b2a:	e8 7a 04 00 00       	callq  1fa9 <read_line>
    1b2f:	48 89 c7             	mov    %rax,%rdi
    1b32:	ba 0a 00 00 00       	mov    $0xa,%edx
    1b37:	be 00 00 00 00       	mov    $0x0,%esi
    1b3c:	e8 8f f7 ff ff       	callq  12d0 <strtol@plt>
    1b41:	48 89 c3             	mov    %rax,%rbx
    1b44:	8d 40 91             	lea    -0x6f(%rax),%eax
    1b47:	3d 84 01 00 00       	cmp    $0x184,%eax
    1b4c:	77 26                	ja     1b74 <secret_phase+0x4f>
    1b4e:	89 de                	mov    %ebx,%esi
    1b50:	48 8d 3d d9 35 00 00 	lea    0x35d9(%rip),%rdi        # 5130 <n1>
    1b57:	e8 88 ff ff ff       	callq  1ae4 <fun7>
    1b5c:	83 f8 05             	cmp    $0x5,%eax
    1b5f:	75 1a                	jne    1b7b <secret_phase+0x56>
    1b61:	48 8d 3d 08 16 00 00 	lea    0x1608(%rip),%rdi        # 3170 <_IO_stdin_used+0x170>
    1b68:	e8 c3 f6 ff ff       	callq  1230 <puts@plt>
    1b6d:	e8 7f 05 00 00       	callq  20f1 <phase_defused>
    1b72:	5b                   	pop    %rbx
    1b73:	c3                   	retq   
    1b74:	e8 a9 03 00 00       	callq  1f22 <explode_bomb>
    1b79:	eb d3                	jmp    1b4e <secret_phase+0x29>
    1b7b:	e8 a2 03 00 00       	callq  1f22 <explode_bomb>
    1b80:	eb df                	jmp    1b61 <secret_phase+0x3c>

0000000000001b82 <sig_handler>:
    1b82:	f3 0f 1e fa          	endbr64 
    1b86:	50                   	push   %rax
    1b87:	58                   	pop    %rax
    1b88:	48 83 ec 08          	sub    $0x8,%rsp
    1b8c:	48 8d 3d 4d 16 00 00 	lea    0x164d(%rip),%rdi        # 31e0 <array.3499+0x10>
    1b93:	e8 98 f6 ff ff       	callq  1230 <puts@plt>
    1b98:	bf 03 00 00 00       	mov    $0x3,%edi
    1b9d:	e8 be f7 ff ff       	callq  1360 <sleep@plt>
    1ba2:	48 8d 35 d8 17 00 00 	lea    0x17d8(%rip),%rsi        # 3381 <array.3499+0x1b1>
    1ba9:	bf 01 00 00 00       	mov    $0x1,%edi
    1bae:	b8 00 00 00 00       	mov    $0x0,%eax
    1bb3:	e8 48 f7 ff ff       	callq  1300 <__printf_chk@plt>
    1bb8:	48 8b 3d 61 3a 00 00 	mov    0x3a61(%rip),%rdi        # 5620 <stdout@@GLIBC_2.2.5>
    1bbf:	e8 1c f7 ff ff       	callq  12e0 <fflush@plt>
    1bc4:	bf 01 00 00 00       	mov    $0x1,%edi
    1bc9:	e8 92 f7 ff ff       	callq  1360 <sleep@plt>
    1bce:	48 8d 3d b4 17 00 00 	lea    0x17b4(%rip),%rdi        # 3389 <array.3499+0x1b9>
    1bd5:	e8 56 f6 ff ff       	callq  1230 <puts@plt>
    1bda:	bf 10 00 00 00       	mov    $0x10,%edi
    1bdf:	e8 4c f7 ff ff       	callq  1330 <exit@plt>

0000000000001be4 <invalid_phase>:
    1be4:	f3 0f 1e fa          	endbr64 
    1be8:	50                   	push   %rax
    1be9:	58                   	pop    %rax
    1bea:	48 83 ec 08          	sub    $0x8,%rsp
    1bee:	48 89 fa             	mov    %rdi,%rdx
    1bf1:	48 8d 35 99 17 00 00 	lea    0x1799(%rip),%rsi        # 3391 <array.3499+0x1c1>
    1bf8:	bf 01 00 00 00       	mov    $0x1,%edi
    1bfd:	b8 00 00 00 00       	mov    $0x0,%eax
    1c02:	e8 f9 f6 ff ff       	callq  1300 <__printf_chk@plt>
    1c07:	bf 08 00 00 00       	mov    $0x8,%edi
    1c0c:	e8 1f f7 ff ff       	callq  1330 <exit@plt>

0000000000001c11 <string_length>:
    1c11:	f3 0f 1e fa          	endbr64 
    1c15:	80 3f 00             	cmpb   $0x0,(%rdi)
    1c18:	74 12                	je     1c2c <string_length+0x1b>
    1c1a:	b8 00 00 00 00       	mov    $0x0,%eax
    1c1f:	48 83 c7 01          	add    $0x1,%rdi
    1c23:	83 c0 01             	add    $0x1,%eax
    1c26:	80 3f 00             	cmpb   $0x0,(%rdi)
    1c29:	75 f4                	jne    1c1f <string_length+0xe>
    1c2b:	c3                   	retq   
    1c2c:	b8 00 00 00 00       	mov    $0x0,%eax
    1c31:	c3                   	retq   

0000000000001c32 <strings_not_equal>:
    1c32:	f3 0f 1e fa          	endbr64 
    1c36:	41 54                	push   %r12
    1c38:	55                   	push   %rbp
    1c39:	53                   	push   %rbx
    1c3a:	48 89 fb             	mov    %rdi,%rbx
    1c3d:	48 89 f5             	mov    %rsi,%rbp
    1c40:	e8 cc ff ff ff       	callq  1c11 <string_length>
    1c45:	41 89 c4             	mov    %eax,%r12d
    1c48:	48 89 ef             	mov    %rbp,%rdi
    1c4b:	e8 c1 ff ff ff       	callq  1c11 <string_length>
    1c50:	89 c2                	mov    %eax,%edx
    1c52:	b8 01 00 00 00       	mov    $0x1,%eax
    1c57:	41 39 d4             	cmp    %edx,%r12d
    1c5a:	75 31                	jne    1c8d <strings_not_equal+0x5b>
    1c5c:	0f b6 13             	movzbl (%rbx),%edx
    1c5f:	84 d2                	test   %dl,%dl
    1c61:	74 1e                	je     1c81 <strings_not_equal+0x4f>
    1c63:	b8 00 00 00 00       	mov    $0x0,%eax
    1c68:	38 54 05 00          	cmp    %dl,0x0(%rbp,%rax,1)
    1c6c:	75 1a                	jne    1c88 <strings_not_equal+0x56>
    1c6e:	48 83 c0 01          	add    $0x1,%rax
    1c72:	0f b6 14 03          	movzbl (%rbx,%rax,1),%edx
    1c76:	84 d2                	test   %dl,%dl
    1c78:	75 ee                	jne    1c68 <strings_not_equal+0x36>
    1c7a:	b8 00 00 00 00       	mov    $0x0,%eax
    1c7f:	eb 0c                	jmp    1c8d <strings_not_equal+0x5b>
    1c81:	b8 00 00 00 00       	mov    $0x0,%eax
    1c86:	eb 05                	jmp    1c8d <strings_not_equal+0x5b>
    1c88:	b8 01 00 00 00       	mov    $0x1,%eax
    1c8d:	5b                   	pop    %rbx
    1c8e:	5d                   	pop    %rbp
    1c8f:	41 5c                	pop    %r12
    1c91:	c3                   	retq   

0000000000001c92 <initialize_bomb>:
    1c92:	f3 0f 1e fa          	endbr64 
    1c96:	55                   	push   %rbp
    1c97:	53                   	push   %rbx
    1c98:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    1c9f:	48 83 0c 24 00       	orq    $0x0,(%rsp)
    1ca4:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    1cab:	48 83 0c 24 00       	orq    $0x0,(%rsp)
    1cb0:	48 83 ec 58          	sub    $0x58,%rsp
    1cb4:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    1cbb:	00 00 
    1cbd:	48 89 84 24 48 20 00 	mov    %rax,0x2048(%rsp)
    1cc4:	00 
    1cc5:	31 c0                	xor    %eax,%eax
    1cc7:	48 8d 35 b4 fe ff ff 	lea    -0x14c(%rip),%rsi        # 1b82 <sig_handler>
    1cce:	bf 02 00 00 00       	mov    $0x2,%edi
    1cd3:	e8 c8 f5 ff ff       	callq  12a0 <signal@plt>
    1cd8:	48 89 e7             	mov    %rsp,%rdi
    1cdb:	be 40 00 00 00       	mov    $0x40,%esi
    1ce0:	e8 3b f6 ff ff       	callq  1320 <gethostname@plt>
    1ce5:	85 c0                	test   %eax,%eax
    1ce7:	75 45                	jne    1d2e <initialize_bomb+0x9c>
    1ce9:	48 8b 3d 30 35 00 00 	mov    0x3530(%rip),%rdi        # 5220 <host_table>
    1cf0:	48 8d 1d 31 35 00 00 	lea    0x3531(%rip),%rbx        # 5228 <host_table+0x8>
    1cf7:	48 89 e5             	mov    %rsp,%rbp
    1cfa:	48 85 ff             	test   %rdi,%rdi
    1cfd:	74 19                	je     1d18 <initialize_bomb+0x86>
    1cff:	48 89 ee             	mov    %rbp,%rsi
    1d02:	e8 f9 f4 ff ff       	callq  1200 <strcasecmp@plt>
    1d07:	85 c0                	test   %eax,%eax
    1d09:	74 5e                	je     1d69 <initialize_bomb+0xd7>
    1d0b:	48 83 c3 08          	add    $0x8,%rbx
    1d0f:	48 8b 7b f8          	mov    -0x8(%rbx),%rdi
    1d13:	48 85 ff             	test   %rdi,%rdi
    1d16:	75 e7                	jne    1cff <initialize_bomb+0x6d>
    1d18:	48 8d 3d 31 15 00 00 	lea    0x1531(%rip),%rdi        # 3250 <array.3499+0x80>
    1d1f:	e8 0c f5 ff ff       	callq  1230 <puts@plt>
    1d24:	bf 08 00 00 00       	mov    $0x8,%edi
    1d29:	e8 02 f6 ff ff       	callq  1330 <exit@plt>
    1d2e:	48 8d 3d e3 14 00 00 	lea    0x14e3(%rip),%rdi        # 3218 <array.3499+0x48>
    1d35:	e8 f6 f4 ff ff       	callq  1230 <puts@plt>
    1d3a:	bf 08 00 00 00       	mov    $0x8,%edi
    1d3f:	e8 ec f5 ff ff       	callq  1330 <exit@plt>
    1d44:	48 8d 54 24 40       	lea    0x40(%rsp),%rdx
    1d49:	48 8d 35 52 16 00 00 	lea    0x1652(%rip),%rsi        # 33a2 <array.3499+0x1d2>
    1d50:	bf 01 00 00 00       	mov    $0x1,%edi
    1d55:	b8 00 00 00 00       	mov    $0x0,%eax
    1d5a:	e8 a1 f5 ff ff       	callq  1300 <__printf_chk@plt>
    1d5f:	bf 08 00 00 00       	mov    $0x8,%edi
    1d64:	e8 c7 f5 ff ff       	callq  1330 <exit@plt>
    1d69:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    1d6e:	e8 99 0d 00 00       	callq  2b0c <init_driver>
    1d73:	85 c0                	test   %eax,%eax
    1d75:	78 cd                	js     1d44 <initialize_bomb+0xb2>
    1d77:	48 8b 84 24 48 20 00 	mov    0x2048(%rsp),%rax
    1d7e:	00 
    1d7f:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    1d86:	00 00 
    1d88:	75 0a                	jne    1d94 <initialize_bomb+0x102>
    1d8a:	48 81 c4 58 20 00 00 	add    $0x2058,%rsp
    1d91:	5b                   	pop    %rbx
    1d92:	5d                   	pop    %rbp
    1d93:	c3                   	retq   
    1d94:	e8 b7 f4 ff ff       	callq  1250 <__stack_chk_fail@plt>

0000000000001d99 <initialize_bomb_solve>:
    1d99:	f3 0f 1e fa          	endbr64 
    1d9d:	c3                   	retq   

0000000000001d9e <blank_line>:
    1d9e:	f3 0f 1e fa          	endbr64 
    1da2:	55                   	push   %rbp
    1da3:	53                   	push   %rbx
    1da4:	48 83 ec 08          	sub    $0x8,%rsp
    1da8:	48 89 fd             	mov    %rdi,%rbp
    1dab:	0f b6 5d 00          	movzbl 0x0(%rbp),%ebx
    1daf:	84 db                	test   %bl,%bl
    1db1:	74 1e                	je     1dd1 <blank_line+0x33>
    1db3:	e8 b8 f5 ff ff       	callq  1370 <__ctype_b_loc@plt>
    1db8:	48 83 c5 01          	add    $0x1,%rbp
    1dbc:	48 0f be db          	movsbq %bl,%rbx
    1dc0:	48 8b 00             	mov    (%rax),%rax
    1dc3:	f6 44 58 01 20       	testb  $0x20,0x1(%rax,%rbx,2)
    1dc8:	75 e1                	jne    1dab <blank_line+0xd>
    1dca:	b8 00 00 00 00       	mov    $0x0,%eax
    1dcf:	eb 05                	jmp    1dd6 <blank_line+0x38>
    1dd1:	b8 01 00 00 00       	mov    $0x1,%eax
    1dd6:	48 83 c4 08          	add    $0x8,%rsp
    1dda:	5b                   	pop    %rbx
    1ddb:	5d                   	pop    %rbp
    1ddc:	c3                   	retq   

0000000000001ddd <skip>:
    1ddd:	f3 0f 1e fa          	endbr64 
    1de1:	55                   	push   %rbp
    1de2:	53                   	push   %rbx
    1de3:	48 83 ec 08          	sub    $0x8,%rsp
    1de7:	48 8d 2d 72 38 00 00 	lea    0x3872(%rip),%rbp        # 5660 <input_strings>
    1dee:	48 63 05 57 38 00 00 	movslq 0x3857(%rip),%rax        # 564c <num_input_strings>
    1df5:	48 8d 3c 80          	lea    (%rax,%rax,4),%rdi
    1df9:	48 c1 e7 04          	shl    $0x4,%rdi
    1dfd:	48 01 ef             	add    %rbp,%rdi
    1e00:	48 8b 15 49 38 00 00 	mov    0x3849(%rip),%rdx        # 5650 <infile>
    1e07:	be 50 00 00 00       	mov    $0x50,%esi
    1e0c:	e8 7f f4 ff ff       	callq  1290 <fgets@plt>
    1e11:	48 89 c3             	mov    %rax,%rbx
    1e14:	48 85 c0             	test   %rax,%rax
    1e17:	74 0c                	je     1e25 <skip+0x48>
    1e19:	48 89 c7             	mov    %rax,%rdi
    1e1c:	e8 7d ff ff ff       	callq  1d9e <blank_line>
    1e21:	85 c0                	test   %eax,%eax
    1e23:	75 c9                	jne    1dee <skip+0x11>
    1e25:	48 89 d8             	mov    %rbx,%rax
    1e28:	48 83 c4 08          	add    $0x8,%rsp
    1e2c:	5b                   	pop    %rbx
    1e2d:	5d                   	pop    %rbp
    1e2e:	c3                   	retq   

0000000000001e2f <send_msg>:
    1e2f:	f3 0f 1e fa          	endbr64 
    1e33:	53                   	push   %rbx
    1e34:	4c 8d 9c 24 00 c0 ff 	lea    -0x4000(%rsp),%r11
    1e3b:	ff 
    1e3c:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    1e43:	48 83 0c 24 00       	orq    $0x0,(%rsp)
    1e48:	4c 39 dc             	cmp    %r11,%rsp
    1e4b:	75 ef                	jne    1e3c <send_msg+0xd>
    1e4d:	48 83 ec 10          	sub    $0x10,%rsp
    1e51:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    1e58:	00 00 
    1e5a:	48 89 84 24 08 40 00 	mov    %rax,0x4008(%rsp)
    1e61:	00 
    1e62:	31 c0                	xor    %eax,%eax
    1e64:	8b 15 e2 37 00 00    	mov    0x37e2(%rip),%edx        # 564c <num_input_strings>
    1e6a:	8d 42 ff             	lea    -0x1(%rdx),%eax
    1e6d:	48 98                	cltq   
    1e6f:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
    1e73:	48 c1 e0 04          	shl    $0x4,%rax
    1e77:	48 8d 0d e2 37 00 00 	lea    0x37e2(%rip),%rcx        # 5660 <input_strings>
    1e7e:	48 01 c8             	add    %rcx,%rax
    1e81:	85 ff                	test   %edi,%edi
    1e83:	4c 8d 0d 32 15 00 00 	lea    0x1532(%rip),%r9        # 33bc <array.3499+0x1ec>
    1e8a:	48 8d 0d 33 15 00 00 	lea    0x1533(%rip),%rcx        # 33c4 <array.3499+0x1f4>
    1e91:	4c 0f 44 c9          	cmove  %rcx,%r9
    1e95:	48 89 e3             	mov    %rsp,%rbx
    1e98:	50                   	push   %rax
    1e99:	52                   	push   %rdx
    1e9a:	44 8b 05 8b 32 00 00 	mov    0x328b(%rip),%r8d        # 512c <bomb_id>
    1ea1:	48 8d 0d 25 15 00 00 	lea    0x1525(%rip),%rcx        # 33cd <array.3499+0x1fd>
    1ea8:	ba 00 20 00 00       	mov    $0x2000,%edx
    1ead:	be 01 00 00 00       	mov    $0x1,%esi
    1eb2:	48 89 df             	mov    %rbx,%rdi
    1eb5:	b8 00 00 00 00       	mov    $0x0,%eax
    1eba:	e8 c1 f4 ff ff       	callq  1380 <__sprintf_chk@plt>
    1ebf:	4c 8d 84 24 10 20 00 	lea    0x2010(%rsp),%r8
    1ec6:	00 
    1ec7:	b9 00 00 00 00       	mov    $0x0,%ecx
    1ecc:	48 89 da             	mov    %rbx,%rdx
    1ecf:	48 8d 35 3a 32 00 00 	lea    0x323a(%rip),%rsi        # 5110 <user_password>
    1ed6:	48 8d 3d 48 32 00 00 	lea    0x3248(%rip),%rdi        # 5125 <userid>
    1edd:	e8 1f 0e 00 00       	callq  2d01 <driver_post>
    1ee2:	48 83 c4 10          	add    $0x10,%rsp
    1ee6:	85 c0                	test   %eax,%eax
    1ee8:	78 1c                	js     1f06 <send_msg+0xd7>
    1eea:	48 8b 84 24 08 40 00 	mov    0x4008(%rsp),%rax
    1ef1:	00 
    1ef2:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    1ef9:	00 00 
    1efb:	75 20                	jne    1f1d <send_msg+0xee>
    1efd:	48 81 c4 10 40 00 00 	add    $0x4010,%rsp
    1f04:	5b                   	pop    %rbx
    1f05:	c3                   	retq   
    1f06:	48 8d bc 24 00 20 00 	lea    0x2000(%rsp),%rdi
    1f0d:	00 
    1f0e:	e8 1d f3 ff ff       	callq  1230 <puts@plt>
    1f13:	bf 00 00 00 00       	mov    $0x0,%edi
    1f18:	e8 13 f4 ff ff       	callq  1330 <exit@plt>
    1f1d:	e8 2e f3 ff ff       	callq  1250 <__stack_chk_fail@plt>

0000000000001f22 <explode_bomb>:
    1f22:	f3 0f 1e fa          	endbr64 
    1f26:	50                   	push   %rax
    1f27:	58                   	pop    %rax
    1f28:	48 83 ec 08          	sub    $0x8,%rsp
    1f2c:	48 8d 3d a6 14 00 00 	lea    0x14a6(%rip),%rdi        # 33d9 <array.3499+0x209>
    1f33:	e8 f8 f2 ff ff       	callq  1230 <puts@plt>
    1f38:	48 8d 3d a3 14 00 00 	lea    0x14a3(%rip),%rdi        # 33e2 <array.3499+0x212>
    1f3f:	e8 ec f2 ff ff       	callq  1230 <puts@plt>
    1f44:	bf 00 00 00 00       	mov    $0x0,%edi
    1f49:	e8 e1 fe ff ff       	callq  1e2f <send_msg>
    1f4e:	48 8d 3d 33 13 00 00 	lea    0x1333(%rip),%rdi        # 3288 <array.3499+0xb8>
    1f55:	e8 d6 f2 ff ff       	callq  1230 <puts@plt>
    1f5a:	bf 08 00 00 00       	mov    $0x8,%edi
    1f5f:	e8 cc f3 ff ff       	callq  1330 <exit@plt>

0000000000001f64 <read_six_numbers>:
    1f64:	f3 0f 1e fa          	endbr64 
    1f68:	48 83 ec 08          	sub    $0x8,%rsp
    1f6c:	48 89 f2             	mov    %rsi,%rdx
    1f6f:	48 8d 4e 04          	lea    0x4(%rsi),%rcx
    1f73:	48 8d 46 14          	lea    0x14(%rsi),%rax
    1f77:	50                   	push   %rax
    1f78:	48 8d 46 10          	lea    0x10(%rsi),%rax
    1f7c:	50                   	push   %rax
    1f7d:	4c 8d 4e 0c          	lea    0xc(%rsi),%r9
    1f81:	4c 8d 46 08          	lea    0x8(%rsi),%r8
    1f85:	48 8d 35 6d 14 00 00 	lea    0x146d(%rip),%rsi        # 33f9 <array.3499+0x229>
    1f8c:	b8 00 00 00 00       	mov    $0x0,%eax
    1f91:	e8 5a f3 ff ff       	callq  12f0 <__isoc99_sscanf@plt>
    1f96:	48 83 c4 10          	add    $0x10,%rsp
    1f9a:	83 f8 05             	cmp    $0x5,%eax
    1f9d:	7e 05                	jle    1fa4 <read_six_numbers+0x40>
    1f9f:	48 83 c4 08          	add    $0x8,%rsp
    1fa3:	c3                   	retq   
    1fa4:	e8 79 ff ff ff       	callq  1f22 <explode_bomb>

0000000000001fa9 <read_line>:
    1fa9:	f3 0f 1e fa          	endbr64 
    1fad:	48 83 ec 08          	sub    $0x8,%rsp
    1fb1:	b8 00 00 00 00       	mov    $0x0,%eax
    1fb6:	e8 22 fe ff ff       	callq  1ddd <skip>
    1fbb:	48 85 c0             	test   %rax,%rax
    1fbe:	74 6f                	je     202f <read_line+0x86>
    1fc0:	8b 35 86 36 00 00    	mov    0x3686(%rip),%esi        # 564c <num_input_strings>
    1fc6:	48 63 c6             	movslq %esi,%rax
    1fc9:	48 8d 14 80          	lea    (%rax,%rax,4),%rdx
    1fcd:	48 c1 e2 04          	shl    $0x4,%rdx
    1fd1:	48 8d 05 88 36 00 00 	lea    0x3688(%rip),%rax        # 5660 <input_strings>
    1fd8:	48 01 c2             	add    %rax,%rdx
    1fdb:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
    1fe2:	b8 00 00 00 00       	mov    $0x0,%eax
    1fe7:	48 89 d7             	mov    %rdx,%rdi
    1fea:	f2 ae                	repnz scas %es:(%rdi),%al
    1fec:	48 f7 d1             	not    %rcx
    1fef:	48 83 e9 01          	sub    $0x1,%rcx
    1ff3:	83 f9 4e             	cmp    $0x4e,%ecx
    1ff6:	0f 8f ab 00 00 00    	jg     20a7 <read_line+0xfe>
    1ffc:	83 e9 01             	sub    $0x1,%ecx
    1fff:	48 63 c9             	movslq %ecx,%rcx
    2002:	48 63 c6             	movslq %esi,%rax
    2005:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
    2009:	48 c1 e0 04          	shl    $0x4,%rax
    200d:	48 89 c7             	mov    %rax,%rdi
    2010:	48 8d 05 49 36 00 00 	lea    0x3649(%rip),%rax        # 5660 <input_strings>
    2017:	48 01 f8             	add    %rdi,%rax
    201a:	c6 04 08 00          	movb   $0x0,(%rax,%rcx,1)
    201e:	83 c6 01             	add    $0x1,%esi
    2021:	89 35 25 36 00 00    	mov    %esi,0x3625(%rip)        # 564c <num_input_strings>
    2027:	48 89 d0             	mov    %rdx,%rax
    202a:	48 83 c4 08          	add    $0x8,%rsp
    202e:	c3                   	retq   
    202f:	48 8b 05 fa 35 00 00 	mov    0x35fa(%rip),%rax        # 5630 <stdin@@GLIBC_2.2.5>
    2036:	48 39 05 13 36 00 00 	cmp    %rax,0x3613(%rip)        # 5650 <infile>
    203d:	74 1b                	je     205a <read_line+0xb1>
    203f:	48 8d 3d e3 13 00 00 	lea    0x13e3(%rip),%rdi        # 3429 <array.3499+0x259>
    2046:	e8 a5 f1 ff ff       	callq  11f0 <getenv@plt>
    204b:	48 85 c0             	test   %rax,%rax
    204e:	74 20                	je     2070 <read_line+0xc7>
    2050:	bf 00 00 00 00       	mov    $0x0,%edi
    2055:	e8 d6 f2 ff ff       	callq  1330 <exit@plt>
    205a:	48 8d 3d aa 13 00 00 	lea    0x13aa(%rip),%rdi        # 340b <array.3499+0x23b>
    2061:	e8 ca f1 ff ff       	callq  1230 <puts@plt>
    2066:	bf 08 00 00 00       	mov    $0x8,%edi
    206b:	e8 c0 f2 ff ff       	callq  1330 <exit@plt>
    2070:	48 8b 05 b9 35 00 00 	mov    0x35b9(%rip),%rax        # 5630 <stdin@@GLIBC_2.2.5>
    2077:	48 89 05 d2 35 00 00 	mov    %rax,0x35d2(%rip)        # 5650 <infile>
    207e:	b8 00 00 00 00       	mov    $0x0,%eax
    2083:	e8 55 fd ff ff       	callq  1ddd <skip>
    2088:	48 85 c0             	test   %rax,%rax
    208b:	0f 85 2f ff ff ff    	jne    1fc0 <read_line+0x17>
    2091:	48 8d 3d 73 13 00 00 	lea    0x1373(%rip),%rdi        # 340b <array.3499+0x23b>
    2098:	e8 93 f1 ff ff       	callq  1230 <puts@plt>
    209d:	bf 00 00 00 00       	mov    $0x0,%edi
    20a2:	e8 89 f2 ff ff       	callq  1330 <exit@plt>
    20a7:	48 8d 3d 86 13 00 00 	lea    0x1386(%rip),%rdi        # 3434 <array.3499+0x264>
    20ae:	e8 7d f1 ff ff       	callq  1230 <puts@plt>
    20b3:	8b 05 93 35 00 00    	mov    0x3593(%rip),%eax        # 564c <num_input_strings>
    20b9:	8d 50 01             	lea    0x1(%rax),%edx
    20bc:	89 15 8a 35 00 00    	mov    %edx,0x358a(%rip)        # 564c <num_input_strings>
    20c2:	48 98                	cltq   
    20c4:	48 6b c0 50          	imul   $0x50,%rax,%rax
    20c8:	48 8d 15 91 35 00 00 	lea    0x3591(%rip),%rdx        # 5660 <input_strings>
    20cf:	48 be 2a 2a 2a 74 72 	movabs $0x636e7572742a2a2a,%rsi
    20d6:	75 6e 63 
    20d9:	48 bf 61 74 65 64 2a 	movabs $0x2a2a2a64657461,%rdi
    20e0:	2a 2a 00 
    20e3:	48 89 34 02          	mov    %rsi,(%rdx,%rax,1)
    20e7:	48 89 7c 02 08       	mov    %rdi,0x8(%rdx,%rax,1)
    20ec:	e8 31 fe ff ff       	callq  1f22 <explode_bomb>

00000000000020f1 <phase_defused>:
    20f1:	f3 0f 1e fa          	endbr64 
    20f5:	48 83 ec 78          	sub    $0x78,%rsp
    20f9:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    2100:	00 00 
    2102:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
    2107:	31 c0                	xor    %eax,%eax
    2109:	bf 01 00 00 00       	mov    $0x1,%edi
    210e:	e8 1c fd ff ff       	callq  1e2f <send_msg>
    2113:	83 3d 32 35 00 00 06 	cmpl   $0x6,0x3532(%rip)        # 564c <num_input_strings>
    211a:	74 15                	je     2131 <phase_defused+0x40>
    211c:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
    2121:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    2128:	00 00 
    212a:	75 7f                	jne    21ab <phase_defused+0xba>
    212c:	48 83 c4 78          	add    $0x78,%rsp
    2130:	c3                   	retq   
    2131:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    2136:	48 8d 54 24 0c       	lea    0xc(%rsp),%rdx
    213b:	48 8d 35 0d 13 00 00 	lea    0x130d(%rip),%rsi        # 344f <array.3499+0x27f>
    2142:	48 8d 3d 07 36 00 00 	lea    0x3607(%rip),%rdi        # 5750 <input_strings+0xf0>
    2149:	b8 00 00 00 00       	mov    $0x0,%eax
    214e:	e8 9d f1 ff ff       	callq  12f0 <__isoc99_sscanf@plt>
    2153:	83 f8 02             	cmp    $0x2,%eax
    2156:	74 1a                	je     2172 <phase_defused+0x81>
    2158:	48 8d 3d b1 11 00 00 	lea    0x11b1(%rip),%rdi        # 3310 <array.3499+0x140>
    215f:	e8 cc f0 ff ff       	callq  1230 <puts@plt>
    2164:	48 8d 3d d5 11 00 00 	lea    0x11d5(%rip),%rdi        # 3340 <array.3499+0x170>
    216b:	e8 c0 f0 ff ff       	callq  1230 <puts@plt>
    2170:	eb aa                	jmp    211c <phase_defused+0x2b>
    2172:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    2177:	48 8d 35 d7 12 00 00 	lea    0x12d7(%rip),%rsi        # 3455 <array.3499+0x285>
    217e:	e8 af fa ff ff       	callq  1c32 <strings_not_equal>
    2183:	85 c0                	test   %eax,%eax
    2185:	75 d1                	jne    2158 <phase_defused+0x67>
    2187:	48 8d 3d 22 11 00 00 	lea    0x1122(%rip),%rdi        # 32b0 <array.3499+0xe0>
    218e:	e8 9d f0 ff ff       	callq  1230 <puts@plt>
    2193:	48 8d 3d 3e 11 00 00 	lea    0x113e(%rip),%rdi        # 32d8 <array.3499+0x108>
    219a:	e8 91 f0 ff ff       	callq  1230 <puts@plt>
    219f:	b8 00 00 00 00       	mov    $0x0,%eax
    21a4:	e8 7c f9 ff ff       	callq  1b25 <secret_phase>
    21a9:	eb ad                	jmp    2158 <phase_defused+0x67>
    21ab:	e8 a0 f0 ff ff       	callq  1250 <__stack_chk_fail@plt>

00000000000021b0 <sigalrm_handler>:
    21b0:	f3 0f 1e fa          	endbr64 
    21b4:	50                   	push   %rax
    21b5:	58                   	pop    %rax
    21b6:	48 83 ec 08          	sub    $0x8,%rsp
    21ba:	b9 00 00 00 00       	mov    $0x0,%ecx
    21bf:	48 8d 15 7a 13 00 00 	lea    0x137a(%rip),%rdx        # 3540 <array.3499+0x370>
    21c6:	be 01 00 00 00       	mov    $0x1,%esi
    21cb:	48 8b 3d 6e 34 00 00 	mov    0x346e(%rip),%rdi        # 5640 <stderr@@GLIBC_2.2.5>
    21d2:	b8 00 00 00 00       	mov    $0x0,%eax
    21d7:	e8 74 f1 ff ff       	callq  1350 <__fprintf_chk@plt>
    21dc:	bf 01 00 00 00       	mov    $0x1,%edi
    21e1:	e8 4a f1 ff ff       	callq  1330 <exit@plt>

00000000000021e6 <rio_readlineb>:
    21e6:	41 56                	push   %r14
    21e8:	41 55                	push   %r13
    21ea:	41 54                	push   %r12
    21ec:	55                   	push   %rbp
    21ed:	53                   	push   %rbx
    21ee:	48 89 f5             	mov    %rsi,%rbp
    21f1:	48 83 fa 01          	cmp    $0x1,%rdx
    21f5:	0f 86 90 00 00 00    	jbe    228b <rio_readlineb+0xa5>
    21fb:	48 89 fb             	mov    %rdi,%rbx
    21fe:	4c 8d 74 16 ff       	lea    -0x1(%rsi,%rdx,1),%r14
    2203:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    2209:	4c 8d 67 10          	lea    0x10(%rdi),%r12
    220d:	eb 54                	jmp    2263 <rio_readlineb+0x7d>
    220f:	e8 fc ef ff ff       	callq  1210 <__errno_location@plt>
    2214:	83 38 04             	cmpl   $0x4,(%rax)
    2217:	75 53                	jne    226c <rio_readlineb+0x86>
    2219:	ba 00 20 00 00       	mov    $0x2000,%edx
    221e:	4c 89 e6             	mov    %r12,%rsi
    2221:	8b 3b                	mov    (%rbx),%edi
    2223:	e8 58 f0 ff ff       	callq  1280 <read@plt>
    2228:	89 c2                	mov    %eax,%edx
    222a:	89 43 04             	mov    %eax,0x4(%rbx)
    222d:	85 c0                	test   %eax,%eax
    222f:	78 de                	js     220f <rio_readlineb+0x29>
    2231:	85 c0                	test   %eax,%eax
    2233:	74 40                	je     2275 <rio_readlineb+0x8f>
    2235:	4c 89 63 08          	mov    %r12,0x8(%rbx)
    2239:	48 8b 43 08          	mov    0x8(%rbx),%rax
    223d:	0f b6 08             	movzbl (%rax),%ecx
    2240:	48 83 c0 01          	add    $0x1,%rax
    2244:	48 89 43 08          	mov    %rax,0x8(%rbx)
    2248:	83 ea 01             	sub    $0x1,%edx
    224b:	89 53 04             	mov    %edx,0x4(%rbx)
    224e:	48 83 c5 01          	add    $0x1,%rbp
    2252:	88 4d ff             	mov    %cl,-0x1(%rbp)
    2255:	80 f9 0a             	cmp    $0xa,%cl
    2258:	74 3c                	je     2296 <rio_readlineb+0xb0>
    225a:	41 83 c5 01          	add    $0x1,%r13d
    225e:	4c 39 f5             	cmp    %r14,%rbp
    2261:	74 30                	je     2293 <rio_readlineb+0xad>
    2263:	8b 53 04             	mov    0x4(%rbx),%edx
    2266:	85 d2                	test   %edx,%edx
    2268:	7e af                	jle    2219 <rio_readlineb+0x33>
    226a:	eb cd                	jmp    2239 <rio_readlineb+0x53>
    226c:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
    2273:	eb 05                	jmp    227a <rio_readlineb+0x94>
    2275:	b8 00 00 00 00       	mov    $0x0,%eax
    227a:	85 c0                	test   %eax,%eax
    227c:	75 28                	jne    22a6 <rio_readlineb+0xc0>
    227e:	b8 00 00 00 00       	mov    $0x0,%eax
    2283:	41 83 fd 01          	cmp    $0x1,%r13d
    2287:	75 0d                	jne    2296 <rio_readlineb+0xb0>
    2289:	eb 12                	jmp    229d <rio_readlineb+0xb7>
    228b:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    2291:	eb 03                	jmp    2296 <rio_readlineb+0xb0>
    2293:	4c 89 f5             	mov    %r14,%rbp
    2296:	c6 45 00 00          	movb   $0x0,0x0(%rbp)
    229a:	49 63 c5             	movslq %r13d,%rax
    229d:	5b                   	pop    %rbx
    229e:	5d                   	pop    %rbp
    229f:	41 5c                	pop    %r12
    22a1:	41 5d                	pop    %r13
    22a3:	41 5e                	pop    %r14
    22a5:	c3                   	retq   
    22a6:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
    22ad:	eb ee                	jmp    229d <rio_readlineb+0xb7>

00000000000022af <submitr>:
    22af:	f3 0f 1e fa          	endbr64 
    22b3:	41 57                	push   %r15
    22b5:	41 56                	push   %r14
    22b7:	41 55                	push   %r13
    22b9:	41 54                	push   %r12
    22bb:	55                   	push   %rbp
    22bc:	53                   	push   %rbx
    22bd:	4c 8d 9c 24 00 60 ff 	lea    -0xa000(%rsp),%r11
    22c4:	ff 
    22c5:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    22cc:	48 83 0c 24 00       	orq    $0x0,(%rsp)
    22d1:	4c 39 dc             	cmp    %r11,%rsp
    22d4:	75 ef                	jne    22c5 <submitr+0x16>
    22d6:	48 83 ec 68          	sub    $0x68,%rsp
    22da:	49 89 fd             	mov    %rdi,%r13
    22dd:	89 f5                	mov    %esi,%ebp
    22df:	48 89 14 24          	mov    %rdx,(%rsp)
    22e3:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
    22e8:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
    22ed:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
    22f2:	48 8b 9c 24 a0 a0 00 	mov    0xa0a0(%rsp),%rbx
    22f9:	00 
    22fa:	4c 8b bc 24 a8 a0 00 	mov    0xa0a8(%rsp),%r15
    2301:	00 
    2302:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    2309:	00 00 
    230b:	48 89 84 24 58 a0 00 	mov    %rax,0xa058(%rsp)
    2312:	00 
    2313:	31 c0                	xor    %eax,%eax
    2315:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%rsp)
    231c:	00 
    231d:	ba 00 00 00 00       	mov    $0x0,%edx
    2322:	be 01 00 00 00       	mov    $0x1,%esi
    2327:	bf 02 00 00 00       	mov    $0x2,%edi
    232c:	e8 5f f0 ff ff       	callq  1390 <socket@plt>
    2331:	85 c0                	test   %eax,%eax
    2333:	0f 88 17 01 00 00    	js     2450 <submitr+0x1a1>
    2339:	41 89 c4             	mov    %eax,%r12d
    233c:	4c 89 ef             	mov    %r13,%rdi
    233f:	e8 6c ef ff ff       	callq  12b0 <gethostbyname@plt>
    2344:	48 85 c0             	test   %rax,%rax
    2347:	0f 84 53 01 00 00    	je     24a0 <submitr+0x1f1>
    234d:	4c 8d 6c 24 30       	lea    0x30(%rsp),%r13
    2352:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    2359:	00 00 
    235b:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
    2362:	00 00 
    2364:	66 c7 44 24 30 02 00 	movw   $0x2,0x30(%rsp)
    236b:	48 63 50 14          	movslq 0x14(%rax),%rdx
    236f:	48 8b 40 18          	mov    0x18(%rax),%rax
    2373:	48 8d 7c 24 34       	lea    0x34(%rsp),%rdi
    2378:	b9 0c 00 00 00       	mov    $0xc,%ecx
    237d:	48 8b 30             	mov    (%rax),%rsi
    2380:	e8 3b ef ff ff       	callq  12c0 <__memmove_chk@plt>
    2385:	66 c1 c5 08          	rol    $0x8,%bp
    2389:	66 89 6c 24 32       	mov    %bp,0x32(%rsp)
    238e:	ba 10 00 00 00       	mov    $0x10,%edx
    2393:	4c 89 ee             	mov    %r13,%rsi
    2396:	44 89 e7             	mov    %r12d,%edi
    2399:	e8 a2 ef ff ff       	callq  1340 <connect@plt>
    239e:	85 c0                	test   %eax,%eax
    23a0:	0f 88 65 01 00 00    	js     250b <submitr+0x25c>
    23a6:	49 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%r9
    23ad:	b8 00 00 00 00       	mov    $0x0,%eax
    23b2:	4c 89 c9             	mov    %r9,%rcx
    23b5:	48 89 df             	mov    %rbx,%rdi
    23b8:	f2 ae                	repnz scas %es:(%rdi),%al
    23ba:	48 f7 d1             	not    %rcx
    23bd:	48 89 ce             	mov    %rcx,%rsi
    23c0:	4c 89 c9             	mov    %r9,%rcx
    23c3:	48 8b 3c 24          	mov    (%rsp),%rdi
    23c7:	f2 ae                	repnz scas %es:(%rdi),%al
    23c9:	49 89 c8             	mov    %rcx,%r8
    23cc:	4c 89 c9             	mov    %r9,%rcx
    23cf:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    23d4:	f2 ae                	repnz scas %es:(%rdi),%al
    23d6:	48 89 ca             	mov    %rcx,%rdx
    23d9:	48 f7 d2             	not    %rdx
    23dc:	4c 89 c9             	mov    %r9,%rcx
    23df:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    23e4:	f2 ae                	repnz scas %es:(%rdi),%al
    23e6:	4c 29 c2             	sub    %r8,%rdx
    23e9:	48 29 ca             	sub    %rcx,%rdx
    23ec:	48 8d 44 76 fd       	lea    -0x3(%rsi,%rsi,2),%rax
    23f1:	48 8d 44 02 7b       	lea    0x7b(%rdx,%rax,1),%rax
    23f6:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
    23fc:	0f 87 66 01 00 00    	ja     2568 <submitr+0x2b9>
    2402:	48 8d 94 24 50 40 00 	lea    0x4050(%rsp),%rdx
    2409:	00 
    240a:	b9 00 04 00 00       	mov    $0x400,%ecx
    240f:	b8 00 00 00 00       	mov    $0x0,%eax
    2414:	48 89 d7             	mov    %rdx,%rdi
    2417:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    241a:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
    2421:	48 89 df             	mov    %rbx,%rdi
    2424:	f2 ae                	repnz scas %es:(%rdi),%al
    2426:	48 f7 d1             	not    %rcx
    2429:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
    242d:	83 f9 01             	cmp    $0x1,%ecx
    2430:	0f 84 08 05 00 00    	je     293e <submitr+0x68f>
    2436:	8d 40 ff             	lea    -0x1(%rax),%eax
    2439:	4c 8d 74 03 01       	lea    0x1(%rbx,%rax,1),%r14
    243e:	48 89 d5             	mov    %rdx,%rbp
    2441:	49 bd d9 ff 00 00 00 	movabs $0x2000000000ffd9,%r13
    2448:	00 20 00 
    244b:	e9 a6 01 00 00       	jmpq   25f6 <submitr+0x347>
    2450:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    2457:	3a 20 43 
    245a:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    2461:	20 75 6e 
    2464:	49 89 07             	mov    %rax,(%r15)
    2467:	49 89 57 08          	mov    %rdx,0x8(%r15)
    246b:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2472:	74 6f 20 
    2475:	48 ba 63 72 65 61 74 	movabs $0x7320657461657263,%rdx
    247c:	65 20 73 
    247f:	49 89 47 10          	mov    %rax,0x10(%r15)
    2483:	49 89 57 18          	mov    %rdx,0x18(%r15)
    2487:	41 c7 47 20 6f 63 6b 	movl   $0x656b636f,0x20(%r15)
    248e:	65 
    248f:	66 41 c7 47 24 74 00 	movw   $0x74,0x24(%r15)
    2496:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    249b:	e9 16 03 00 00       	jmpq   27b6 <submitr+0x507>
    24a0:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
    24a7:	3a 20 44 
    24aa:	48 ba 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rdx
    24b1:	20 75 6e 
    24b4:	49 89 07             	mov    %rax,(%r15)
    24b7:	49 89 57 08          	mov    %rdx,0x8(%r15)
    24bb:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    24c2:	74 6f 20 
    24c5:	48 ba 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rdx
    24cc:	76 65 20 
    24cf:	49 89 47 10          	mov    %rax,0x10(%r15)
    24d3:	49 89 57 18          	mov    %rdx,0x18(%r15)
    24d7:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
    24de:	72 20 61 
    24e1:	49 89 47 20          	mov    %rax,0x20(%r15)
    24e5:	41 c7 47 28 64 64 72 	movl   $0x65726464,0x28(%r15)
    24ec:	65 
    24ed:	66 41 c7 47 2c 73 73 	movw   $0x7373,0x2c(%r15)
    24f4:	41 c6 47 2e 00       	movb   $0x0,0x2e(%r15)
    24f9:	44 89 e7             	mov    %r12d,%edi
    24fc:	e8 6f ed ff ff       	callq  1270 <close@plt>
    2501:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2506:	e9 ab 02 00 00       	jmpq   27b6 <submitr+0x507>
    250b:	48 b8 45 72 72 6f 72 	movabs $0x55203a726f727245,%rax
    2512:	3a 20 55 
    2515:	48 ba 6e 61 62 6c 65 	movabs $0x6f7420656c62616e,%rdx
    251c:	20 74 6f 
    251f:	49 89 07             	mov    %rax,(%r15)
    2522:	49 89 57 08          	mov    %rdx,0x8(%r15)
    2526:	48 b8 20 63 6f 6e 6e 	movabs $0x7463656e6e6f6320,%rax
    252d:	65 63 74 
    2530:	48 ba 20 74 6f 20 74 	movabs $0x20656874206f7420,%rdx
    2537:	68 65 20 
    253a:	49 89 47 10          	mov    %rax,0x10(%r15)
    253e:	49 89 57 18          	mov    %rdx,0x18(%r15)
    2542:	41 c7 47 20 73 65 72 	movl   $0x76726573,0x20(%r15)
    2549:	76 
    254a:	66 41 c7 47 24 65 72 	movw   $0x7265,0x24(%r15)
    2551:	41 c6 47 26 00       	movb   $0x0,0x26(%r15)
    2556:	44 89 e7             	mov    %r12d,%edi
    2559:	e8 12 ed ff ff       	callq  1270 <close@plt>
    255e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2563:	e9 4e 02 00 00       	jmpq   27b6 <submitr+0x507>
    2568:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
    256f:	3a 20 52 
    2572:	48 ba 65 73 75 6c 74 	movabs $0x747320746c757365,%rdx
    2579:	20 73 74 
    257c:	49 89 07             	mov    %rax,(%r15)
    257f:	49 89 57 08          	mov    %rdx,0x8(%r15)
    2583:	48 b8 72 69 6e 67 20 	movabs $0x6f6f7420676e6972,%rax
    258a:	74 6f 6f 
    258d:	48 ba 20 6c 61 72 67 	movabs $0x202e656772616c20,%rdx
    2594:	65 2e 20 
    2597:	49 89 47 10          	mov    %rax,0x10(%r15)
    259b:	49 89 57 18          	mov    %rdx,0x18(%r15)
    259f:	48 b8 49 6e 63 72 65 	movabs $0x6573616572636e49,%rax
    25a6:	61 73 65 
    25a9:	48 ba 20 53 55 42 4d 	movabs $0x5254494d42555320,%rdx
    25b0:	49 54 52 
    25b3:	49 89 47 20          	mov    %rax,0x20(%r15)
    25b7:	49 89 57 28          	mov    %rdx,0x28(%r15)
    25bb:	48 b8 5f 4d 41 58 42 	movabs $0x46554258414d5f,%rax
    25c2:	55 46 00 
    25c5:	49 89 47 30          	mov    %rax,0x30(%r15)
    25c9:	44 89 e7             	mov    %r12d,%edi
    25cc:	e8 9f ec ff ff       	callq  1270 <close@plt>
    25d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    25d6:	e9 db 01 00 00       	jmpq   27b6 <submitr+0x507>
    25db:	49 0f a3 c5          	bt     %rax,%r13
    25df:	73 21                	jae    2602 <submitr+0x353>
    25e1:	44 88 45 00          	mov    %r8b,0x0(%rbp)
    25e5:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
    25e9:	48 83 c3 01          	add    $0x1,%rbx
    25ed:	4c 39 f3             	cmp    %r14,%rbx
    25f0:	0f 84 48 03 00 00    	je     293e <submitr+0x68f>
    25f6:	44 0f b6 03          	movzbl (%rbx),%r8d
    25fa:	41 8d 40 d6          	lea    -0x2a(%r8),%eax
    25fe:	3c 35                	cmp    $0x35,%al
    2600:	76 d9                	jbe    25db <submitr+0x32c>
    2602:	44 89 c0             	mov    %r8d,%eax
    2605:	83 e0 df             	and    $0xffffffdf,%eax
    2608:	83 e8 41             	sub    $0x41,%eax
    260b:	3c 19                	cmp    $0x19,%al
    260d:	76 d2                	jbe    25e1 <submitr+0x332>
    260f:	41 80 f8 20          	cmp    $0x20,%r8b
    2613:	74 63                	je     2678 <submitr+0x3c9>
    2615:	41 8d 40 e0          	lea    -0x20(%r8),%eax
    2619:	3c 5f                	cmp    $0x5f,%al
    261b:	76 0a                	jbe    2627 <submitr+0x378>
    261d:	41 80 f8 09          	cmp    $0x9,%r8b
    2621:	0f 85 8a 02 00 00    	jne    28b1 <submitr+0x602>
    2627:	48 8d bc 24 50 80 00 	lea    0x8050(%rsp),%rdi
    262e:	00 
    262f:	45 0f b6 c0          	movzbl %r8b,%r8d
    2633:	48 8d 0d dc 0f 00 00 	lea    0xfdc(%rip),%rcx        # 3616 <array.3499+0x446>
    263a:	ba 08 00 00 00       	mov    $0x8,%edx
    263f:	be 01 00 00 00       	mov    $0x1,%esi
    2644:	b8 00 00 00 00       	mov    $0x0,%eax
    2649:	e8 32 ed ff ff       	callq  1380 <__sprintf_chk@plt>
    264e:	0f b6 84 24 50 80 00 	movzbl 0x8050(%rsp),%eax
    2655:	00 
    2656:	88 45 00             	mov    %al,0x0(%rbp)
    2659:	0f b6 84 24 51 80 00 	movzbl 0x8051(%rsp),%eax
    2660:	00 
    2661:	88 45 01             	mov    %al,0x1(%rbp)
    2664:	0f b6 84 24 52 80 00 	movzbl 0x8052(%rsp),%eax
    266b:	00 
    266c:	88 45 02             	mov    %al,0x2(%rbp)
    266f:	48 8d 6d 03          	lea    0x3(%rbp),%rbp
    2673:	e9 71 ff ff ff       	jmpq   25e9 <submitr+0x33a>
    2678:	c6 45 00 2b          	movb   $0x2b,0x0(%rbp)
    267c:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
    2680:	e9 64 ff ff ff       	jmpq   25e9 <submitr+0x33a>
    2685:	48 01 c5             	add    %rax,%rbp
    2688:	48 29 c3             	sub    %rax,%rbx
    268b:	0f 84 25 03 00 00    	je     29b6 <submitr+0x707>
    2691:	48 89 da             	mov    %rbx,%rdx
    2694:	48 89 ee             	mov    %rbp,%rsi
    2697:	44 89 e7             	mov    %r12d,%edi
    269a:	e8 a1 eb ff ff       	callq  1240 <write@plt>
    269f:	48 85 c0             	test   %rax,%rax
    26a2:	7f e1                	jg     2685 <submitr+0x3d6>
    26a4:	e8 67 eb ff ff       	callq  1210 <__errno_location@plt>
    26a9:	83 38 04             	cmpl   $0x4,(%rax)
    26ac:	0f 85 a0 01 00 00    	jne    2852 <submitr+0x5a3>
    26b2:	4c 89 e8             	mov    %r13,%rax
    26b5:	eb ce                	jmp    2685 <submitr+0x3d6>
    26b7:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    26be:	3a 20 43 
    26c1:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    26c8:	20 75 6e 
    26cb:	49 89 07             	mov    %rax,(%r15)
    26ce:	49 89 57 08          	mov    %rdx,0x8(%r15)
    26d2:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    26d9:	74 6f 20 
    26dc:	48 ba 72 65 61 64 20 	movabs $0x7269662064616572,%rdx
    26e3:	66 69 72 
    26e6:	49 89 47 10          	mov    %rax,0x10(%r15)
    26ea:	49 89 57 18          	mov    %rdx,0x18(%r15)
    26ee:	48 b8 73 74 20 68 65 	movabs $0x6564616568207473,%rax
    26f5:	61 64 65 
    26f8:	48 ba 72 20 66 72 6f 	movabs $0x73206d6f72662072,%rdx
    26ff:	6d 20 73 
    2702:	49 89 47 20          	mov    %rax,0x20(%r15)
    2706:	49 89 57 28          	mov    %rdx,0x28(%r15)
    270a:	41 c7 47 30 65 72 76 	movl   $0x65767265,0x30(%r15)
    2711:	65 
    2712:	66 41 c7 47 34 72 00 	movw   $0x72,0x34(%r15)
    2719:	44 89 e7             	mov    %r12d,%edi
    271c:	e8 4f eb ff ff       	callq  1270 <close@plt>
    2721:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2726:	e9 8b 00 00 00       	jmpq   27b6 <submitr+0x507>
    272b:	4c 8d 8c 24 50 80 00 	lea    0x8050(%rsp),%r9
    2732:	00 
    2733:	48 8d 0d 2e 0e 00 00 	lea    0xe2e(%rip),%rcx        # 3568 <array.3499+0x398>
    273a:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
    2741:	be 01 00 00 00       	mov    $0x1,%esi
    2746:	4c 89 ff             	mov    %r15,%rdi
    2749:	b8 00 00 00 00       	mov    $0x0,%eax
    274e:	e8 2d ec ff ff       	callq  1380 <__sprintf_chk@plt>
    2753:	44 89 e7             	mov    %r12d,%edi
    2756:	e8 15 eb ff ff       	callq  1270 <close@plt>
    275b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2760:	eb 54                	jmp    27b6 <submitr+0x507>
    2762:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    2769:	00 
    276a:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    276f:	ba 00 20 00 00       	mov    $0x2000,%edx
    2774:	e8 6d fa ff ff       	callq  21e6 <rio_readlineb>
    2779:	48 85 c0             	test   %rax,%rax
    277c:	7e 61                	jle    27df <submitr+0x530>
    277e:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    2785:	00 
    2786:	4c 89 ff             	mov    %r15,%rdi
    2789:	e8 92 ea ff ff       	callq  1220 <strcpy@plt>
    278e:	44 89 e7             	mov    %r12d,%edi
    2791:	e8 da ea ff ff       	callq  1270 <close@plt>
    2796:	b9 03 00 00 00       	mov    $0x3,%ecx
    279b:	48 8d 3d 8f 0e 00 00 	lea    0xe8f(%rip),%rdi        # 3631 <array.3499+0x461>
    27a2:	4c 89 fe             	mov    %r15,%rsi
    27a5:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
    27a7:	0f 97 c0             	seta   %al
    27aa:	1c 00                	sbb    $0x0,%al
    27ac:	84 c0                	test   %al,%al
    27ae:	0f 95 c0             	setne  %al
    27b1:	0f b6 c0             	movzbl %al,%eax
    27b4:	f7 d8                	neg    %eax
    27b6:	48 8b 94 24 58 a0 00 	mov    0xa058(%rsp),%rdx
    27bd:	00 
    27be:	64 48 33 14 25 28 00 	xor    %fs:0x28,%rdx
    27c5:	00 00 
    27c7:	0f 85 0c 03 00 00    	jne    2ad9 <submitr+0x82a>
    27cd:	48 81 c4 68 a0 00 00 	add    $0xa068,%rsp
    27d4:	5b                   	pop    %rbx
    27d5:	5d                   	pop    %rbp
    27d6:	41 5c                	pop    %r12
    27d8:	41 5d                	pop    %r13
    27da:	41 5e                	pop    %r14
    27dc:	41 5f                	pop    %r15
    27de:	c3                   	retq   
    27df:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    27e6:	3a 20 43 
    27e9:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    27f0:	20 75 6e 
    27f3:	49 89 07             	mov    %rax,(%r15)
    27f6:	49 89 57 08          	mov    %rdx,0x8(%r15)
    27fa:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2801:	74 6f 20 
    2804:	48 ba 72 65 61 64 20 	movabs $0x6174732064616572,%rdx
    280b:	73 74 61 
    280e:	49 89 47 10          	mov    %rax,0x10(%r15)
    2812:	49 89 57 18          	mov    %rdx,0x18(%r15)
    2816:	48 b8 74 75 73 20 6d 	movabs $0x7373656d20737574,%rax
    281d:	65 73 73 
    2820:	48 ba 61 67 65 20 66 	movabs $0x6d6f726620656761,%rdx
    2827:	72 6f 6d 
    282a:	49 89 47 20          	mov    %rax,0x20(%r15)
    282e:	49 89 57 28          	mov    %rdx,0x28(%r15)
    2832:	48 b8 20 73 65 72 76 	movabs $0x72657672657320,%rax
    2839:	65 72 00 
    283c:	49 89 47 30          	mov    %rax,0x30(%r15)
    2840:	44 89 e7             	mov    %r12d,%edi
    2843:	e8 28 ea ff ff       	callq  1270 <close@plt>
    2848:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    284d:	e9 64 ff ff ff       	jmpq   27b6 <submitr+0x507>
    2852:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    2859:	3a 20 43 
    285c:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    2863:	20 75 6e 
    2866:	49 89 07             	mov    %rax,(%r15)
    2869:	49 89 57 08          	mov    %rdx,0x8(%r15)
    286d:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2874:	74 6f 20 
    2877:	48 ba 77 72 69 74 65 	movabs $0x6f74206574697277,%rdx
    287e:	20 74 6f 
    2881:	49 89 47 10          	mov    %rax,0x10(%r15)
    2885:	49 89 57 18          	mov    %rdx,0x18(%r15)
    2889:	48 b8 20 74 68 65 20 	movabs $0x7265732065687420,%rax
    2890:	73 65 72 
    2893:	49 89 47 20          	mov    %rax,0x20(%r15)
    2897:	41 c7 47 28 76 65 72 	movl   $0x726576,0x28(%r15)
    289e:	00 
    289f:	44 89 e7             	mov    %r12d,%edi
    28a2:	e8 c9 e9 ff ff       	callq  1270 <close@plt>
    28a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    28ac:	e9 05 ff ff ff       	jmpq   27b6 <submitr+0x507>
    28b1:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
    28b8:	3a 20 52 
    28bb:	48 ba 65 73 75 6c 74 	movabs $0x747320746c757365,%rdx
    28c2:	20 73 74 
    28c5:	49 89 07             	mov    %rax,(%r15)
    28c8:	49 89 57 08          	mov    %rdx,0x8(%r15)
    28cc:	48 b8 72 69 6e 67 20 	movabs $0x6e6f6320676e6972,%rax
    28d3:	63 6f 6e 
    28d6:	48 ba 74 61 69 6e 73 	movabs $0x6e6120736e696174,%rdx
    28dd:	20 61 6e 
    28e0:	49 89 47 10          	mov    %rax,0x10(%r15)
    28e4:	49 89 57 18          	mov    %rdx,0x18(%r15)
    28e8:	48 b8 20 69 6c 6c 65 	movabs $0x6c6167656c6c6920,%rax
    28ef:	67 61 6c 
    28f2:	48 ba 20 6f 72 20 75 	movabs $0x72706e7520726f20,%rdx
    28f9:	6e 70 72 
    28fc:	49 89 47 20          	mov    %rax,0x20(%r15)
    2900:	49 89 57 28          	mov    %rdx,0x28(%r15)
    2904:	48 b8 69 6e 74 61 62 	movabs $0x20656c6261746e69,%rax
    290b:	6c 65 20 
    290e:	48 ba 63 68 61 72 61 	movabs $0x6574636172616863,%rdx
    2915:	63 74 65 
    2918:	49 89 47 30          	mov    %rax,0x30(%r15)
    291c:	49 89 57 38          	mov    %rdx,0x38(%r15)
    2920:	66 41 c7 47 40 72 2e 	movw   $0x2e72,0x40(%r15)
    2927:	41 c6 47 42 00       	movb   $0x0,0x42(%r15)
    292c:	44 89 e7             	mov    %r12d,%edi
    292f:	e8 3c e9 ff ff       	callq  1270 <close@plt>
    2934:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2939:	e9 78 fe ff ff       	jmpq   27b6 <submitr+0x507>
    293e:	48 8d 9c 24 50 20 00 	lea    0x2050(%rsp),%rbx
    2945:	00 
    2946:	48 83 ec 08          	sub    $0x8,%rsp
    294a:	48 8d 84 24 58 40 00 	lea    0x4058(%rsp),%rax
    2951:	00 
    2952:	50                   	push   %rax
    2953:	ff 74 24 20          	pushq  0x20(%rsp)
    2957:	ff 74 24 30          	pushq  0x30(%rsp)
    295b:	4c 8b 4c 24 28       	mov    0x28(%rsp),%r9
    2960:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
    2965:	48 8d 0d 2c 0c 00 00 	lea    0xc2c(%rip),%rcx        # 3598 <array.3499+0x3c8>
    296c:	ba 00 20 00 00       	mov    $0x2000,%edx
    2971:	be 01 00 00 00       	mov    $0x1,%esi
    2976:	48 89 df             	mov    %rbx,%rdi
    2979:	b8 00 00 00 00       	mov    $0x0,%eax
    297e:	e8 fd e9 ff ff       	callq  1380 <__sprintf_chk@plt>
    2983:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
    298a:	b8 00 00 00 00       	mov    $0x0,%eax
    298f:	48 89 df             	mov    %rbx,%rdi
    2992:	f2 ae                	repnz scas %es:(%rdi),%al
    2994:	48 f7 d1             	not    %rcx
    2997:	48 83 c4 20          	add    $0x20,%rsp
    299b:	48 8d ac 24 50 20 00 	lea    0x2050(%rsp),%rbp
    29a2:	00 
    29a3:	41 bd 00 00 00 00    	mov    $0x0,%r13d
    29a9:	48 89 cb             	mov    %rcx,%rbx
    29ac:	48 83 eb 01          	sub    $0x1,%rbx
    29b0:	0f 85 db fc ff ff    	jne    2691 <submitr+0x3e2>
    29b6:	44 89 64 24 40       	mov    %r12d,0x40(%rsp)
    29bb:	c7 44 24 44 00 00 00 	movl   $0x0,0x44(%rsp)
    29c2:	00 
    29c3:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    29c8:	48 8d 44 24 50       	lea    0x50(%rsp),%rax
    29cd:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    29d2:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    29d9:	00 
    29da:	ba 00 20 00 00       	mov    $0x2000,%edx
    29df:	e8 02 f8 ff ff       	callq  21e6 <rio_readlineb>
    29e4:	48 85 c0             	test   %rax,%rax
    29e7:	0f 8e ca fc ff ff    	jle    26b7 <submitr+0x408>
    29ed:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
    29f2:	48 8d 94 24 50 60 00 	lea    0x6050(%rsp),%rdx
    29f9:	00 
    29fa:	48 8d bc 24 50 20 00 	lea    0x2050(%rsp),%rdi
    2a01:	00 
    2a02:	4c 8d 84 24 50 80 00 	lea    0x8050(%rsp),%r8
    2a09:	00 
    2a0a:	48 8d 35 0c 0c 00 00 	lea    0xc0c(%rip),%rsi        # 361d <array.3499+0x44d>
    2a11:	b8 00 00 00 00       	mov    $0x0,%eax
    2a16:	e8 d5 e8 ff ff       	callq  12f0 <__isoc99_sscanf@plt>
    2a1b:	44 8b 44 24 2c       	mov    0x2c(%rsp),%r8d
    2a20:	41 81 f8 c8 00 00 00 	cmp    $0xc8,%r8d
    2a27:	0f 85 fe fc ff ff    	jne    272b <submitr+0x47c>
    2a2d:	48 8d 1d fa 0b 00 00 	lea    0xbfa(%rip),%rbx        # 362e <array.3499+0x45e>
    2a34:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    2a3b:	00 
    2a3c:	b9 03 00 00 00       	mov    $0x3,%ecx
    2a41:	48 89 df             	mov    %rbx,%rdi
    2a44:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
    2a46:	0f 97 c0             	seta   %al
    2a49:	1c 00                	sbb    $0x0,%al
    2a4b:	84 c0                	test   %al,%al
    2a4d:	0f 84 0f fd ff ff    	je     2762 <submitr+0x4b3>
    2a53:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    2a5a:	00 
    2a5b:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    2a60:	ba 00 20 00 00       	mov    $0x2000,%edx
    2a65:	e8 7c f7 ff ff       	callq  21e6 <rio_readlineb>
    2a6a:	48 85 c0             	test   %rax,%rax
    2a6d:	7f c5                	jg     2a34 <submitr+0x785>
    2a6f:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    2a76:	3a 20 43 
    2a79:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    2a80:	20 75 6e 
    2a83:	49 89 07             	mov    %rax,(%r15)
    2a86:	49 89 57 08          	mov    %rdx,0x8(%r15)
    2a8a:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2a91:	74 6f 20 
    2a94:	48 ba 72 65 61 64 20 	movabs $0x6165682064616572,%rdx
    2a9b:	68 65 61 
    2a9e:	49 89 47 10          	mov    %rax,0x10(%r15)
    2aa2:	49 89 57 18          	mov    %rdx,0x18(%r15)
    2aa6:	48 b8 64 65 72 73 20 	movabs $0x6f72662073726564,%rax
    2aad:	66 72 6f 
    2ab0:	48 ba 6d 20 73 65 72 	movabs $0x726576726573206d,%rdx
    2ab7:	76 65 72 
    2aba:	49 89 47 20          	mov    %rax,0x20(%r15)
    2abe:	49 89 57 28          	mov    %rdx,0x28(%r15)
    2ac2:	41 c6 47 30 00       	movb   $0x0,0x30(%r15)
    2ac7:	44 89 e7             	mov    %r12d,%edi
    2aca:	e8 a1 e7 ff ff       	callq  1270 <close@plt>
    2acf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2ad4:	e9 dd fc ff ff       	jmpq   27b6 <submitr+0x507>
    2ad9:	e8 72 e7 ff ff       	callq  1250 <__stack_chk_fail@plt>

0000000000002ade <init_timeout>:
    2ade:	f3 0f 1e fa          	endbr64 
    2ae2:	85 ff                	test   %edi,%edi
    2ae4:	75 01                	jne    2ae7 <init_timeout+0x9>
    2ae6:	c3                   	retq   
    2ae7:	53                   	push   %rbx
    2ae8:	89 fb                	mov    %edi,%ebx
    2aea:	48 8d 35 bf f6 ff ff 	lea    -0x941(%rip),%rsi        # 21b0 <sigalrm_handler>
    2af1:	bf 0e 00 00 00       	mov    $0xe,%edi
    2af6:	e8 a5 e7 ff ff       	callq  12a0 <signal@plt>
    2afb:	85 db                	test   %ebx,%ebx
    2afd:	bf 00 00 00 00       	mov    $0x0,%edi
    2b02:	0f 49 fb             	cmovns %ebx,%edi
    2b05:	e8 56 e7 ff ff       	callq  1260 <alarm@plt>
    2b0a:	5b                   	pop    %rbx
    2b0b:	c3                   	retq   

0000000000002b0c <init_driver>:
    2b0c:	f3 0f 1e fa          	endbr64 
    2b10:	41 54                	push   %r12
    2b12:	55                   	push   %rbp
    2b13:	53                   	push   %rbx
    2b14:	48 83 ec 20          	sub    $0x20,%rsp
    2b18:	48 89 fd             	mov    %rdi,%rbp
    2b1b:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    2b22:	00 00 
    2b24:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    2b29:	31 c0                	xor    %eax,%eax
    2b2b:	be 01 00 00 00       	mov    $0x1,%esi
    2b30:	bf 0d 00 00 00       	mov    $0xd,%edi
    2b35:	e8 66 e7 ff ff       	callq  12a0 <signal@plt>
    2b3a:	be 01 00 00 00       	mov    $0x1,%esi
    2b3f:	bf 1d 00 00 00       	mov    $0x1d,%edi
    2b44:	e8 57 e7 ff ff       	callq  12a0 <signal@plt>
    2b49:	be 01 00 00 00       	mov    $0x1,%esi
    2b4e:	bf 1d 00 00 00       	mov    $0x1d,%edi
    2b53:	e8 48 e7 ff ff       	callq  12a0 <signal@plt>
    2b58:	ba 00 00 00 00       	mov    $0x0,%edx
    2b5d:	be 01 00 00 00       	mov    $0x1,%esi
    2b62:	bf 02 00 00 00       	mov    $0x2,%edi
    2b67:	e8 24 e8 ff ff       	callq  1390 <socket@plt>
    2b6c:	85 c0                	test   %eax,%eax
    2b6e:	0f 88 9c 00 00 00    	js     2c10 <init_driver+0x104>
    2b74:	89 c3                	mov    %eax,%ebx
    2b76:	48 8d 3d 1a 09 00 00 	lea    0x91a(%rip),%rdi        # 3497 <array.3499+0x2c7>
    2b7d:	e8 2e e7 ff ff       	callq  12b0 <gethostbyname@plt>
    2b82:	48 85 c0             	test   %rax,%rax
    2b85:	0f 84 d1 00 00 00    	je     2c5c <init_driver+0x150>
    2b8b:	49 89 e4             	mov    %rsp,%r12
    2b8e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    2b95:	00 
    2b96:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    2b9d:	00 00 
    2b9f:	66 c7 04 24 02 00    	movw   $0x2,(%rsp)
    2ba5:	48 63 50 14          	movslq 0x14(%rax),%rdx
    2ba9:	48 8b 40 18          	mov    0x18(%rax),%rax
    2bad:	48 8d 7c 24 04       	lea    0x4(%rsp),%rdi
    2bb2:	b9 0c 00 00 00       	mov    $0xc,%ecx
    2bb7:	48 8b 30             	mov    (%rax),%rsi
    2bba:	e8 01 e7 ff ff       	callq  12c0 <__memmove_chk@plt>
    2bbf:	66 c7 44 24 02 3b 6e 	movw   $0x6e3b,0x2(%rsp)
    2bc6:	ba 10 00 00 00       	mov    $0x10,%edx
    2bcb:	4c 89 e6             	mov    %r12,%rsi
    2bce:	89 df                	mov    %ebx,%edi
    2bd0:	e8 6b e7 ff ff       	callq  1340 <connect@plt>
    2bd5:	85 c0                	test   %eax,%eax
    2bd7:	0f 88 e7 00 00 00    	js     2cc4 <init_driver+0x1b8>
    2bdd:	89 df                	mov    %ebx,%edi
    2bdf:	e8 8c e6 ff ff       	callq  1270 <close@plt>
    2be4:	66 c7 45 00 4f 4b    	movw   $0x4b4f,0x0(%rbp)
    2bea:	c6 45 02 00          	movb   $0x0,0x2(%rbp)
    2bee:	b8 00 00 00 00       	mov    $0x0,%eax
    2bf3:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    2bf8:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
    2bff:	00 00 
    2c01:	0f 85 f5 00 00 00    	jne    2cfc <init_driver+0x1f0>
    2c07:	48 83 c4 20          	add    $0x20,%rsp
    2c0b:	5b                   	pop    %rbx
    2c0c:	5d                   	pop    %rbp
    2c0d:	41 5c                	pop    %r12
    2c0f:	c3                   	retq   
    2c10:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    2c17:	3a 20 43 
    2c1a:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    2c21:	20 75 6e 
    2c24:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2c28:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2c2c:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2c33:	74 6f 20 
    2c36:	48 ba 63 72 65 61 74 	movabs $0x7320657461657263,%rdx
    2c3d:	65 20 73 
    2c40:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2c44:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2c48:	c7 45 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%rbp)
    2c4f:	66 c7 45 24 74 00    	movw   $0x74,0x24(%rbp)
    2c55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2c5a:	eb 97                	jmp    2bf3 <init_driver+0xe7>
    2c5c:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
    2c63:	3a 20 44 
    2c66:	48 ba 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rdx
    2c6d:	20 75 6e 
    2c70:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2c74:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2c78:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2c7f:	74 6f 20 
    2c82:	48 ba 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rdx
    2c89:	76 65 20 
    2c8c:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2c90:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2c94:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
    2c9b:	72 20 61 
    2c9e:	48 89 45 20          	mov    %rax,0x20(%rbp)
    2ca2:	c7 45 28 64 64 72 65 	movl   $0x65726464,0x28(%rbp)
    2ca9:	66 c7 45 2c 73 73    	movw   $0x7373,0x2c(%rbp)
    2caf:	c6 45 2e 00          	movb   $0x0,0x2e(%rbp)
    2cb3:	89 df                	mov    %ebx,%edi
    2cb5:	e8 b6 e5 ff ff       	callq  1270 <close@plt>
    2cba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2cbf:	e9 2f ff ff ff       	jmpq   2bf3 <init_driver+0xe7>
    2cc4:	4c 8d 05 cc 07 00 00 	lea    0x7cc(%rip),%r8        # 3497 <array.3499+0x2c7>
    2ccb:	48 8d 0d 1e 09 00 00 	lea    0x91e(%rip),%rcx        # 35f0 <array.3499+0x420>
    2cd2:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
    2cd9:	be 01 00 00 00       	mov    $0x1,%esi
    2cde:	48 89 ef             	mov    %rbp,%rdi
    2ce1:	b8 00 00 00 00       	mov    $0x0,%eax
    2ce6:	e8 95 e6 ff ff       	callq  1380 <__sprintf_chk@plt>
    2ceb:	89 df                	mov    %ebx,%edi
    2ced:	e8 7e e5 ff ff       	callq  1270 <close@plt>
    2cf2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2cf7:	e9 f7 fe ff ff       	jmpq   2bf3 <init_driver+0xe7>
    2cfc:	e8 4f e5 ff ff       	callq  1250 <__stack_chk_fail@plt>

0000000000002d01 <driver_post>:
    2d01:	f3 0f 1e fa          	endbr64 
    2d05:	53                   	push   %rbx
    2d06:	4c 89 c3             	mov    %r8,%rbx
    2d09:	85 c9                	test   %ecx,%ecx
    2d0b:	75 17                	jne    2d24 <driver_post+0x23>
    2d0d:	48 85 ff             	test   %rdi,%rdi
    2d10:	74 05                	je     2d17 <driver_post+0x16>
    2d12:	80 3f 00             	cmpb   $0x0,(%rdi)
    2d15:	75 33                	jne    2d4a <driver_post+0x49>
    2d17:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
    2d1c:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
    2d20:	89 c8                	mov    %ecx,%eax
    2d22:	5b                   	pop    %rbx
    2d23:	c3                   	retq   
    2d24:	48 8d 35 09 09 00 00 	lea    0x909(%rip),%rsi        # 3634 <array.3499+0x464>
    2d2b:	bf 01 00 00 00       	mov    $0x1,%edi
    2d30:	b8 00 00 00 00       	mov    $0x0,%eax
    2d35:	e8 c6 e5 ff ff       	callq  1300 <__printf_chk@plt>
    2d3a:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
    2d3f:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
    2d43:	b8 00 00 00 00       	mov    $0x0,%eax
    2d48:	eb d8                	jmp    2d22 <driver_post+0x21>
    2d4a:	41 50                	push   %r8
    2d4c:	52                   	push   %rdx
    2d4d:	4c 8d 0d f7 08 00 00 	lea    0x8f7(%rip),%r9        # 364b <array.3499+0x47b>
    2d54:	49 89 f0             	mov    %rsi,%r8
    2d57:	48 89 f9             	mov    %rdi,%rcx
    2d5a:	48 8d 15 f1 08 00 00 	lea    0x8f1(%rip),%rdx        # 3652 <array.3499+0x482>
    2d61:	be 6e 3b 00 00       	mov    $0x3b6e,%esi
    2d66:	48 8d 3d 2a 07 00 00 	lea    0x72a(%rip),%rdi        # 3497 <array.3499+0x2c7>
    2d6d:	e8 3d f5 ff ff       	callq  22af <submitr>
    2d72:	48 83 c4 10          	add    $0x10,%rsp
    2d76:	eb aa                	jmp    2d22 <driver_post+0x21>
    2d78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    2d7f:	00 

0000000000002d80 <__libc_csu_init>:
    2d80:	f3 0f 1e fa          	endbr64 
    2d84:	41 57                	push   %r15
    2d86:	4c 8d 3d 5b 1f 00 00 	lea    0x1f5b(%rip),%r15        # 4ce8 <__frame_dummy_init_array_entry>
    2d8d:	41 56                	push   %r14
    2d8f:	49 89 d6             	mov    %rdx,%r14
    2d92:	41 55                	push   %r13
    2d94:	49 89 f5             	mov    %rsi,%r13
    2d97:	41 54                	push   %r12
    2d99:	41 89 fc             	mov    %edi,%r12d
    2d9c:	55                   	push   %rbp
    2d9d:	48 8d 2d 4c 1f 00 00 	lea    0x1f4c(%rip),%rbp        # 4cf0 <__do_global_dtors_aux_fini_array_entry>
    2da4:	53                   	push   %rbx
    2da5:	4c 29 fd             	sub    %r15,%rbp
    2da8:	48 83 ec 08          	sub    $0x8,%rsp
    2dac:	e8 4f e2 ff ff       	callq  1000 <_init>
    2db1:	48 c1 fd 03          	sar    $0x3,%rbp
    2db5:	74 1f                	je     2dd6 <__libc_csu_init+0x56>
    2db7:	31 db                	xor    %ebx,%ebx
    2db9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    2dc0:	4c 89 f2             	mov    %r14,%rdx
    2dc3:	4c 89 ee             	mov    %r13,%rsi
    2dc6:	44 89 e7             	mov    %r12d,%edi
    2dc9:	41 ff 14 df          	callq  *(%r15,%rbx,8)
    2dcd:	48 83 c3 01          	add    $0x1,%rbx
    2dd1:	48 39 dd             	cmp    %rbx,%rbp
    2dd4:	75 ea                	jne    2dc0 <__libc_csu_init+0x40>
    2dd6:	48 83 c4 08          	add    $0x8,%rsp
    2dda:	5b                   	pop    %rbx
    2ddb:	5d                   	pop    %rbp
    2ddc:	41 5c                	pop    %r12
    2dde:	41 5d                	pop    %r13
    2de0:	41 5e                	pop    %r14
    2de2:	41 5f                	pop    %r15
    2de4:	c3                   	retq   
    2de5:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
    2dec:	00 00 00 00 

0000000000002df0 <__libc_csu_fini>:
    2df0:	f3 0f 1e fa          	endbr64 
    2df4:	c3                   	retq   

Disassembly of section .fini:

0000000000002df8 <_fini>:
    2df8:	f3 0f 1e fa          	endbr64 
    2dfc:	48 83 ec 08          	sub    $0x8,%rsp
    2e00:	48 83 c4 08          	add    $0x8,%rsp
    2e04:	c3                   	retq   
