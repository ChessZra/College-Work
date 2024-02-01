
rtarget:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64 
    1004:	48 83 ec 08          	sub    $0x8,%rsp
    1008:	48 8b 05 d9 5f 00 00 	mov    0x5fd9(%rip),%rax        # 6fe8 <__gmon_start__>
    100f:	48 85 c0             	test   %rax,%rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	callq  *%rax
    1016:	48 83 c4 08          	add    $0x8,%rsp
    101a:	c3                   	retq   

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	ff 35 9a 5e 00 00    	pushq  0x5e9a(%rip)        # 6ec0 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	f2 ff 25 9b 5e 00 00 	bnd jmpq *0x5e9b(%rip)        # 6ec8 <_GLOBAL_OFFSET_TABLE_+0x10>
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
    11e0:	f3 0f 1e fa          	endbr64 
    11e4:	68 1b 00 00 00       	pushq  $0x1b
    11e9:	f2 e9 31 fe ff ff    	bnd jmpq 1020 <.plt>
    11ef:	90                   	nop
    11f0:	f3 0f 1e fa          	endbr64 
    11f4:	68 1c 00 00 00       	pushq  $0x1c
    11f9:	f2 e9 21 fe ff ff    	bnd jmpq 1020 <.plt>
    11ff:	90                   	nop
    1200:	f3 0f 1e fa          	endbr64 
    1204:	68 1d 00 00 00       	pushq  $0x1d
    1209:	f2 e9 11 fe ff ff    	bnd jmpq 1020 <.plt>
    120f:	90                   	nop
    1210:	f3 0f 1e fa          	endbr64 
    1214:	68 1e 00 00 00       	pushq  $0x1e
    1219:	f2 e9 01 fe ff ff    	bnd jmpq 1020 <.plt>
    121f:	90                   	nop
    1220:	f3 0f 1e fa          	endbr64 
    1224:	68 1f 00 00 00       	pushq  $0x1f
    1229:	f2 e9 f1 fd ff ff    	bnd jmpq 1020 <.plt>
    122f:	90                   	nop
    1230:	f3 0f 1e fa          	endbr64 
    1234:	68 20 00 00 00       	pushq  $0x20
    1239:	f2 e9 e1 fd ff ff    	bnd jmpq 1020 <.plt>
    123f:	90                   	nop

Disassembly of section .plt.got:

0000000000001240 <__cxa_finalize@plt>:
    1240:	f3 0f 1e fa          	endbr64 
    1244:	f2 ff 25 ad 5d 00 00 	bnd jmpq *0x5dad(%rip)        # 6ff8 <__cxa_finalize@GLIBC_2.2.5>
    124b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

Disassembly of section .plt.sec:

0000000000001250 <strcasecmp@plt>:
    1250:	f3 0f 1e fa          	endbr64 
    1254:	f2 ff 25 75 5c 00 00 	bnd jmpq *0x5c75(%rip)        # 6ed0 <strcasecmp@GLIBC_2.2.5>
    125b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001260 <__errno_location@plt>:
    1260:	f3 0f 1e fa          	endbr64 
    1264:	f2 ff 25 6d 5c 00 00 	bnd jmpq *0x5c6d(%rip)        # 6ed8 <__errno_location@GLIBC_2.2.5>
    126b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001270 <srandom@plt>:
    1270:	f3 0f 1e fa          	endbr64 
    1274:	f2 ff 25 65 5c 00 00 	bnd jmpq *0x5c65(%rip)        # 6ee0 <srandom@GLIBC_2.2.5>
    127b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001280 <strncmp@plt>:
    1280:	f3 0f 1e fa          	endbr64 
    1284:	f2 ff 25 5d 5c 00 00 	bnd jmpq *0x5c5d(%rip)        # 6ee8 <strncmp@GLIBC_2.2.5>
    128b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001290 <strcpy@plt>:
    1290:	f3 0f 1e fa          	endbr64 
    1294:	f2 ff 25 55 5c 00 00 	bnd jmpq *0x5c55(%rip)        # 6ef0 <strcpy@GLIBC_2.2.5>
    129b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012a0 <puts@plt>:
    12a0:	f3 0f 1e fa          	endbr64 
    12a4:	f2 ff 25 4d 5c 00 00 	bnd jmpq *0x5c4d(%rip)        # 6ef8 <puts@GLIBC_2.2.5>
    12ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012b0 <write@plt>:
    12b0:	f3 0f 1e fa          	endbr64 
    12b4:	f2 ff 25 45 5c 00 00 	bnd jmpq *0x5c45(%rip)        # 6f00 <write@GLIBC_2.2.5>
    12bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012c0 <__stack_chk_fail@plt>:
    12c0:	f3 0f 1e fa          	endbr64 
    12c4:	f2 ff 25 3d 5c 00 00 	bnd jmpq *0x5c3d(%rip)        # 6f08 <__stack_chk_fail@GLIBC_2.4>
    12cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012d0 <mmap@plt>:
    12d0:	f3 0f 1e fa          	endbr64 
    12d4:	f2 ff 25 35 5c 00 00 	bnd jmpq *0x5c35(%rip)        # 6f10 <mmap@GLIBC_2.2.5>
    12db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012e0 <memset@plt>:
    12e0:	f3 0f 1e fa          	endbr64 
    12e4:	f2 ff 25 2d 5c 00 00 	bnd jmpq *0x5c2d(%rip)        # 6f18 <memset@GLIBC_2.2.5>
    12eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000012f0 <alarm@plt>:
    12f0:	f3 0f 1e fa          	endbr64 
    12f4:	f2 ff 25 25 5c 00 00 	bnd jmpq *0x5c25(%rip)        # 6f20 <alarm@GLIBC_2.2.5>
    12fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001300 <close@plt>:
    1300:	f3 0f 1e fa          	endbr64 
    1304:	f2 ff 25 1d 5c 00 00 	bnd jmpq *0x5c1d(%rip)        # 6f28 <close@GLIBC_2.2.5>
    130b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001310 <read@plt>:
    1310:	f3 0f 1e fa          	endbr64 
    1314:	f2 ff 25 15 5c 00 00 	bnd jmpq *0x5c15(%rip)        # 6f30 <read@GLIBC_2.2.5>
    131b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001320 <signal@plt>:
    1320:	f3 0f 1e fa          	endbr64 
    1324:	f2 ff 25 0d 5c 00 00 	bnd jmpq *0x5c0d(%rip)        # 6f38 <signal@GLIBC_2.2.5>
    132b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001330 <gethostbyname@plt>:
    1330:	f3 0f 1e fa          	endbr64 
    1334:	f2 ff 25 05 5c 00 00 	bnd jmpq *0x5c05(%rip)        # 6f40 <gethostbyname@GLIBC_2.2.5>
    133b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001340 <__memmove_chk@plt>:
    1340:	f3 0f 1e fa          	endbr64 
    1344:	f2 ff 25 fd 5b 00 00 	bnd jmpq *0x5bfd(%rip)        # 6f48 <__memmove_chk@GLIBC_2.3.4>
    134b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001350 <strtol@plt>:
    1350:	f3 0f 1e fa          	endbr64 
    1354:	f2 ff 25 f5 5b 00 00 	bnd jmpq *0x5bf5(%rip)        # 6f50 <strtol@GLIBC_2.2.5>
    135b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001360 <memcpy@plt>:
    1360:	f3 0f 1e fa          	endbr64 
    1364:	f2 ff 25 ed 5b 00 00 	bnd jmpq *0x5bed(%rip)        # 6f58 <memcpy@GLIBC_2.14>
    136b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001370 <time@plt>:
    1370:	f3 0f 1e fa          	endbr64 
    1374:	f2 ff 25 e5 5b 00 00 	bnd jmpq *0x5be5(%rip)        # 6f60 <time@GLIBC_2.2.5>
    137b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001380 <random@plt>:
    1380:	f3 0f 1e fa          	endbr64 
    1384:	f2 ff 25 dd 5b 00 00 	bnd jmpq *0x5bdd(%rip)        # 6f68 <random@GLIBC_2.2.5>
    138b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001390 <__isoc99_sscanf@plt>:
    1390:	f3 0f 1e fa          	endbr64 
    1394:	f2 ff 25 d5 5b 00 00 	bnd jmpq *0x5bd5(%rip)        # 6f70 <__isoc99_sscanf@GLIBC_2.7>
    139b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000013a0 <munmap@plt>:
    13a0:	f3 0f 1e fa          	endbr64 
    13a4:	f2 ff 25 cd 5b 00 00 	bnd jmpq *0x5bcd(%rip)        # 6f78 <munmap@GLIBC_2.2.5>
    13ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000013b0 <__printf_chk@plt>:
    13b0:	f3 0f 1e fa          	endbr64 
    13b4:	f2 ff 25 c5 5b 00 00 	bnd jmpq *0x5bc5(%rip)        # 6f80 <__printf_chk@GLIBC_2.3.4>
    13bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000013c0 <fopen@plt>:
    13c0:	f3 0f 1e fa          	endbr64 
    13c4:	f2 ff 25 bd 5b 00 00 	bnd jmpq *0x5bbd(%rip)        # 6f88 <fopen@GLIBC_2.2.5>
    13cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000013d0 <getopt@plt>:
    13d0:	f3 0f 1e fa          	endbr64 
    13d4:	f2 ff 25 b5 5b 00 00 	bnd jmpq *0x5bb5(%rip)        # 6f90 <getopt@GLIBC_2.2.5>
    13db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000013e0 <strtoul@plt>:
    13e0:	f3 0f 1e fa          	endbr64 
    13e4:	f2 ff 25 ad 5b 00 00 	bnd jmpq *0x5bad(%rip)        # 6f98 <strtoul@GLIBC_2.2.5>
    13eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000013f0 <gethostname@plt>:
    13f0:	f3 0f 1e fa          	endbr64 
    13f4:	f2 ff 25 a5 5b 00 00 	bnd jmpq *0x5ba5(%rip)        # 6fa0 <gethostname@GLIBC_2.2.5>
    13fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001400 <exit@plt>:
    1400:	f3 0f 1e fa          	endbr64 
    1404:	f2 ff 25 9d 5b 00 00 	bnd jmpq *0x5b9d(%rip)        # 6fa8 <exit@GLIBC_2.2.5>
    140b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001410 <connect@plt>:
    1410:	f3 0f 1e fa          	endbr64 
    1414:	f2 ff 25 95 5b 00 00 	bnd jmpq *0x5b95(%rip)        # 6fb0 <connect@GLIBC_2.2.5>
    141b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001420 <__fprintf_chk@plt>:
    1420:	f3 0f 1e fa          	endbr64 
    1424:	f2 ff 25 8d 5b 00 00 	bnd jmpq *0x5b8d(%rip)        # 6fb8 <__fprintf_chk@GLIBC_2.3.4>
    142b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001430 <getc@plt>:
    1430:	f3 0f 1e fa          	endbr64 
    1434:	f2 ff 25 85 5b 00 00 	bnd jmpq *0x5b85(%rip)        # 6fc0 <getc@GLIBC_2.2.5>
    143b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001440 <__sprintf_chk@plt>:
    1440:	f3 0f 1e fa          	endbr64 
    1444:	f2 ff 25 7d 5b 00 00 	bnd jmpq *0x5b7d(%rip)        # 6fc8 <__sprintf_chk@GLIBC_2.3.4>
    144b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001450 <socket@plt>:
    1450:	f3 0f 1e fa          	endbr64 
    1454:	f2 ff 25 75 5b 00 00 	bnd jmpq *0x5b75(%rip)        # 6fd0 <socket@GLIBC_2.2.5>
    145b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

Disassembly of section .text:

0000000000001460 <_start>:
    1460:	f3 0f 1e fa          	endbr64 
    1464:	31 ed                	xor    %ebp,%ebp
    1466:	49 89 d1             	mov    %rdx,%r9
    1469:	5e                   	pop    %rsi
    146a:	48 89 e2             	mov    %rsp,%rdx
    146d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    1471:	50                   	push   %rax
    1472:	54                   	push   %rsp
    1473:	4c 8d 05 46 22 00 00 	lea    0x2246(%rip),%r8        # 36c0 <__libc_csu_fini>
    147a:	48 8d 0d cf 21 00 00 	lea    0x21cf(%rip),%rcx        # 3650 <__libc_csu_init>
    1481:	48 8d 3d 04 03 00 00 	lea    0x304(%rip),%rdi        # 178c <main>
    1488:	ff 15 52 5b 00 00    	callq  *0x5b52(%rip)        # 6fe0 <__libc_start_main@GLIBC_2.2.5>
    148e:	f4                   	hlt    
    148f:	90                   	nop

0000000000001490 <deregister_tm_clones>:
    1490:	48 8d 3d d9 5e 00 00 	lea    0x5ed9(%rip),%rdi        # 7370 <__TMC_END__>
    1497:	48 8d 05 d2 5e 00 00 	lea    0x5ed2(%rip),%rax        # 7370 <__TMC_END__>
    149e:	48 39 f8             	cmp    %rdi,%rax
    14a1:	74 15                	je     14b8 <deregister_tm_clones+0x28>
    14a3:	48 8b 05 2e 5b 00 00 	mov    0x5b2e(%rip),%rax        # 6fd8 <_ITM_deregisterTMCloneTable>
    14aa:	48 85 c0             	test   %rax,%rax
    14ad:	74 09                	je     14b8 <deregister_tm_clones+0x28>
    14af:	ff e0                	jmpq   *%rax
    14b1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    14b8:	c3                   	retq   
    14b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000014c0 <register_tm_clones>:
    14c0:	48 8d 3d a9 5e 00 00 	lea    0x5ea9(%rip),%rdi        # 7370 <__TMC_END__>
    14c7:	48 8d 35 a2 5e 00 00 	lea    0x5ea2(%rip),%rsi        # 7370 <__TMC_END__>
    14ce:	48 29 fe             	sub    %rdi,%rsi
    14d1:	48 89 f0             	mov    %rsi,%rax
    14d4:	48 c1 ee 3f          	shr    $0x3f,%rsi
    14d8:	48 c1 f8 03          	sar    $0x3,%rax
    14dc:	48 01 c6             	add    %rax,%rsi
    14df:	48 d1 fe             	sar    %rsi
    14e2:	74 14                	je     14f8 <register_tm_clones+0x38>
    14e4:	48 8b 05 05 5b 00 00 	mov    0x5b05(%rip),%rax        # 6ff0 <_ITM_registerTMCloneTable>
    14eb:	48 85 c0             	test   %rax,%rax
    14ee:	74 08                	je     14f8 <register_tm_clones+0x38>
    14f0:	ff e0                	jmpq   *%rax
    14f2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    14f8:	c3                   	retq   
    14f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001500 <__do_global_dtors_aux>:
    1500:	f3 0f 1e fa          	endbr64 
    1504:	80 3d 9d 5e 00 00 00 	cmpb   $0x0,0x5e9d(%rip)        # 73a8 <completed.8061>
    150b:	75 2b                	jne    1538 <__do_global_dtors_aux+0x38>
    150d:	55                   	push   %rbp
    150e:	48 83 3d e2 5a 00 00 	cmpq   $0x0,0x5ae2(%rip)        # 6ff8 <__cxa_finalize@GLIBC_2.2.5>
    1515:	00 
    1516:	48 89 e5             	mov    %rsp,%rbp
    1519:	74 0c                	je     1527 <__do_global_dtors_aux+0x27>
    151b:	48 8b 3d e6 5a 00 00 	mov    0x5ae6(%rip),%rdi        # 7008 <__dso_handle>
    1522:	e8 19 fd ff ff       	callq  1240 <__cxa_finalize@plt>
    1527:	e8 64 ff ff ff       	callq  1490 <deregister_tm_clones>
    152c:	c6 05 75 5e 00 00 01 	movb   $0x1,0x5e75(%rip)        # 73a8 <completed.8061>
    1533:	5d                   	pop    %rbp
    1534:	c3                   	retq   
    1535:	0f 1f 00             	nopl   (%rax)
    1538:	c3                   	retq   
    1539:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001540 <frame_dummy>:
    1540:	f3 0f 1e fa          	endbr64 
    1544:	e9 77 ff ff ff       	jmpq   14c0 <register_tm_clones>

0000000000001549 <usage>:
    1549:	50                   	push   %rax
    154a:	58                   	pop    %rax
    154b:	48 83 ec 08          	sub    $0x8,%rsp
    154f:	48 89 fa             	mov    %rdi,%rdx
    1552:	83 3d 8f 5e 00 00 00 	cmpl   $0x0,0x5e8f(%rip)        # 73e8 <is_checker>
    1559:	74 50                	je     15ab <usage+0x62>
    155b:	48 8d 35 a6 2a 00 00 	lea    0x2aa6(%rip),%rsi        # 4008 <_IO_stdin_used+0x8>
    1562:	bf 01 00 00 00       	mov    $0x1,%edi
    1567:	b8 00 00 00 00       	mov    $0x0,%eax
    156c:	e8 3f fe ff ff       	callq  13b0 <__printf_chk@plt>
    1571:	48 8d 3d c8 2a 00 00 	lea    0x2ac8(%rip),%rdi        # 4040 <_IO_stdin_used+0x40>
    1578:	e8 23 fd ff ff       	callq  12a0 <puts@plt>
    157d:	48 8d 3d 34 2c 00 00 	lea    0x2c34(%rip),%rdi        # 41b8 <_IO_stdin_used+0x1b8>
    1584:	e8 17 fd ff ff       	callq  12a0 <puts@plt>
    1589:	48 8d 3d d8 2a 00 00 	lea    0x2ad8(%rip),%rdi        # 4068 <_IO_stdin_used+0x68>
    1590:	e8 0b fd ff ff       	callq  12a0 <puts@plt>
    1595:	48 8d 3d 36 2c 00 00 	lea    0x2c36(%rip),%rdi        # 41d2 <_IO_stdin_used+0x1d2>
    159c:	e8 ff fc ff ff       	callq  12a0 <puts@plt>
    15a1:	bf 00 00 00 00       	mov    $0x0,%edi
    15a6:	e8 55 fe ff ff       	callq  1400 <exit@plt>
    15ab:	48 8d 35 3c 2c 00 00 	lea    0x2c3c(%rip),%rsi        # 41ee <_IO_stdin_used+0x1ee>
    15b2:	bf 01 00 00 00       	mov    $0x1,%edi
    15b7:	b8 00 00 00 00       	mov    $0x0,%eax
    15bc:	e8 ef fd ff ff       	callq  13b0 <__printf_chk@plt>
    15c1:	48 8d 3d c8 2a 00 00 	lea    0x2ac8(%rip),%rdi        # 4090 <_IO_stdin_used+0x90>
    15c8:	e8 d3 fc ff ff       	callq  12a0 <puts@plt>
    15cd:	48 8d 3d e4 2a 00 00 	lea    0x2ae4(%rip),%rdi        # 40b8 <_IO_stdin_used+0xb8>
    15d4:	e8 c7 fc ff ff       	callq  12a0 <puts@plt>
    15d9:	48 8d 3d 2c 2c 00 00 	lea    0x2c2c(%rip),%rdi        # 420c <_IO_stdin_used+0x20c>
    15e0:	e8 bb fc ff ff       	callq  12a0 <puts@plt>
    15e5:	eb ba                	jmp    15a1 <usage+0x58>

00000000000015e7 <initialize_target>:
    15e7:	55                   	push   %rbp
    15e8:	53                   	push   %rbx
    15e9:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    15f0:	48 83 0c 24 00       	orq    $0x0,(%rsp)
    15f5:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    15fc:	48 83 0c 24 00       	orq    $0x0,(%rsp)
    1601:	48 81 ec 18 01 00 00 	sub    $0x118,%rsp
    1608:	89 f5                	mov    %esi,%ebp
    160a:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    1611:	00 00 
    1613:	48 89 84 24 08 21 00 	mov    %rax,0x2108(%rsp)
    161a:	00 
    161b:	31 c0                	xor    %eax,%eax
    161d:	89 3d b5 5d 00 00    	mov    %edi,0x5db5(%rip)        # 73d8 <check_level>
    1623:	8b 3d e7 59 00 00    	mov    0x59e7(%rip),%edi        # 7010 <target_id>
    1629:	e8 fe 1f 00 00       	callq  362c <gencookie>
    162e:	89 c7                	mov    %eax,%edi
    1630:	89 05 ae 5d 00 00    	mov    %eax,0x5dae(%rip)        # 73e4 <cookie>
    1636:	e8 f1 1f 00 00       	callq  362c <gencookie>
    163b:	89 05 9f 5d 00 00    	mov    %eax,0x5d9f(%rip)        # 73e0 <authkey>
    1641:	8b 05 c9 59 00 00    	mov    0x59c9(%rip),%eax        # 7010 <target_id>
    1647:	8d 78 01             	lea    0x1(%rax),%edi
    164a:	e8 21 fc ff ff       	callq  1270 <srandom@plt>
    164f:	e8 2c fd ff ff       	callq  1380 <random@plt>
    1654:	48 89 c7             	mov    %rax,%rdi
    1657:	e8 20 03 00 00       	callq  197c <scramble>
    165c:	89 c3                	mov    %eax,%ebx
    165e:	85 ed                	test   %ebp,%ebp
    1660:	75 54                	jne    16b6 <initialize_target+0xcf>
    1662:	b8 00 00 00 00       	mov    $0x0,%eax
    1667:	01 d8                	add    %ebx,%eax
    1669:	0f b7 c0             	movzwl %ax,%eax
    166c:	8d 04 c5 00 01 00 00 	lea    0x100(,%rax,8),%eax
    1673:	89 c0                	mov    %eax,%eax
    1675:	48 89 05 e4 5c 00 00 	mov    %rax,0x5ce4(%rip)        # 7360 <buf_offset>
    167c:	c6 05 85 69 00 00 72 	movb   $0x72,0x6985(%rip)        # 8008 <target_prefix>
    1683:	83 3d de 5c 00 00 00 	cmpl   $0x0,0x5cde(%rip)        # 7368 <notify>
    168a:	74 09                	je     1695 <initialize_target+0xae>
    168c:	83 3d 55 5d 00 00 00 	cmpl   $0x0,0x5d55(%rip)        # 73e8 <is_checker>
    1693:	74 3a                	je     16cf <initialize_target+0xe8>
    1695:	48 8b 84 24 08 21 00 	mov    0x2108(%rsp),%rax
    169c:	00 
    169d:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    16a4:	00 00 
    16a6:	0f 85 db 00 00 00    	jne    1787 <initialize_target+0x1a0>
    16ac:	48 81 c4 18 21 00 00 	add    $0x2118,%rsp
    16b3:	5b                   	pop    %rbx
    16b4:	5d                   	pop    %rbp
    16b5:	c3                   	retq   
    16b6:	bf 00 00 00 00       	mov    $0x0,%edi
    16bb:	e8 b0 fc ff ff       	callq  1370 <time@plt>
    16c0:	48 89 c7             	mov    %rax,%rdi
    16c3:	e8 a8 fb ff ff       	callq  1270 <srandom@plt>
    16c8:	e8 b3 fc ff ff       	callq  1380 <random@plt>
    16cd:	eb 98                	jmp    1667 <initialize_target+0x80>
    16cf:	48 89 e7             	mov    %rsp,%rdi
    16d2:	be 00 01 00 00       	mov    $0x100,%esi
    16d7:	e8 14 fd ff ff       	callq  13f0 <gethostname@plt>
    16dc:	89 c5                	mov    %eax,%ebp
    16de:	85 c0                	test   %eax,%eax
    16e0:	75 26                	jne    1708 <initialize_target+0x121>
    16e2:	89 c3                	mov    %eax,%ebx
    16e4:	48 63 c3             	movslq %ebx,%rax
    16e7:	48 8d 15 52 59 00 00 	lea    0x5952(%rip),%rdx        # 7040 <host_table>
    16ee:	48 8b 3c c2          	mov    (%rdx,%rax,8),%rdi
    16f2:	48 85 ff             	test   %rdi,%rdi
    16f5:	74 2c                	je     1723 <initialize_target+0x13c>
    16f7:	48 89 e6             	mov    %rsp,%rsi
    16fa:	e8 51 fb ff ff       	callq  1250 <strcasecmp@plt>
    16ff:	85 c0                	test   %eax,%eax
    1701:	74 1b                	je     171e <initialize_target+0x137>
    1703:	83 c3 01             	add    $0x1,%ebx
    1706:	eb dc                	jmp    16e4 <initialize_target+0xfd>
    1708:	48 8d 3d d9 29 00 00 	lea    0x29d9(%rip),%rdi        # 40e8 <_IO_stdin_used+0xe8>
    170f:	e8 8c fb ff ff       	callq  12a0 <puts@plt>
    1714:	bf 08 00 00 00       	mov    $0x8,%edi
    1719:	e8 e2 fc ff ff       	callq  1400 <exit@plt>
    171e:	bd 01 00 00 00       	mov    $0x1,%ebp
    1723:	85 ed                	test   %ebp,%ebp
    1725:	74 3d                	je     1764 <initialize_target+0x17d>
    1727:	48 8d bc 24 00 01 00 	lea    0x100(%rsp),%rdi
    172e:	00 
    172f:	e8 3d 1c 00 00       	callq  3371 <init_driver>
    1734:	85 c0                	test   %eax,%eax
    1736:	0f 89 59 ff ff ff    	jns    1695 <initialize_target+0xae>
    173c:	48 8d 94 24 00 01 00 	lea    0x100(%rsp),%rdx
    1743:	00 
    1744:	48 8d 35 15 2a 00 00 	lea    0x2a15(%rip),%rsi        # 4160 <_IO_stdin_used+0x160>
    174b:	bf 01 00 00 00       	mov    $0x1,%edi
    1750:	b8 00 00 00 00       	mov    $0x0,%eax
    1755:	e8 56 fc ff ff       	callq  13b0 <__printf_chk@plt>
    175a:	bf 08 00 00 00       	mov    $0x8,%edi
    175f:	e8 9c fc ff ff       	callq  1400 <exit@plt>
    1764:	48 89 e2             	mov    %rsp,%rdx
    1767:	48 8d 35 b2 29 00 00 	lea    0x29b2(%rip),%rsi        # 4120 <_IO_stdin_used+0x120>
    176e:	bf 01 00 00 00       	mov    $0x1,%edi
    1773:	b8 00 00 00 00       	mov    $0x0,%eax
    1778:	e8 33 fc ff ff       	callq  13b0 <__printf_chk@plt>
    177d:	bf 08 00 00 00       	mov    $0x8,%edi
    1782:	e8 79 fc ff ff       	callq  1400 <exit@plt>
    1787:	e8 34 fb ff ff       	callq  12c0 <__stack_chk_fail@plt>

000000000000178c <main>:
    178c:	f3 0f 1e fa          	endbr64 
    1790:	41 56                	push   %r14
    1792:	41 55                	push   %r13
    1794:	41 54                	push   %r12
    1796:	55                   	push   %rbp
    1797:	53                   	push   %rbx
    1798:	89 fd                	mov    %edi,%ebp
    179a:	48 89 f3             	mov    %rsi,%rbx
    179d:	48 8d 35 70 0e 00 00 	lea    0xe70(%rip),%rsi        # 2614 <seghandler>
    17a4:	bf 0b 00 00 00       	mov    $0xb,%edi
    17a9:	e8 72 fb ff ff       	callq  1320 <signal@plt>
    17ae:	48 8d 35 05 0e 00 00 	lea    0xe05(%rip),%rsi        # 25ba <bushandler>
    17b5:	bf 07 00 00 00       	mov    $0x7,%edi
    17ba:	e8 61 fb ff ff       	callq  1320 <signal@plt>
    17bf:	48 8d 35 a8 0e 00 00 	lea    0xea8(%rip),%rsi        # 266e <illegalhandler>
    17c6:	bf 04 00 00 00       	mov    $0x4,%edi
    17cb:	e8 50 fb ff ff       	callq  1320 <signal@plt>
    17d0:	83 3d 11 5c 00 00 00 	cmpl   $0x0,0x5c11(%rip)        # 73e8 <is_checker>
    17d7:	75 26                	jne    17ff <main+0x73>
    17d9:	4c 8d 25 4d 2a 00 00 	lea    0x2a4d(%rip),%r12        # 422d <_IO_stdin_used+0x22d>
    17e0:	48 8b 05 99 5b 00 00 	mov    0x5b99(%rip),%rax        # 7380 <stdin@@GLIBC_2.2.5>
    17e7:	48 89 05 e2 5b 00 00 	mov    %rax,0x5be2(%rip)        # 73d0 <infile>
    17ee:	41 bd 00 00 00 00    	mov    $0x0,%r13d
    17f4:	41 be 00 00 00 00    	mov    $0x0,%r14d
    17fa:	e9 8d 00 00 00       	jmpq   188c <main+0x100>
    17ff:	48 8d 35 c2 0e 00 00 	lea    0xec2(%rip),%rsi        # 26c8 <sigalrmhandler>
    1806:	bf 0e 00 00 00       	mov    $0xe,%edi
    180b:	e8 10 fb ff ff       	callq  1320 <signal@plt>
    1810:	bf 05 00 00 00       	mov    $0x5,%edi
    1815:	e8 d6 fa ff ff       	callq  12f0 <alarm@plt>
    181a:	4c 8d 25 04 2a 00 00 	lea    0x2a04(%rip),%r12        # 4225 <_IO_stdin_used+0x225>
    1821:	eb bd                	jmp    17e0 <main+0x54>
    1823:	48 8b 3b             	mov    (%rbx),%rdi
    1826:	e8 1e fd ff ff       	callq  1549 <usage>
    182b:	48 8d 35 db 2c 00 00 	lea    0x2cdb(%rip),%rsi        # 450d <_IO_stdin_used+0x50d>
    1832:	48 8b 3d 4f 5b 00 00 	mov    0x5b4f(%rip),%rdi        # 7388 <optarg@@GLIBC_2.2.5>
    1839:	e8 82 fb ff ff       	callq  13c0 <fopen@plt>
    183e:	48 89 05 8b 5b 00 00 	mov    %rax,0x5b8b(%rip)        # 73d0 <infile>
    1845:	48 85 c0             	test   %rax,%rax
    1848:	75 42                	jne    188c <main+0x100>
    184a:	48 8b 0d 37 5b 00 00 	mov    0x5b37(%rip),%rcx        # 7388 <optarg@@GLIBC_2.2.5>
    1851:	48 8d 15 da 29 00 00 	lea    0x29da(%rip),%rdx        # 4232 <_IO_stdin_used+0x232>
    1858:	be 01 00 00 00       	mov    $0x1,%esi
    185d:	48 8b 3d 3c 5b 00 00 	mov    0x5b3c(%rip),%rdi        # 73a0 <stderr@@GLIBC_2.2.5>
    1864:	e8 b7 fb ff ff       	callq  1420 <__fprintf_chk@plt>
    1869:	b8 01 00 00 00       	mov    $0x1,%eax
    186e:	e9 db 00 00 00       	jmpq   194e <main+0x1c2>
    1873:	ba 10 00 00 00       	mov    $0x10,%edx
    1878:	be 00 00 00 00       	mov    $0x0,%esi
    187d:	48 8b 3d 04 5b 00 00 	mov    0x5b04(%rip),%rdi        # 7388 <optarg@@GLIBC_2.2.5>
    1884:	e8 57 fb ff ff       	callq  13e0 <strtoul@plt>
    1889:	41 89 c6             	mov    %eax,%r14d
    188c:	4c 89 e2             	mov    %r12,%rdx
    188f:	48 89 de             	mov    %rbx,%rsi
    1892:	89 ef                	mov    %ebp,%edi
    1894:	e8 37 fb ff ff       	callq  13d0 <getopt@plt>
    1899:	3c ff                	cmp    $0xff,%al
    189b:	74 65                	je     1902 <main+0x176>
    189d:	0f be c8             	movsbl %al,%ecx
    18a0:	83 e8 61             	sub    $0x61,%eax
    18a3:	3c 10                	cmp    $0x10,%al
    18a5:	77 3b                	ja     18e2 <main+0x156>
    18a7:	0f b6 c0             	movzbl %al,%eax
    18aa:	48 8d 15 bf 29 00 00 	lea    0x29bf(%rip),%rdx        # 4270 <_IO_stdin_used+0x270>
    18b1:	48 63 04 82          	movslq (%rdx,%rax,4),%rax
    18b5:	48 01 d0             	add    %rdx,%rax
    18b8:	3e ff e0             	notrack jmpq *%rax
    18bb:	ba 0a 00 00 00       	mov    $0xa,%edx
    18c0:	be 00 00 00 00       	mov    $0x0,%esi
    18c5:	48 8b 3d bc 5a 00 00 	mov    0x5abc(%rip),%rdi        # 7388 <optarg@@GLIBC_2.2.5>
    18cc:	e8 7f fa ff ff       	callq  1350 <strtol@plt>
    18d1:	41 89 c5             	mov    %eax,%r13d
    18d4:	eb b6                	jmp    188c <main+0x100>
    18d6:	c7 05 88 5a 00 00 00 	movl   $0x0,0x5a88(%rip)        # 7368 <notify>
    18dd:	00 00 00 
    18e0:	eb aa                	jmp    188c <main+0x100>
    18e2:	89 ca                	mov    %ecx,%edx
    18e4:	48 8d 35 64 29 00 00 	lea    0x2964(%rip),%rsi        # 424f <_IO_stdin_used+0x24f>
    18eb:	bf 01 00 00 00       	mov    $0x1,%edi
    18f0:	b8 00 00 00 00       	mov    $0x0,%eax
    18f5:	e8 b6 fa ff ff       	callq  13b0 <__printf_chk@plt>
    18fa:	48 8b 3b             	mov    (%rbx),%rdi
    18fd:	e8 47 fc ff ff       	callq  1549 <usage>
    1902:	be 01 00 00 00       	mov    $0x1,%esi
    1907:	44 89 ef             	mov    %r13d,%edi
    190a:	e8 d8 fc ff ff       	callq  15e7 <initialize_target>
    190f:	83 3d d2 5a 00 00 00 	cmpl   $0x0,0x5ad2(%rip)        # 73e8 <is_checker>
    1916:	74 09                	je     1921 <main+0x195>
    1918:	44 39 35 c1 5a 00 00 	cmp    %r14d,0x5ac1(%rip)        # 73e0 <authkey>
    191f:	75 36                	jne    1957 <main+0x1cb>
    1921:	8b 15 bd 5a 00 00    	mov    0x5abd(%rip),%edx        # 73e4 <cookie>
    1927:	48 8d 35 34 29 00 00 	lea    0x2934(%rip),%rsi        # 4262 <_IO_stdin_used+0x262>
    192e:	bf 01 00 00 00       	mov    $0x1,%edi
    1933:	b8 00 00 00 00       	mov    $0x0,%eax
    1938:	e8 73 fa ff ff       	callq  13b0 <__printf_chk@plt>
    193d:	48 8b 3d 1c 5a 00 00 	mov    0x5a1c(%rip),%rdi        # 7360 <buf_offset>
    1944:	e8 dc 0d 00 00       	callq  2725 <launch>
    1949:	b8 00 00 00 00       	mov    $0x0,%eax
    194e:	5b                   	pop    %rbx
    194f:	5d                   	pop    %rbp
    1950:	41 5c                	pop    %r12
    1952:	41 5d                	pop    %r13
    1954:	41 5e                	pop    %r14
    1956:	c3                   	retq   
    1957:	44 89 f2             	mov    %r14d,%edx
    195a:	48 8d 35 27 28 00 00 	lea    0x2827(%rip),%rsi        # 4188 <_IO_stdin_used+0x188>
    1961:	bf 01 00 00 00       	mov    $0x1,%edi
    1966:	b8 00 00 00 00       	mov    $0x0,%eax
    196b:	e8 40 fa ff ff       	callq  13b0 <__printf_chk@plt>
    1970:	b8 00 00 00 00       	mov    $0x0,%eax
    1975:	e8 8f 08 00 00       	callq  2209 <check_fail>
    197a:	eb a5                	jmp    1921 <main+0x195>

000000000000197c <scramble>:
    197c:	f3 0f 1e fa          	endbr64 
    1980:	48 83 ec 38          	sub    $0x38,%rsp
    1984:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    198b:	00 00 
    198d:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    1992:	31 c0                	xor    %eax,%eax
    1994:	83 f8 09             	cmp    $0x9,%eax
    1997:	77 12                	ja     19ab <scramble+0x2f>
    1999:	69 d0 4d 8b 00 00    	imul   $0x8b4d,%eax,%edx
    199f:	01 fa                	add    %edi,%edx
    19a1:	89 c1                	mov    %eax,%ecx
    19a3:	89 14 8c             	mov    %edx,(%rsp,%rcx,4)
    19a6:	83 c0 01             	add    $0x1,%eax
    19a9:	eb e9                	jmp    1994 <scramble+0x18>
    19ab:	8b 44 24 10          	mov    0x10(%rsp),%eax
    19af:	69 c0 de a5 00 00    	imul   $0xa5de,%eax,%eax
    19b5:	89 44 24 10          	mov    %eax,0x10(%rsp)
    19b9:	8b 44 24 08          	mov    0x8(%rsp),%eax
    19bd:	69 c0 c9 8e 00 00    	imul   $0x8ec9,%eax,%eax
    19c3:	89 44 24 08          	mov    %eax,0x8(%rsp)
    19c7:	8b 44 24 24          	mov    0x24(%rsp),%eax
    19cb:	69 c0 fb 9b 00 00    	imul   $0x9bfb,%eax,%eax
    19d1:	89 44 24 24          	mov    %eax,0x24(%rsp)
    19d5:	8b 44 24 08          	mov    0x8(%rsp),%eax
    19d9:	69 c0 34 2f 00 00    	imul   $0x2f34,%eax,%eax
    19df:	89 44 24 08          	mov    %eax,0x8(%rsp)
    19e3:	8b 44 24 0c          	mov    0xc(%rsp),%eax
    19e7:	69 c0 d0 e8 00 00    	imul   $0xe8d0,%eax,%eax
    19ed:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    19f1:	8b 44 24 10          	mov    0x10(%rsp),%eax
    19f5:	69 c0 b3 25 00 00    	imul   $0x25b3,%eax,%eax
    19fb:	89 44 24 10          	mov    %eax,0x10(%rsp)
    19ff:	8b 44 24 14          	mov    0x14(%rsp),%eax
    1a03:	69 c0 c1 e9 00 00    	imul   $0xe9c1,%eax,%eax
    1a09:	89 44 24 14          	mov    %eax,0x14(%rsp)
    1a0d:	8b 44 24 08          	mov    0x8(%rsp),%eax
    1a11:	69 c0 41 42 00 00    	imul   $0x4241,%eax,%eax
    1a17:	89 44 24 08          	mov    %eax,0x8(%rsp)
    1a1b:	8b 04 24             	mov    (%rsp),%eax
    1a1e:	69 c0 85 ff 00 00    	imul   $0xff85,%eax,%eax
    1a24:	89 04 24             	mov    %eax,(%rsp)
    1a27:	8b 44 24 04          	mov    0x4(%rsp),%eax
    1a2b:	69 c0 e6 2b 00 00    	imul   $0x2be6,%eax,%eax
    1a31:	89 44 24 04          	mov    %eax,0x4(%rsp)
    1a35:	8b 44 24 1c          	mov    0x1c(%rsp),%eax
    1a39:	69 c0 14 47 00 00    	imul   $0x4714,%eax,%eax
    1a3f:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
    1a43:	8b 44 24 14          	mov    0x14(%rsp),%eax
    1a47:	69 c0 30 23 00 00    	imul   $0x2330,%eax,%eax
    1a4d:	89 44 24 14          	mov    %eax,0x14(%rsp)
    1a51:	8b 04 24             	mov    (%rsp),%eax
    1a54:	69 c0 dc 89 00 00    	imul   $0x89dc,%eax,%eax
    1a5a:	89 04 24             	mov    %eax,(%rsp)
    1a5d:	8b 04 24             	mov    (%rsp),%eax
    1a60:	69 c0 7e 10 00 00    	imul   $0x107e,%eax,%eax
    1a66:	89 04 24             	mov    %eax,(%rsp)
    1a69:	8b 44 24 20          	mov    0x20(%rsp),%eax
    1a6d:	69 c0 58 a5 00 00    	imul   $0xa558,%eax,%eax
    1a73:	89 44 24 20          	mov    %eax,0x20(%rsp)
    1a77:	8b 44 24 08          	mov    0x8(%rsp),%eax
    1a7b:	69 c0 b7 0b 00 00    	imul   $0xbb7,%eax,%eax
    1a81:	89 44 24 08          	mov    %eax,0x8(%rsp)
    1a85:	8b 44 24 0c          	mov    0xc(%rsp),%eax
    1a89:	69 c0 76 e4 00 00    	imul   $0xe476,%eax,%eax
    1a8f:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    1a93:	8b 44 24 18          	mov    0x18(%rsp),%eax
    1a97:	69 c0 4d 9e 00 00    	imul   $0x9e4d,%eax,%eax
    1a9d:	89 44 24 18          	mov    %eax,0x18(%rsp)
    1aa1:	8b 44 24 24          	mov    0x24(%rsp),%eax
    1aa5:	69 c0 32 84 00 00    	imul   $0x8432,%eax,%eax
    1aab:	89 44 24 24          	mov    %eax,0x24(%rsp)
    1aaf:	8b 44 24 0c          	mov    0xc(%rsp),%eax
    1ab3:	69 c0 d6 77 00 00    	imul   $0x77d6,%eax,%eax
    1ab9:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    1abd:	8b 44 24 1c          	mov    0x1c(%rsp),%eax
    1ac1:	69 c0 56 8d 00 00    	imul   $0x8d56,%eax,%eax
    1ac7:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
    1acb:	8b 44 24 04          	mov    0x4(%rsp),%eax
    1acf:	69 c0 87 57 00 00    	imul   $0x5787,%eax,%eax
    1ad5:	89 44 24 04          	mov    %eax,0x4(%rsp)
    1ad9:	8b 44 24 10          	mov    0x10(%rsp),%eax
    1add:	69 c0 5f f6 00 00    	imul   $0xf65f,%eax,%eax
    1ae3:	89 44 24 10          	mov    %eax,0x10(%rsp)
    1ae7:	8b 04 24             	mov    (%rsp),%eax
    1aea:	69 c0 d4 77 00 00    	imul   $0x77d4,%eax,%eax
    1af0:	89 04 24             	mov    %eax,(%rsp)
    1af3:	8b 44 24 18          	mov    0x18(%rsp),%eax
    1af7:	69 c0 e6 49 00 00    	imul   $0x49e6,%eax,%eax
    1afd:	89 44 24 18          	mov    %eax,0x18(%rsp)
    1b01:	8b 04 24             	mov    (%rsp),%eax
    1b04:	69 c0 a9 a2 00 00    	imul   $0xa2a9,%eax,%eax
    1b0a:	89 04 24             	mov    %eax,(%rsp)
    1b0d:	8b 44 24 1c          	mov    0x1c(%rsp),%eax
    1b11:	69 c0 dd 2d 00 00    	imul   $0x2ddd,%eax,%eax
    1b17:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
    1b1b:	8b 44 24 20          	mov    0x20(%rsp),%eax
    1b1f:	69 c0 52 59 00 00    	imul   $0x5952,%eax,%eax
    1b25:	89 44 24 20          	mov    %eax,0x20(%rsp)
    1b29:	8b 44 24 18          	mov    0x18(%rsp),%eax
    1b2d:	69 c0 dc fb 00 00    	imul   $0xfbdc,%eax,%eax
    1b33:	89 44 24 18          	mov    %eax,0x18(%rsp)
    1b37:	8b 04 24             	mov    (%rsp),%eax
    1b3a:	69 c0 24 38 00 00    	imul   $0x3824,%eax,%eax
    1b40:	89 04 24             	mov    %eax,(%rsp)
    1b43:	8b 44 24 08          	mov    0x8(%rsp),%eax
    1b47:	69 c0 04 b8 00 00    	imul   $0xb804,%eax,%eax
    1b4d:	89 44 24 08          	mov    %eax,0x8(%rsp)
    1b51:	8b 04 24             	mov    (%rsp),%eax
    1b54:	69 c0 6b ec 00 00    	imul   $0xec6b,%eax,%eax
    1b5a:	89 04 24             	mov    %eax,(%rsp)
    1b5d:	8b 44 24 08          	mov    0x8(%rsp),%eax
    1b61:	69 c0 5d de 00 00    	imul   $0xde5d,%eax,%eax
    1b67:	89 44 24 08          	mov    %eax,0x8(%rsp)
    1b6b:	8b 44 24 04          	mov    0x4(%rsp),%eax
    1b6f:	69 c0 ec 1c 00 00    	imul   $0x1cec,%eax,%eax
    1b75:	89 44 24 04          	mov    %eax,0x4(%rsp)
    1b79:	8b 44 24 24          	mov    0x24(%rsp),%eax
    1b7d:	69 c0 39 58 00 00    	imul   $0x5839,%eax,%eax
    1b83:	89 44 24 24          	mov    %eax,0x24(%rsp)
    1b87:	8b 44 24 1c          	mov    0x1c(%rsp),%eax
    1b8b:	69 c0 92 cf 00 00    	imul   $0xcf92,%eax,%eax
    1b91:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
    1b95:	8b 44 24 04          	mov    0x4(%rsp),%eax
    1b99:	69 c0 4c 32 00 00    	imul   $0x324c,%eax,%eax
    1b9f:	89 44 24 04          	mov    %eax,0x4(%rsp)
    1ba3:	8b 44 24 0c          	mov    0xc(%rsp),%eax
    1ba7:	69 c0 a6 5c 00 00    	imul   $0x5ca6,%eax,%eax
    1bad:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    1bb1:	8b 44 24 18          	mov    0x18(%rsp),%eax
    1bb5:	69 c0 e1 c0 00 00    	imul   $0xc0e1,%eax,%eax
    1bbb:	89 44 24 18          	mov    %eax,0x18(%rsp)
    1bbf:	8b 44 24 04          	mov    0x4(%rsp),%eax
    1bc3:	69 c0 90 1e 00 00    	imul   $0x1e90,%eax,%eax
    1bc9:	89 44 24 04          	mov    %eax,0x4(%rsp)
    1bcd:	8b 44 24 04          	mov    0x4(%rsp),%eax
    1bd1:	69 c0 34 78 00 00    	imul   $0x7834,%eax,%eax
    1bd7:	89 44 24 04          	mov    %eax,0x4(%rsp)
    1bdb:	8b 44 24 20          	mov    0x20(%rsp),%eax
    1bdf:	69 c0 c2 9b 00 00    	imul   $0x9bc2,%eax,%eax
    1be5:	89 44 24 20          	mov    %eax,0x20(%rsp)
    1be9:	8b 44 24 08          	mov    0x8(%rsp),%eax
    1bed:	69 c0 13 87 00 00    	imul   $0x8713,%eax,%eax
    1bf3:	89 44 24 08          	mov    %eax,0x8(%rsp)
    1bf7:	8b 44 24 24          	mov    0x24(%rsp),%eax
    1bfb:	69 c0 cc 5d 00 00    	imul   $0x5dcc,%eax,%eax
    1c01:	89 44 24 24          	mov    %eax,0x24(%rsp)
    1c05:	8b 44 24 18          	mov    0x18(%rsp),%eax
    1c09:	69 c0 e4 5e 00 00    	imul   $0x5ee4,%eax,%eax
    1c0f:	89 44 24 18          	mov    %eax,0x18(%rsp)
    1c13:	8b 44 24 10          	mov    0x10(%rsp),%eax
    1c17:	69 c0 23 24 00 00    	imul   $0x2423,%eax,%eax
    1c1d:	89 44 24 10          	mov    %eax,0x10(%rsp)
    1c21:	8b 44 24 10          	mov    0x10(%rsp),%eax
    1c25:	69 c0 cc d9 00 00    	imul   $0xd9cc,%eax,%eax
    1c2b:	89 44 24 10          	mov    %eax,0x10(%rsp)
    1c2f:	8b 44 24 14          	mov    0x14(%rsp),%eax
    1c33:	69 c0 62 b3 00 00    	imul   $0xb362,%eax,%eax
    1c39:	89 44 24 14          	mov    %eax,0x14(%rsp)
    1c3d:	8b 44 24 14          	mov    0x14(%rsp),%eax
    1c41:	69 c0 46 9b 00 00    	imul   $0x9b46,%eax,%eax
    1c47:	89 44 24 14          	mov    %eax,0x14(%rsp)
    1c4b:	8b 44 24 24          	mov    0x24(%rsp),%eax
    1c4f:	69 c0 b9 1a 00 00    	imul   $0x1ab9,%eax,%eax
    1c55:	89 44 24 24          	mov    %eax,0x24(%rsp)
    1c59:	8b 44 24 04          	mov    0x4(%rsp),%eax
    1c5d:	69 c0 12 65 00 00    	imul   $0x6512,%eax,%eax
    1c63:	89 44 24 04          	mov    %eax,0x4(%rsp)
    1c67:	8b 44 24 10          	mov    0x10(%rsp),%eax
    1c6b:	69 c0 0e d9 00 00    	imul   $0xd90e,%eax,%eax
    1c71:	89 44 24 10          	mov    %eax,0x10(%rsp)
    1c75:	8b 44 24 24          	mov    0x24(%rsp),%eax
    1c79:	69 c0 65 11 00 00    	imul   $0x1165,%eax,%eax
    1c7f:	89 44 24 24          	mov    %eax,0x24(%rsp)
    1c83:	8b 04 24             	mov    (%rsp),%eax
    1c86:	69 c0 0a c0 00 00    	imul   $0xc00a,%eax,%eax
    1c8c:	89 04 24             	mov    %eax,(%rsp)
    1c8f:	8b 44 24 20          	mov    0x20(%rsp),%eax
    1c93:	69 c0 2f 0a 00 00    	imul   $0xa2f,%eax,%eax
    1c99:	89 44 24 20          	mov    %eax,0x20(%rsp)
    1c9d:	8b 04 24             	mov    (%rsp),%eax
    1ca0:	69 c0 0e dd 00 00    	imul   $0xdd0e,%eax,%eax
    1ca6:	89 04 24             	mov    %eax,(%rsp)
    1ca9:	8b 44 24 18          	mov    0x18(%rsp),%eax
    1cad:	69 c0 d3 9f 00 00    	imul   $0x9fd3,%eax,%eax
    1cb3:	89 44 24 18          	mov    %eax,0x18(%rsp)
    1cb7:	8b 04 24             	mov    (%rsp),%eax
    1cba:	69 c0 76 28 00 00    	imul   $0x2876,%eax,%eax
    1cc0:	89 04 24             	mov    %eax,(%rsp)
    1cc3:	8b 44 24 20          	mov    0x20(%rsp),%eax
    1cc7:	69 c0 e4 6d 00 00    	imul   $0x6de4,%eax,%eax
    1ccd:	89 44 24 20          	mov    %eax,0x20(%rsp)
    1cd1:	8b 44 24 20          	mov    0x20(%rsp),%eax
    1cd5:	69 c0 d5 a9 00 00    	imul   $0xa9d5,%eax,%eax
    1cdb:	89 44 24 20          	mov    %eax,0x20(%rsp)
    1cdf:	8b 44 24 24          	mov    0x24(%rsp),%eax
    1ce3:	69 c0 32 1c 00 00    	imul   $0x1c32,%eax,%eax
    1ce9:	89 44 24 24          	mov    %eax,0x24(%rsp)
    1ced:	8b 44 24 1c          	mov    0x1c(%rsp),%eax
    1cf1:	69 c0 b0 e3 00 00    	imul   $0xe3b0,%eax,%eax
    1cf7:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
    1cfb:	8b 04 24             	mov    (%rsp),%eax
    1cfe:	69 c0 87 de 00 00    	imul   $0xde87,%eax,%eax
    1d04:	89 04 24             	mov    %eax,(%rsp)
    1d07:	8b 44 24 10          	mov    0x10(%rsp),%eax
    1d0b:	69 c0 28 ae 00 00    	imul   $0xae28,%eax,%eax
    1d11:	89 44 24 10          	mov    %eax,0x10(%rsp)
    1d15:	8b 44 24 04          	mov    0x4(%rsp),%eax
    1d19:	69 c0 61 67 00 00    	imul   $0x6761,%eax,%eax
    1d1f:	89 44 24 04          	mov    %eax,0x4(%rsp)
    1d23:	8b 44 24 04          	mov    0x4(%rsp),%eax
    1d27:	69 c0 4d 6d 00 00    	imul   $0x6d4d,%eax,%eax
    1d2d:	89 44 24 04          	mov    %eax,0x4(%rsp)
    1d31:	8b 44 24 10          	mov    0x10(%rsp),%eax
    1d35:	69 c0 2d b3 00 00    	imul   $0xb32d,%eax,%eax
    1d3b:	89 44 24 10          	mov    %eax,0x10(%rsp)
    1d3f:	8b 44 24 20          	mov    0x20(%rsp),%eax
    1d43:	69 c0 d2 63 00 00    	imul   $0x63d2,%eax,%eax
    1d49:	89 44 24 20          	mov    %eax,0x20(%rsp)
    1d4d:	8b 44 24 20          	mov    0x20(%rsp),%eax
    1d51:	69 c0 11 7c 00 00    	imul   $0x7c11,%eax,%eax
    1d57:	89 44 24 20          	mov    %eax,0x20(%rsp)
    1d5b:	8b 44 24 10          	mov    0x10(%rsp),%eax
    1d5f:	69 c0 d8 96 00 00    	imul   $0x96d8,%eax,%eax
    1d65:	89 44 24 10          	mov    %eax,0x10(%rsp)
    1d69:	8b 44 24 10          	mov    0x10(%rsp),%eax
    1d6d:	69 c0 76 02 00 00    	imul   $0x276,%eax,%eax
    1d73:	89 44 24 10          	mov    %eax,0x10(%rsp)
    1d77:	b8 00 00 00 00       	mov    $0x0,%eax
    1d7c:	ba 00 00 00 00       	mov    $0x0,%edx
    1d81:	83 f8 09             	cmp    $0x9,%eax
    1d84:	77 0c                	ja     1d92 <scramble+0x416>
    1d86:	89 c1                	mov    %eax,%ecx
    1d88:	8b 0c 8c             	mov    (%rsp,%rcx,4),%ecx
    1d8b:	01 ca                	add    %ecx,%edx
    1d8d:	83 c0 01             	add    $0x1,%eax
    1d90:	eb ef                	jmp    1d81 <scramble+0x405>
    1d92:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    1d97:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    1d9e:	00 00 
    1da0:	75 07                	jne    1da9 <scramble+0x42d>
    1da2:	89 d0                	mov    %edx,%eax
    1da4:	48 83 c4 38          	add    $0x38,%rsp
    1da8:	c3                   	retq   
    1da9:	e8 12 f5 ff ff       	callq  12c0 <__stack_chk_fail@plt>

0000000000001dae <getbuf>:
    1dae:	f3 0f 1e fa          	endbr64 
    1db2:	48 83 ec 28          	sub    $0x28,%rsp
    1db6:	48 89 e7             	mov    %rsp,%rdi
    1db9:	e8 89 04 00 00       	callq  2247 <Gets>
    1dbe:	b8 01 00 00 00       	mov    $0x1,%eax
    1dc3:	48 83 c4 28          	add    $0x28,%rsp
    1dc7:	c3                   	retq   

0000000000001dc8 <touch1>:
    1dc8:	f3 0f 1e fa          	endbr64 
    1dcc:	50                   	push   %rax
    1dcd:	58                   	pop    %rax
    1dce:	48 83 ec 08          	sub    $0x8,%rsp
    1dd2:	c7 05 00 56 00 00 01 	movl   $0x1,0x5600(%rip)        # 73dc <vlevel>
    1dd9:	00 00 00 
    1ddc:	48 8d 3d 7e 25 00 00 	lea    0x257e(%rip),%rdi        # 4361 <_IO_stdin_used+0x361>
    1de3:	e8 b8 f4 ff ff       	callq  12a0 <puts@plt>
    1de8:	bf 01 00 00 00       	mov    $0x1,%edi
    1ded:	e8 c8 06 00 00       	callq  24ba <validate>
    1df2:	bf 00 00 00 00       	mov    $0x0,%edi
    1df7:	e8 04 f6 ff ff       	callq  1400 <exit@plt>

0000000000001dfc <touch2>:
    1dfc:	f3 0f 1e fa          	endbr64 
    1e00:	50                   	push   %rax
    1e01:	58                   	pop    %rax
    1e02:	48 83 ec 08          	sub    $0x8,%rsp
    1e06:	89 fa                	mov    %edi,%edx
    1e08:	c7 05 ca 55 00 00 02 	movl   $0x2,0x55ca(%rip)        # 73dc <vlevel>
    1e0f:	00 00 00 
    1e12:	39 3d cc 55 00 00    	cmp    %edi,0x55cc(%rip)        # 73e4 <cookie>
    1e18:	74 2a                	je     1e44 <touch2+0x48>
    1e1a:	48 8d 35 8f 25 00 00 	lea    0x258f(%rip),%rsi        # 43b0 <_IO_stdin_used+0x3b0>
    1e21:	bf 01 00 00 00       	mov    $0x1,%edi
    1e26:	b8 00 00 00 00       	mov    $0x0,%eax
    1e2b:	e8 80 f5 ff ff       	callq  13b0 <__printf_chk@plt>
    1e30:	bf 02 00 00 00       	mov    $0x2,%edi
    1e35:	e8 54 07 00 00       	callq  258e <fail>
    1e3a:	bf 00 00 00 00       	mov    $0x0,%edi
    1e3f:	e8 bc f5 ff ff       	callq  1400 <exit@plt>
    1e44:	48 8d 35 3d 25 00 00 	lea    0x253d(%rip),%rsi        # 4388 <_IO_stdin_used+0x388>
    1e4b:	bf 01 00 00 00       	mov    $0x1,%edi
    1e50:	b8 00 00 00 00       	mov    $0x0,%eax
    1e55:	e8 56 f5 ff ff       	callq  13b0 <__printf_chk@plt>
    1e5a:	bf 02 00 00 00       	mov    $0x2,%edi
    1e5f:	e8 56 06 00 00       	callq  24ba <validate>
    1e64:	eb d4                	jmp    1e3a <touch2+0x3e>

0000000000001e66 <hexmatch>:
    1e66:	f3 0f 1e fa          	endbr64 
    1e6a:	41 55                	push   %r13
    1e6c:	41 54                	push   %r12
    1e6e:	55                   	push   %rbp
    1e6f:	53                   	push   %rbx
    1e70:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    1e77:	89 fd                	mov    %edi,%ebp
    1e79:	48 89 f3             	mov    %rsi,%rbx
    1e7c:	41 bc 28 00 00 00    	mov    $0x28,%r12d
    1e82:	64 49 8b 04 24       	mov    %fs:(%r12),%rax
    1e87:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
    1e8c:	31 c0                	xor    %eax,%eax
    1e8e:	e8 ed f4 ff ff       	callq  1380 <random@plt>
    1e93:	48 89 c1             	mov    %rax,%rcx
    1e96:	48 ba 0b d7 a3 70 3d 	movabs $0xa3d70a3d70a3d70b,%rdx
    1e9d:	0a d7 a3 
    1ea0:	48 f7 ea             	imul   %rdx
    1ea3:	48 01 ca             	add    %rcx,%rdx
    1ea6:	48 c1 fa 06          	sar    $0x6,%rdx
    1eaa:	48 89 c8             	mov    %rcx,%rax
    1ead:	48 c1 f8 3f          	sar    $0x3f,%rax
    1eb1:	48 29 c2             	sub    %rax,%rdx
    1eb4:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    1eb8:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
    1ebc:	48 c1 e0 02          	shl    $0x2,%rax
    1ec0:	48 29 c1             	sub    %rax,%rcx
    1ec3:	4c 8d 2c 0c          	lea    (%rsp,%rcx,1),%r13
    1ec7:	41 89 e8             	mov    %ebp,%r8d
    1eca:	48 8d 0d ad 24 00 00 	lea    0x24ad(%rip),%rcx        # 437e <_IO_stdin_used+0x37e>
    1ed1:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
    1ed8:	be 01 00 00 00       	mov    $0x1,%esi
    1edd:	4c 89 ef             	mov    %r13,%rdi
    1ee0:	b8 00 00 00 00       	mov    $0x0,%eax
    1ee5:	e8 56 f5 ff ff       	callq  1440 <__sprintf_chk@plt>
    1eea:	ba 09 00 00 00       	mov    $0x9,%edx
    1eef:	4c 89 ee             	mov    %r13,%rsi
    1ef2:	48 89 df             	mov    %rbx,%rdi
    1ef5:	e8 86 f3 ff ff       	callq  1280 <strncmp@plt>
    1efa:	85 c0                	test   %eax,%eax
    1efc:	0f 94 c0             	sete   %al
    1eff:	48 8b 5c 24 78       	mov    0x78(%rsp),%rbx
    1f04:	64 49 33 1c 24       	xor    %fs:(%r12),%rbx
    1f09:	75 11                	jne    1f1c <hexmatch+0xb6>
    1f0b:	0f b6 c0             	movzbl %al,%eax
    1f0e:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    1f15:	5b                   	pop    %rbx
    1f16:	5d                   	pop    %rbp
    1f17:	41 5c                	pop    %r12
    1f19:	41 5d                	pop    %r13
    1f1b:	c3                   	retq   
    1f1c:	e8 9f f3 ff ff       	callq  12c0 <__stack_chk_fail@plt>

0000000000001f21 <touch3>:
    1f21:	f3 0f 1e fa          	endbr64 
    1f25:	53                   	push   %rbx
    1f26:	48 89 fb             	mov    %rdi,%rbx
    1f29:	c7 05 a9 54 00 00 03 	movl   $0x3,0x54a9(%rip)        # 73dc <vlevel>
    1f30:	00 00 00 
    1f33:	48 89 fe             	mov    %rdi,%rsi
    1f36:	8b 3d a8 54 00 00    	mov    0x54a8(%rip),%edi        # 73e4 <cookie>
    1f3c:	e8 25 ff ff ff       	callq  1e66 <hexmatch>
    1f41:	85 c0                	test   %eax,%eax
    1f43:	74 2d                	je     1f72 <touch3+0x51>
    1f45:	48 89 da             	mov    %rbx,%rdx
    1f48:	48 8d 35 89 24 00 00 	lea    0x2489(%rip),%rsi        # 43d8 <_IO_stdin_used+0x3d8>
    1f4f:	bf 01 00 00 00       	mov    $0x1,%edi
    1f54:	b8 00 00 00 00       	mov    $0x0,%eax
    1f59:	e8 52 f4 ff ff       	callq  13b0 <__printf_chk@plt>
    1f5e:	bf 03 00 00 00       	mov    $0x3,%edi
    1f63:	e8 52 05 00 00       	callq  24ba <validate>
    1f68:	bf 00 00 00 00       	mov    $0x0,%edi
    1f6d:	e8 8e f4 ff ff       	callq  1400 <exit@plt>
    1f72:	48 89 da             	mov    %rbx,%rdx
    1f75:	48 8d 35 84 24 00 00 	lea    0x2484(%rip),%rsi        # 4400 <_IO_stdin_used+0x400>
    1f7c:	bf 01 00 00 00       	mov    $0x1,%edi
    1f81:	b8 00 00 00 00       	mov    $0x0,%eax
    1f86:	e8 25 f4 ff ff       	callq  13b0 <__printf_chk@plt>
    1f8b:	bf 03 00 00 00       	mov    $0x3,%edi
    1f90:	e8 f9 05 00 00       	callq  258e <fail>
    1f95:	eb d1                	jmp    1f68 <touch3+0x47>

0000000000001f97 <test>:
    1f97:	f3 0f 1e fa          	endbr64 
    1f9b:	48 83 ec 08          	sub    $0x8,%rsp
    1f9f:	b8 00 00 00 00       	mov    $0x0,%eax
    1fa4:	e8 05 fe ff ff       	callq  1dae <getbuf>
    1fa9:	89 c2                	mov    %eax,%edx
    1fab:	48 8d 35 76 24 00 00 	lea    0x2476(%rip),%rsi        # 4428 <_IO_stdin_used+0x428>
    1fb2:	bf 01 00 00 00       	mov    $0x1,%edi
    1fb7:	b8 00 00 00 00       	mov    $0x0,%eax
    1fbc:	e8 ef f3 ff ff       	callq  13b0 <__printf_chk@plt>
    1fc1:	48 83 c4 08          	add    $0x8,%rsp
    1fc5:	c3                   	retq   

0000000000001fc6 <start_farm>:
    1fc6:	f3 0f 1e fa          	endbr64 
    1fca:	b8 01 00 00 00       	mov    $0x1,%eax
    1fcf:	c3                   	retq   

0000000000001fd0 <addval_194>:
    1fd0:	f3 0f 1e fa          	endbr64 
    1fd4:	8d 87 48 8d c7 c3    	lea    -0x3c3872b8(%rdi),%eax
    1fda:	c3                   	retq   

0000000000001fdb <addval_223>:
    1fdb:	f3 0f 1e fa          	endbr64 
    1fdf:	8d 87 5c 50 90 90    	lea    -0x6f6fafa4(%rdi),%eax
    1fe5:	c3                   	retq   

0000000000001fe6 <setval_208>:
    1fe6:	f3 0f 1e fa          	endbr64 
    1fea:	c7 07 9f 48 89 c7    	movl   $0xc789489f,(%rdi)
    1ff0:	c3                   	retq   

0000000000001ff1 <addval_431>:
    1ff1:	f3 0f 1e fa          	endbr64 
    1ff5:	8d 87 75 48 89 c7    	lea    -0x3876b78b(%rdi),%eax
    1ffb:	c3                   	retq   

0000000000001ffc <setval_354>:
    1ffc:	f3 0f 1e fa          	endbr64 
    2000:	c7 07 4a 89 c7 90    	movl   $0x90c7894a,(%rdi)
    2006:	c3                   	retq   

0000000000002007 <getval_407>:
    2007:	f3 0f 1e fa          	endbr64 
    200b:	b8 58 90 90 c3       	mov    $0xc3909058,%eax
    2010:	c3                   	retq   

0000000000002011 <setval_317>:
    2011:	f3 0f 1e fa          	endbr64 
    2015:	c7 07 58 90 c7 b1    	movl   $0xb1c79058,(%rdi)
    201b:	c3                   	retq   

000000000000201c <setval_428>:
    201c:	f3 0f 1e fa          	endbr64 
    2020:	c7 07 58 90 90 c3    	movl   $0xc3909058,(%rdi)
    2026:	c3                   	retq   

0000000000002027 <mid_farm>:
    2027:	f3 0f 1e fa          	endbr64 
    202b:	b8 01 00 00 00       	mov    $0x1,%eax
    2030:	c3                   	retq   

0000000000002031 <add_xy>:
    2031:	f3 0f 1e fa          	endbr64 
    2035:	48 8d 04 37          	lea    (%rdi,%rsi,1),%rax
    2039:	c3                   	retq   

000000000000203a <setval_260>:
    203a:	f3 0f 1e fa          	endbr64 
    203e:	c7 07 48 89 e0 90    	movl   $0x90e08948,(%rdi)
    2044:	c3                   	retq   

0000000000002045 <addval_245>:
    2045:	f3 0f 1e fa          	endbr64 
    2049:	8d 87 45 ef 89 ca    	lea    -0x357610bb(%rdi),%eax
    204f:	c3                   	retq   

0000000000002050 <getval_164>:
    2050:	f3 0f 1e fa          	endbr64 
    2054:	b8 8b ca 20 d2       	mov    $0xd220ca8b,%eax
    2059:	c3                   	retq   

000000000000205a <setval_273>:
    205a:	f3 0f 1e fa          	endbr64 
    205e:	c7 07 8b c1 08 db    	movl   $0xdb08c18b,(%rdi)
    2064:	c3                   	retq   

0000000000002065 <getval_242>:
    2065:	f3 0f 1e fa          	endbr64 
    2069:	b8 89 d6 18 c9       	mov    $0xc918d689,%eax
    206e:	c3                   	retq   

000000000000206f <addval_496>:
    206f:	f3 0f 1e fa          	endbr64 
    2073:	8d 87 49 89 d6 c3    	lea    -0x3c2976b7(%rdi),%eax
    2079:	c3                   	retq   

000000000000207a <setval_197>:
    207a:	f3 0f 1e fa          	endbr64 
    207e:	c7 07 88 ca 20 db    	movl   $0xdb20ca88,(%rdi)
    2084:	c3                   	retq   

0000000000002085 <addval_387>:
    2085:	f3 0f 1e fa          	endbr64 
    2089:	8d 87 89 d6 30 d2    	lea    -0x2dcf2977(%rdi),%eax
    208f:	c3                   	retq   

0000000000002090 <setval_373>:
    2090:	f3 0f 1e fa          	endbr64 
    2094:	c7 07 89 ca 90 90    	movl   $0x9090ca89,(%rdi)
    209a:	c3                   	retq   

000000000000209b <addval_105>:
    209b:	f3 0f 1e fa          	endbr64 
    209f:	8d 87 89 c1 a4 c0    	lea    -0x3f5b3e77(%rdi),%eax
    20a5:	c3                   	retq   

00000000000020a6 <getval_291>:
    20a6:	f3 0f 1e fa          	endbr64 
    20aa:	b8 88 d6 90 90       	mov    $0x9090d688,%eax
    20af:	c3                   	retq   

00000000000020b0 <getval_143>:
    20b0:	f3 0f 1e fa          	endbr64 
    20b4:	b8 40 89 e0 c3       	mov    $0xc3e08940,%eax
    20b9:	c3                   	retq   

00000000000020ba <getval_128>:
    20ba:	f3 0f 1e fa          	endbr64 
    20be:	b8 99 ca 08 c0       	mov    $0xc008ca99,%eax
    20c3:	c3                   	retq   

00000000000020c4 <getval_271>:
    20c4:	f3 0f 1e fa          	endbr64 
    20c8:	b8 89 c1 60 c0       	mov    $0xc060c189,%eax
    20cd:	c3                   	retq   

00000000000020ce <addval_419>:
    20ce:	f3 0f 1e fa          	endbr64 
    20d2:	8d 87 57 48 89 e0    	lea    -0x1f76b7a9(%rdi),%eax
    20d8:	c3                   	retq   

00000000000020d9 <setval_306>:
    20d9:	f3 0f 1e fa          	endbr64 
    20dd:	c7 07 89 c1 18 db    	movl   $0xdb18c189,(%rdi)
    20e3:	c3                   	retq   

00000000000020e4 <setval_120>:
    20e4:	f3 0f 1e fa          	endbr64 
    20e8:	c7 07 89 d6 08 d2    	movl   $0xd208d689,(%rdi)
    20ee:	c3                   	retq   

00000000000020ef <getval_483>:
    20ef:	f3 0f 1e fa          	endbr64 
    20f3:	b8 89 d6 28 c9       	mov    $0xc928d689,%eax
    20f8:	c3                   	retq   

00000000000020f9 <getval_257>:
    20f9:	f3 0f 1e fa          	endbr64 
    20fd:	b8 58 89 e0 c3       	mov    $0xc3e08958,%eax
    2102:	c3                   	retq   

0000000000002103 <addval_416>:
    2103:	f3 0f 1e fa          	endbr64 
    2107:	8d 87 48 81 e0 90    	lea    -0x6f1f7eb8(%rdi),%eax
    210d:	c3                   	retq   

000000000000210e <setval_191>:
    210e:	f3 0f 1e fa          	endbr64 
    2112:	c7 07 b4 48 8b e0    	movl   $0xe08b48b4,(%rdi)
    2118:	c3                   	retq   

0000000000002119 <addval_397>:
    2119:	f3 0f 1e fa          	endbr64 
    211d:	8d 87 8b ca 20 c0    	lea    -0x3fdf3575(%rdi),%eax
    2123:	c3                   	retq   

0000000000002124 <setval_144>:
    2124:	f3 0f 1e fa          	endbr64 
    2128:	c7 07 81 ca 38 c0    	movl   $0xc038ca81,(%rdi)
    212e:	c3                   	retq   

000000000000212f <setval_225>:
    212f:	f3 0f 1e fa          	endbr64 
    2133:	c7 07 89 c1 18 db    	movl   $0xdb18c189,(%rdi)
    2139:	c3                   	retq   

000000000000213a <setval_395>:
    213a:	f3 0f 1e fa          	endbr64 
    213e:	c7 07 09 b2 81 d6    	movl   $0xd681b209,(%rdi)
    2144:	c3                   	retq   

0000000000002145 <getval_377>:
    2145:	f3 0f 1e fa          	endbr64 
    2149:	b8 89 c1 08 c9       	mov    $0xc908c189,%eax
    214e:	c3                   	retq   

000000000000214f <addval_482>:
    214f:	f3 0f 1e fa          	endbr64 
    2153:	8d 87 5e 01 81 c1    	lea    -0x3e7efea2(%rdi),%eax
    2159:	c3                   	retq   

000000000000215a <getval_298>:
    215a:	f3 0f 1e fa          	endbr64 
    215e:	b8 89 ca 18 c0       	mov    $0xc018ca89,%eax
    2163:	c3                   	retq   

0000000000002164 <setval_499>:
    2164:	f3 0f 1e fa          	endbr64 
    2168:	c7 07 8d d6 84 d2    	movl   $0xd284d68d,(%rdi)
    216e:	c3                   	retq   

000000000000216f <addval_329>:
    216f:	f3 0f 1e fa          	endbr64 
    2173:	8d 87 6d 89 c1 90    	lea    -0x6f3e7693(%rdi),%eax
    2179:	c3                   	retq   

000000000000217a <setval_360>:
    217a:	f3 0f 1e fa          	endbr64 
    217e:	c7 07 48 89 e0 91    	movl   $0x91e08948,(%rdi)
    2184:	c3                   	retq   

0000000000002185 <setval_101>:
    2185:	f3 0f 1e fa          	endbr64 
    2189:	c7 07 48 89 e0 94    	movl   $0x94e08948,(%rdi)
    218f:	c3                   	retq   

0000000000002190 <end_farm>:
    2190:	f3 0f 1e fa          	endbr64 
    2194:	b8 01 00 00 00       	mov    $0x1,%eax
    2199:	c3                   	retq   

000000000000219a <save_char>:
    219a:	8b 05 64 5e 00 00    	mov    0x5e64(%rip),%eax        # 8004 <gets_cnt>
    21a0:	3d ff 03 00 00       	cmp    $0x3ff,%eax
    21a5:	7f 4a                	jg     21f1 <save_char+0x57>
    21a7:	89 f9                	mov    %edi,%ecx
    21a9:	c0 e9 04             	shr    $0x4,%cl
    21ac:	8d 14 40             	lea    (%rax,%rax,2),%edx
    21af:	4c 8d 05 9a 25 00 00 	lea    0x259a(%rip),%r8        # 4750 <trans_char>
    21b6:	83 e1 0f             	and    $0xf,%ecx
    21b9:	45 0f b6 0c 08       	movzbl (%r8,%rcx,1),%r9d
    21be:	48 8d 0d 3b 52 00 00 	lea    0x523b(%rip),%rcx        # 7400 <gets_buf>
    21c5:	48 63 f2             	movslq %edx,%rsi
    21c8:	44 88 0c 31          	mov    %r9b,(%rcx,%rsi,1)
    21cc:	8d 72 01             	lea    0x1(%rdx),%esi
    21cf:	83 e7 0f             	and    $0xf,%edi
    21d2:	41 0f b6 3c 38       	movzbl (%r8,%rdi,1),%edi
    21d7:	48 63 f6             	movslq %esi,%rsi
    21da:	40 88 3c 31          	mov    %dil,(%rcx,%rsi,1)
    21de:	83 c2 02             	add    $0x2,%edx
    21e1:	48 63 d2             	movslq %edx,%rdx
    21e4:	c6 04 11 20          	movb   $0x20,(%rcx,%rdx,1)
    21e8:	83 c0 01             	add    $0x1,%eax
    21eb:	89 05 13 5e 00 00    	mov    %eax,0x5e13(%rip)        # 8004 <gets_cnt>
    21f1:	c3                   	retq   

00000000000021f2 <save_term>:
    21f2:	8b 05 0c 5e 00 00    	mov    0x5e0c(%rip),%eax        # 8004 <gets_cnt>
    21f8:	8d 04 40             	lea    (%rax,%rax,2),%eax
    21fb:	48 98                	cltq   
    21fd:	48 8d 15 fc 51 00 00 	lea    0x51fc(%rip),%rdx        # 7400 <gets_buf>
    2204:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
    2208:	c3                   	retq   

0000000000002209 <check_fail>:
    2209:	f3 0f 1e fa          	endbr64 
    220d:	50                   	push   %rax
    220e:	58                   	pop    %rax
    220f:	48 83 ec 08          	sub    $0x8,%rsp
    2213:	0f be 15 ee 5d 00 00 	movsbl 0x5dee(%rip),%edx        # 8008 <target_prefix>
    221a:	4c 8d 05 df 51 00 00 	lea    0x51df(%rip),%r8        # 7400 <gets_buf>
    2221:	8b 0d b1 51 00 00    	mov    0x51b1(%rip),%ecx        # 73d8 <check_level>
    2227:	48 8d 35 1d 22 00 00 	lea    0x221d(%rip),%rsi        # 444b <_IO_stdin_used+0x44b>
    222e:	bf 01 00 00 00       	mov    $0x1,%edi
    2233:	b8 00 00 00 00       	mov    $0x0,%eax
    2238:	e8 73 f1 ff ff       	callq  13b0 <__printf_chk@plt>
    223d:	bf 01 00 00 00       	mov    $0x1,%edi
    2242:	e8 b9 f1 ff ff       	callq  1400 <exit@plt>

0000000000002247 <Gets>:
    2247:	f3 0f 1e fa          	endbr64 
    224b:	41 54                	push   %r12
    224d:	55                   	push   %rbp
    224e:	53                   	push   %rbx
    224f:	49 89 fc             	mov    %rdi,%r12
    2252:	c7 05 a8 5d 00 00 00 	movl   $0x0,0x5da8(%rip)        # 8004 <gets_cnt>
    2259:	00 00 00 
    225c:	48 89 fb             	mov    %rdi,%rbx
    225f:	48 8b 3d 6a 51 00 00 	mov    0x516a(%rip),%rdi        # 73d0 <infile>
    2266:	e8 c5 f1 ff ff       	callq  1430 <getc@plt>
    226b:	83 f8 ff             	cmp    $0xffffffff,%eax
    226e:	74 18                	je     2288 <Gets+0x41>
    2270:	83 f8 0a             	cmp    $0xa,%eax
    2273:	74 13                	je     2288 <Gets+0x41>
    2275:	48 8d 6b 01          	lea    0x1(%rbx),%rbp
    2279:	88 03                	mov    %al,(%rbx)
    227b:	0f b6 f8             	movzbl %al,%edi
    227e:	e8 17 ff ff ff       	callq  219a <save_char>
    2283:	48 89 eb             	mov    %rbp,%rbx
    2286:	eb d7                	jmp    225f <Gets+0x18>
    2288:	c6 03 00             	movb   $0x0,(%rbx)
    228b:	b8 00 00 00 00       	mov    $0x0,%eax
    2290:	e8 5d ff ff ff       	callq  21f2 <save_term>
    2295:	4c 89 e0             	mov    %r12,%rax
    2298:	5b                   	pop    %rbx
    2299:	5d                   	pop    %rbp
    229a:	41 5c                	pop    %r12
    229c:	c3                   	retq   

000000000000229d <notify_server>:
    229d:	f3 0f 1e fa          	endbr64 
    22a1:	55                   	push   %rbp
    22a2:	53                   	push   %rbx
    22a3:	4c 8d 9c 24 00 c0 ff 	lea    -0x4000(%rsp),%r11
    22aa:	ff 
    22ab:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    22b2:	48 83 0c 24 00       	orq    $0x0,(%rsp)
    22b7:	4c 39 dc             	cmp    %r11,%rsp
    22ba:	75 ef                	jne    22ab <notify_server+0xe>
    22bc:	48 83 ec 18          	sub    $0x18,%rsp
    22c0:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    22c7:	00 00 
    22c9:	48 89 84 24 08 40 00 	mov    %rax,0x4008(%rsp)
    22d0:	00 
    22d1:	31 c0                	xor    %eax,%eax
    22d3:	83 3d 0e 51 00 00 00 	cmpl   $0x0,0x510e(%rip)        # 73e8 <is_checker>
    22da:	0f 85 26 01 00 00    	jne    2406 <notify_server+0x169>
    22e0:	89 fb                	mov    %edi,%ebx
    22e2:	81 3d 18 5d 00 00 9c 	cmpl   $0x1f9c,0x5d18(%rip)        # 8004 <gets_cnt>
    22e9:	1f 00 00 
    22ec:	7f 18                	jg     2306 <notify_server+0x69>
    22ee:	0f be 05 13 5d 00 00 	movsbl 0x5d13(%rip),%eax        # 8008 <target_prefix>
    22f5:	83 3d 6c 50 00 00 00 	cmpl   $0x0,0x506c(%rip)        # 7368 <notify>
    22fc:	74 23                	je     2321 <notify_server+0x84>
    22fe:	8b 15 dc 50 00 00    	mov    0x50dc(%rip),%edx        # 73e0 <authkey>
    2304:	eb 20                	jmp    2326 <notify_server+0x89>
    2306:	48 8d 35 73 22 00 00 	lea    0x2273(%rip),%rsi        # 4580 <_IO_stdin_used+0x580>
    230d:	bf 01 00 00 00       	mov    $0x1,%edi
    2312:	e8 99 f0 ff ff       	callq  13b0 <__printf_chk@plt>
    2317:	bf 01 00 00 00       	mov    $0x1,%edi
    231c:	e8 df f0 ff ff       	callq  1400 <exit@plt>
    2321:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    2326:	85 db                	test   %ebx,%ebx
    2328:	0f 84 98 00 00 00    	je     23c6 <notify_server+0x129>
    232e:	48 8d 2d 31 21 00 00 	lea    0x2131(%rip),%rbp        # 4466 <_IO_stdin_used+0x466>
    2335:	48 89 e7             	mov    %rsp,%rdi
    2338:	48 8d 0d c1 50 00 00 	lea    0x50c1(%rip),%rcx        # 7400 <gets_buf>
    233f:	51                   	push   %rcx
    2340:	56                   	push   %rsi
    2341:	50                   	push   %rax
    2342:	52                   	push   %rdx
    2343:	49 89 e9             	mov    %rbp,%r9
    2346:	44 8b 05 c3 4c 00 00 	mov    0x4cc3(%rip),%r8d        # 7010 <target_id>
    234d:	48 8d 0d 17 21 00 00 	lea    0x2117(%rip),%rcx        # 446b <_IO_stdin_used+0x46b>
    2354:	ba 00 20 00 00       	mov    $0x2000,%edx
    2359:	be 01 00 00 00       	mov    $0x1,%esi
    235e:	b8 00 00 00 00       	mov    $0x0,%eax
    2363:	e8 d8 f0 ff ff       	callq  1440 <__sprintf_chk@plt>
    2368:	48 83 c4 20          	add    $0x20,%rsp
    236c:	83 3d f5 4f 00 00 00 	cmpl   $0x0,0x4ff5(%rip)        # 7368 <notify>
    2373:	0f 84 ae 00 00 00    	je     2427 <notify_server+0x18a>
    2379:	85 db                	test   %ebx,%ebx
    237b:	74 7d                	je     23fa <notify_server+0x15d>
    237d:	48 89 e1             	mov    %rsp,%rcx
    2380:	4c 8d 8c 24 00 20 00 	lea    0x2000(%rsp),%r9
    2387:	00 
    2388:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    238e:	48 8b 15 93 4c 00 00 	mov    0x4c93(%rip),%rdx        # 7028 <lab>
    2395:	48 8b 35 94 4c 00 00 	mov    0x4c94(%rip),%rsi        # 7030 <course>
    239c:	48 8b 3d 7d 4c 00 00 	mov    0x4c7d(%rip),%rdi        # 7020 <user_id>
    23a3:	e8 d9 11 00 00       	callq  3581 <driver_post>
    23a8:	85 c0                	test   %eax,%eax
    23aa:	78 26                	js     23d2 <notify_server+0x135>
    23ac:	48 8d 3d fd 21 00 00 	lea    0x21fd(%rip),%rdi        # 45b0 <_IO_stdin_used+0x5b0>
    23b3:	e8 e8 ee ff ff       	callq  12a0 <puts@plt>
    23b8:	48 8d 3d d4 20 00 00 	lea    0x20d4(%rip),%rdi        # 4493 <_IO_stdin_used+0x493>
    23bf:	e8 dc ee ff ff       	callq  12a0 <puts@plt>
    23c4:	eb 40                	jmp    2406 <notify_server+0x169>
    23c6:	48 8d 2d 94 20 00 00 	lea    0x2094(%rip),%rbp        # 4461 <_IO_stdin_used+0x461>
    23cd:	e9 63 ff ff ff       	jmpq   2335 <notify_server+0x98>
    23d2:	48 8d 94 24 00 20 00 	lea    0x2000(%rsp),%rdx
    23d9:	00 
    23da:	48 8d 35 a6 20 00 00 	lea    0x20a6(%rip),%rsi        # 4487 <_IO_stdin_used+0x487>
    23e1:	bf 01 00 00 00       	mov    $0x1,%edi
    23e6:	b8 00 00 00 00       	mov    $0x0,%eax
    23eb:	e8 c0 ef ff ff       	callq  13b0 <__printf_chk@plt>
    23f0:	bf 01 00 00 00       	mov    $0x1,%edi
    23f5:	e8 06 f0 ff ff       	callq  1400 <exit@plt>
    23fa:	48 8d 3d 9c 20 00 00 	lea    0x209c(%rip),%rdi        # 449d <_IO_stdin_used+0x49d>
    2401:	e8 9a ee ff ff       	callq  12a0 <puts@plt>
    2406:	48 8b 84 24 08 40 00 	mov    0x4008(%rsp),%rax
    240d:	00 
    240e:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    2415:	00 00 
    2417:	0f 85 98 00 00 00    	jne    24b5 <notify_server+0x218>
    241d:	48 81 c4 18 40 00 00 	add    $0x4018,%rsp
    2424:	5b                   	pop    %rbx
    2425:	5d                   	pop    %rbp
    2426:	c3                   	retq   
    2427:	48 89 ea             	mov    %rbp,%rdx
    242a:	48 8d 35 b7 21 00 00 	lea    0x21b7(%rip),%rsi        # 45e8 <_IO_stdin_used+0x5e8>
    2431:	bf 01 00 00 00       	mov    $0x1,%edi
    2436:	b8 00 00 00 00       	mov    $0x0,%eax
    243b:	e8 70 ef ff ff       	callq  13b0 <__printf_chk@plt>
    2440:	48 8b 15 d9 4b 00 00 	mov    0x4bd9(%rip),%rdx        # 7020 <user_id>
    2447:	48 8d 35 56 20 00 00 	lea    0x2056(%rip),%rsi        # 44a4 <_IO_stdin_used+0x4a4>
    244e:	bf 01 00 00 00       	mov    $0x1,%edi
    2453:	b8 00 00 00 00       	mov    $0x0,%eax
    2458:	e8 53 ef ff ff       	callq  13b0 <__printf_chk@plt>
    245d:	48 8b 15 cc 4b 00 00 	mov    0x4bcc(%rip),%rdx        # 7030 <course>
    2464:	48 8d 35 46 20 00 00 	lea    0x2046(%rip),%rsi        # 44b1 <_IO_stdin_used+0x4b1>
    246b:	bf 01 00 00 00       	mov    $0x1,%edi
    2470:	b8 00 00 00 00       	mov    $0x0,%eax
    2475:	e8 36 ef ff ff       	callq  13b0 <__printf_chk@plt>
    247a:	48 8b 15 a7 4b 00 00 	mov    0x4ba7(%rip),%rdx        # 7028 <lab>
    2481:	48 8d 35 35 20 00 00 	lea    0x2035(%rip),%rsi        # 44bd <_IO_stdin_used+0x4bd>
    2488:	bf 01 00 00 00       	mov    $0x1,%edi
    248d:	b8 00 00 00 00       	mov    $0x0,%eax
    2492:	e8 19 ef ff ff       	callq  13b0 <__printf_chk@plt>
    2497:	48 89 e2             	mov    %rsp,%rdx
    249a:	48 8d 35 25 20 00 00 	lea    0x2025(%rip),%rsi        # 44c6 <_IO_stdin_used+0x4c6>
    24a1:	bf 01 00 00 00       	mov    $0x1,%edi
    24a6:	b8 00 00 00 00       	mov    $0x0,%eax
    24ab:	e8 00 ef ff ff       	callq  13b0 <__printf_chk@plt>
    24b0:	e9 51 ff ff ff       	jmpq   2406 <notify_server+0x169>
    24b5:	e8 06 ee ff ff       	callq  12c0 <__stack_chk_fail@plt>

00000000000024ba <validate>:
    24ba:	f3 0f 1e fa          	endbr64 
    24be:	53                   	push   %rbx
    24bf:	89 fb                	mov    %edi,%ebx
    24c1:	83 3d 20 4f 00 00 00 	cmpl   $0x0,0x4f20(%rip)        # 73e8 <is_checker>
    24c8:	74 72                	je     253c <validate+0x82>
    24ca:	39 3d 0c 4f 00 00    	cmp    %edi,0x4f0c(%rip)        # 73dc <vlevel>
    24d0:	75 32                	jne    2504 <validate+0x4a>
    24d2:	8b 15 00 4f 00 00    	mov    0x4f00(%rip),%edx        # 73d8 <check_level>
    24d8:	39 fa                	cmp    %edi,%edx
    24da:	75 3e                	jne    251a <validate+0x60>
    24dc:	0f be 15 25 5b 00 00 	movsbl 0x5b25(%rip),%edx        # 8008 <target_prefix>
    24e3:	4c 8d 05 16 4f 00 00 	lea    0x4f16(%rip),%r8        # 7400 <gets_buf>
    24ea:	89 f9                	mov    %edi,%ecx
    24ec:	48 8d 35 fd 1f 00 00 	lea    0x1ffd(%rip),%rsi        # 44f0 <_IO_stdin_used+0x4f0>
    24f3:	bf 01 00 00 00       	mov    $0x1,%edi
    24f8:	b8 00 00 00 00       	mov    $0x0,%eax
    24fd:	e8 ae ee ff ff       	callq  13b0 <__printf_chk@plt>
    2502:	5b                   	pop    %rbx
    2503:	c3                   	retq   
    2504:	48 8d 3d c7 1f 00 00 	lea    0x1fc7(%rip),%rdi        # 44d2 <_IO_stdin_used+0x4d2>
    250b:	e8 90 ed ff ff       	callq  12a0 <puts@plt>
    2510:	b8 00 00 00 00       	mov    $0x0,%eax
    2515:	e8 ef fc ff ff       	callq  2209 <check_fail>
    251a:	89 f9                	mov    %edi,%ecx
    251c:	48 8d 35 ed 20 00 00 	lea    0x20ed(%rip),%rsi        # 4610 <_IO_stdin_used+0x610>
    2523:	bf 01 00 00 00       	mov    $0x1,%edi
    2528:	b8 00 00 00 00       	mov    $0x0,%eax
    252d:	e8 7e ee ff ff       	callq  13b0 <__printf_chk@plt>
    2532:	b8 00 00 00 00       	mov    $0x0,%eax
    2537:	e8 cd fc ff ff       	callq  2209 <check_fail>
    253c:	39 3d 9a 4e 00 00    	cmp    %edi,0x4e9a(%rip)        # 73dc <vlevel>
    2542:	74 1a                	je     255e <validate+0xa4>
    2544:	48 8d 3d 87 1f 00 00 	lea    0x1f87(%rip),%rdi        # 44d2 <_IO_stdin_used+0x4d2>
    254b:	e8 50 ed ff ff       	callq  12a0 <puts@plt>
    2550:	89 de                	mov    %ebx,%esi
    2552:	bf 00 00 00 00       	mov    $0x0,%edi
    2557:	e8 41 fd ff ff       	callq  229d <notify_server>
    255c:	eb a4                	jmp    2502 <validate+0x48>
    255e:	0f be 0d a3 5a 00 00 	movsbl 0x5aa3(%rip),%ecx        # 8008 <target_prefix>
    2565:	89 fa                	mov    %edi,%edx
    2567:	48 8d 35 ca 20 00 00 	lea    0x20ca(%rip),%rsi        # 4638 <_IO_stdin_used+0x638>
    256e:	bf 01 00 00 00       	mov    $0x1,%edi
    2573:	b8 00 00 00 00       	mov    $0x0,%eax
    2578:	e8 33 ee ff ff       	callq  13b0 <__printf_chk@plt>
    257d:	89 de                	mov    %ebx,%esi
    257f:	bf 01 00 00 00       	mov    $0x1,%edi
    2584:	e8 14 fd ff ff       	callq  229d <notify_server>
    2589:	e9 74 ff ff ff       	jmpq   2502 <validate+0x48>

000000000000258e <fail>:
    258e:	f3 0f 1e fa          	endbr64 
    2592:	48 83 ec 08          	sub    $0x8,%rsp
    2596:	83 3d 4b 4e 00 00 00 	cmpl   $0x0,0x4e4b(%rip)        # 73e8 <is_checker>
    259d:	75 11                	jne    25b0 <fail+0x22>
    259f:	89 fe                	mov    %edi,%esi
    25a1:	bf 00 00 00 00       	mov    $0x0,%edi
    25a6:	e8 f2 fc ff ff       	callq  229d <notify_server>
    25ab:	48 83 c4 08          	add    $0x8,%rsp
    25af:	c3                   	retq   
    25b0:	b8 00 00 00 00       	mov    $0x0,%eax
    25b5:	e8 4f fc ff ff       	callq  2209 <check_fail>

00000000000025ba <bushandler>:
    25ba:	f3 0f 1e fa          	endbr64 
    25be:	50                   	push   %rax
    25bf:	58                   	pop    %rax
    25c0:	48 83 ec 08          	sub    $0x8,%rsp
    25c4:	83 3d 1d 4e 00 00 00 	cmpl   $0x0,0x4e1d(%rip)        # 73e8 <is_checker>
    25cb:	74 16                	je     25e3 <bushandler+0x29>
    25cd:	48 8d 3d 31 1f 00 00 	lea    0x1f31(%rip),%rdi        # 4505 <_IO_stdin_used+0x505>
    25d4:	e8 c7 ec ff ff       	callq  12a0 <puts@plt>
    25d9:	b8 00 00 00 00       	mov    $0x0,%eax
    25de:	e8 26 fc ff ff       	callq  2209 <check_fail>
    25e3:	48 8d 3d 86 20 00 00 	lea    0x2086(%rip),%rdi        # 4670 <_IO_stdin_used+0x670>
    25ea:	e8 b1 ec ff ff       	callq  12a0 <puts@plt>
    25ef:	48 8d 3d 19 1f 00 00 	lea    0x1f19(%rip),%rdi        # 450f <_IO_stdin_used+0x50f>
    25f6:	e8 a5 ec ff ff       	callq  12a0 <puts@plt>
    25fb:	be 00 00 00 00       	mov    $0x0,%esi
    2600:	bf 00 00 00 00       	mov    $0x0,%edi
    2605:	e8 93 fc ff ff       	callq  229d <notify_server>
    260a:	bf 01 00 00 00       	mov    $0x1,%edi
    260f:	e8 ec ed ff ff       	callq  1400 <exit@plt>

0000000000002614 <seghandler>:
    2614:	f3 0f 1e fa          	endbr64 
    2618:	50                   	push   %rax
    2619:	58                   	pop    %rax
    261a:	48 83 ec 08          	sub    $0x8,%rsp
    261e:	83 3d c3 4d 00 00 00 	cmpl   $0x0,0x4dc3(%rip)        # 73e8 <is_checker>
    2625:	74 16                	je     263d <seghandler+0x29>
    2627:	48 8d 3d f7 1e 00 00 	lea    0x1ef7(%rip),%rdi        # 4525 <_IO_stdin_used+0x525>
    262e:	e8 6d ec ff ff       	callq  12a0 <puts@plt>
    2633:	b8 00 00 00 00       	mov    $0x0,%eax
    2638:	e8 cc fb ff ff       	callq  2209 <check_fail>
    263d:	48 8d 3d 4c 20 00 00 	lea    0x204c(%rip),%rdi        # 4690 <_IO_stdin_used+0x690>
    2644:	e8 57 ec ff ff       	callq  12a0 <puts@plt>
    2649:	48 8d 3d bf 1e 00 00 	lea    0x1ebf(%rip),%rdi        # 450f <_IO_stdin_used+0x50f>
    2650:	e8 4b ec ff ff       	callq  12a0 <puts@plt>
    2655:	be 00 00 00 00       	mov    $0x0,%esi
    265a:	bf 00 00 00 00       	mov    $0x0,%edi
    265f:	e8 39 fc ff ff       	callq  229d <notify_server>
    2664:	bf 01 00 00 00       	mov    $0x1,%edi
    2669:	e8 92 ed ff ff       	callq  1400 <exit@plt>

000000000000266e <illegalhandler>:
    266e:	f3 0f 1e fa          	endbr64 
    2672:	50                   	push   %rax
    2673:	58                   	pop    %rax
    2674:	48 83 ec 08          	sub    $0x8,%rsp
    2678:	83 3d 69 4d 00 00 00 	cmpl   $0x0,0x4d69(%rip)        # 73e8 <is_checker>
    267f:	74 16                	je     2697 <illegalhandler+0x29>
    2681:	48 8d 3d b0 1e 00 00 	lea    0x1eb0(%rip),%rdi        # 4538 <_IO_stdin_used+0x538>
    2688:	e8 13 ec ff ff       	callq  12a0 <puts@plt>
    268d:	b8 00 00 00 00       	mov    $0x0,%eax
    2692:	e8 72 fb ff ff       	callq  2209 <check_fail>
    2697:	48 8d 3d 1a 20 00 00 	lea    0x201a(%rip),%rdi        # 46b8 <_IO_stdin_used+0x6b8>
    269e:	e8 fd eb ff ff       	callq  12a0 <puts@plt>
    26a3:	48 8d 3d 65 1e 00 00 	lea    0x1e65(%rip),%rdi        # 450f <_IO_stdin_used+0x50f>
    26aa:	e8 f1 eb ff ff       	callq  12a0 <puts@plt>
    26af:	be 00 00 00 00       	mov    $0x0,%esi
    26b4:	bf 00 00 00 00       	mov    $0x0,%edi
    26b9:	e8 df fb ff ff       	callq  229d <notify_server>
    26be:	bf 01 00 00 00       	mov    $0x1,%edi
    26c3:	e8 38 ed ff ff       	callq  1400 <exit@plt>

00000000000026c8 <sigalrmhandler>:
    26c8:	f3 0f 1e fa          	endbr64 
    26cc:	50                   	push   %rax
    26cd:	58                   	pop    %rax
    26ce:	48 83 ec 08          	sub    $0x8,%rsp
    26d2:	83 3d 0f 4d 00 00 00 	cmpl   $0x0,0x4d0f(%rip)        # 73e8 <is_checker>
    26d9:	74 16                	je     26f1 <sigalrmhandler+0x29>
    26db:	48 8d 3d 6a 1e 00 00 	lea    0x1e6a(%rip),%rdi        # 454c <_IO_stdin_used+0x54c>
    26e2:	e8 b9 eb ff ff       	callq  12a0 <puts@plt>
    26e7:	b8 00 00 00 00       	mov    $0x0,%eax
    26ec:	e8 18 fb ff ff       	callq  2209 <check_fail>
    26f1:	ba 05 00 00 00       	mov    $0x5,%edx
    26f6:	48 8d 35 eb 1f 00 00 	lea    0x1feb(%rip),%rsi        # 46e8 <_IO_stdin_used+0x6e8>
    26fd:	bf 01 00 00 00       	mov    $0x1,%edi
    2702:	b8 00 00 00 00       	mov    $0x0,%eax
    2707:	e8 a4 ec ff ff       	callq  13b0 <__printf_chk@plt>
    270c:	be 00 00 00 00       	mov    $0x0,%esi
    2711:	bf 00 00 00 00       	mov    $0x0,%edi
    2716:	e8 82 fb ff ff       	callq  229d <notify_server>
    271b:	bf 01 00 00 00       	mov    $0x1,%edi
    2720:	e8 db ec ff ff       	callq  1400 <exit@plt>

0000000000002725 <launch>:
    2725:	f3 0f 1e fa          	endbr64 
    2729:	55                   	push   %rbp
    272a:	48 89 e5             	mov    %rsp,%rbp
    272d:	48 83 ec 10          	sub    $0x10,%rsp
    2731:	48 89 fa             	mov    %rdi,%rdx
    2734:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    273b:	00 00 
    273d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    2741:	31 c0                	xor    %eax,%eax
    2743:	48 8d 47 17          	lea    0x17(%rdi),%rax
    2747:	48 89 c1             	mov    %rax,%rcx
    274a:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    274e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
    2754:	48 89 e6             	mov    %rsp,%rsi
    2757:	48 29 c6             	sub    %rax,%rsi
    275a:	48 89 f0             	mov    %rsi,%rax
    275d:	48 39 c4             	cmp    %rax,%rsp
    2760:	74 12                	je     2774 <launch+0x4f>
    2762:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    2769:	48 83 8c 24 f8 0f 00 	orq    $0x0,0xff8(%rsp)
    2770:	00 00 
    2772:	eb e9                	jmp    275d <launch+0x38>
    2774:	48 89 c8             	mov    %rcx,%rax
    2777:	25 ff 0f 00 00       	and    $0xfff,%eax
    277c:	48 29 c4             	sub    %rax,%rsp
    277f:	48 85 c0             	test   %rax,%rax
    2782:	74 06                	je     278a <launch+0x65>
    2784:	48 83 4c 04 f8 00    	orq    $0x0,-0x8(%rsp,%rax,1)
    278a:	48 8d 7c 24 0f       	lea    0xf(%rsp),%rdi
    278f:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
    2793:	be f4 00 00 00       	mov    $0xf4,%esi
    2798:	e8 43 eb ff ff       	callq  12e0 <memset@plt>
    279d:	48 8b 05 dc 4b 00 00 	mov    0x4bdc(%rip),%rax        # 7380 <stdin@@GLIBC_2.2.5>
    27a4:	48 39 05 25 4c 00 00 	cmp    %rax,0x4c25(%rip)        # 73d0 <infile>
    27ab:	74 3a                	je     27e7 <launch+0xc2>
    27ad:	c7 05 25 4c 00 00 00 	movl   $0x0,0x4c25(%rip)        # 73dc <vlevel>
    27b4:	00 00 00 
    27b7:	b8 00 00 00 00       	mov    $0x0,%eax
    27bc:	e8 d6 f7 ff ff       	callq  1f97 <test>
    27c1:	83 3d 20 4c 00 00 00 	cmpl   $0x0,0x4c20(%rip)        # 73e8 <is_checker>
    27c8:	75 35                	jne    27ff <launch+0xda>
    27ca:	48 8d 3d 9b 1d 00 00 	lea    0x1d9b(%rip),%rdi        # 456c <_IO_stdin_used+0x56c>
    27d1:	e8 ca ea ff ff       	callq  12a0 <puts@plt>
    27d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    27da:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    27e1:	00 00 
    27e3:	75 30                	jne    2815 <launch+0xf0>
    27e5:	c9                   	leaveq 
    27e6:	c3                   	retq   
    27e7:	48 8d 35 66 1d 00 00 	lea    0x1d66(%rip),%rsi        # 4554 <_IO_stdin_used+0x554>
    27ee:	bf 01 00 00 00       	mov    $0x1,%edi
    27f3:	b8 00 00 00 00       	mov    $0x0,%eax
    27f8:	e8 b3 eb ff ff       	callq  13b0 <__printf_chk@plt>
    27fd:	eb ae                	jmp    27ad <launch+0x88>
    27ff:	48 8d 3d 5b 1d 00 00 	lea    0x1d5b(%rip),%rdi        # 4561 <_IO_stdin_used+0x561>
    2806:	e8 95 ea ff ff       	callq  12a0 <puts@plt>
    280b:	b8 00 00 00 00       	mov    $0x0,%eax
    2810:	e8 f4 f9 ff ff       	callq  2209 <check_fail>
    2815:	e8 a6 ea ff ff       	callq  12c0 <__stack_chk_fail@plt>

000000000000281a <stable_launch>:
    281a:	f3 0f 1e fa          	endbr64 
    281e:	53                   	push   %rbx
    281f:	48 89 3d a2 4b 00 00 	mov    %rdi,0x4ba2(%rip)        # 73c8 <global_offset>
    2826:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    282c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    2832:	b9 32 01 00 00       	mov    $0x132,%ecx
    2837:	ba 07 00 00 00       	mov    $0x7,%edx
    283c:	be 00 00 10 00       	mov    $0x100000,%esi
    2841:	bf 00 60 58 55       	mov    $0x55586000,%edi
    2846:	e8 85 ea ff ff       	callq  12d0 <mmap@plt>
    284b:	48 89 c3             	mov    %rax,%rbx
    284e:	48 3d 00 60 58 55    	cmp    $0x55586000,%rax
    2854:	75 43                	jne    2899 <stable_launch+0x7f>
    2856:	48 8d 90 f8 ff 0f 00 	lea    0xffff8(%rax),%rdx
    285d:	48 89 15 ac 57 00 00 	mov    %rdx,0x57ac(%rip)        # 8010 <stack_top>
    2864:	48 89 e0             	mov    %rsp,%rax
    2867:	48 89 d4             	mov    %rdx,%rsp
    286a:	48 89 c2             	mov    %rax,%rdx
    286d:	48 89 15 4c 4b 00 00 	mov    %rdx,0x4b4c(%rip)        # 73c0 <global_save_stack>
    2874:	48 8b 3d 4d 4b 00 00 	mov    0x4b4d(%rip),%rdi        # 73c8 <global_offset>
    287b:	e8 a5 fe ff ff       	callq  2725 <launch>
    2880:	48 8b 05 39 4b 00 00 	mov    0x4b39(%rip),%rax        # 73c0 <global_save_stack>
    2887:	48 89 c4             	mov    %rax,%rsp
    288a:	be 00 00 10 00       	mov    $0x100000,%esi
    288f:	48 89 df             	mov    %rbx,%rdi
    2892:	e8 09 eb ff ff       	callq  13a0 <munmap@plt>
    2897:	5b                   	pop    %rbx
    2898:	c3                   	retq   
    2899:	be 00 00 10 00       	mov    $0x100000,%esi
    289e:	48 89 c7             	mov    %rax,%rdi
    28a1:	e8 fa ea ff ff       	callq  13a0 <munmap@plt>
    28a6:	b9 00 60 58 55       	mov    $0x55586000,%ecx
    28ab:	48 8d 15 6e 1e 00 00 	lea    0x1e6e(%rip),%rdx        # 4720 <_IO_stdin_used+0x720>
    28b2:	be 01 00 00 00       	mov    $0x1,%esi
    28b7:	48 8b 3d e2 4a 00 00 	mov    0x4ae2(%rip),%rdi        # 73a0 <stderr@@GLIBC_2.2.5>
    28be:	b8 00 00 00 00       	mov    $0x0,%eax
    28c3:	e8 58 eb ff ff       	callq  1420 <__fprintf_chk@plt>
    28c8:	bf 01 00 00 00       	mov    $0x1,%edi
    28cd:	e8 2e eb ff ff       	callq  1400 <exit@plt>

00000000000028d2 <rio_readinitb>:
    28d2:	89 37                	mov    %esi,(%rdi)
    28d4:	c7 47 04 00 00 00 00 	movl   $0x0,0x4(%rdi)
    28db:	48 8d 47 10          	lea    0x10(%rdi),%rax
    28df:	48 89 47 08          	mov    %rax,0x8(%rdi)
    28e3:	c3                   	retq   

00000000000028e4 <sigalrm_handler>:
    28e4:	f3 0f 1e fa          	endbr64 
    28e8:	50                   	push   %rax
    28e9:	58                   	pop    %rax
    28ea:	48 83 ec 08          	sub    $0x8,%rsp
    28ee:	b9 00 00 00 00       	mov    $0x0,%ecx
    28f3:	48 8d 15 66 1e 00 00 	lea    0x1e66(%rip),%rdx        # 4760 <trans_char+0x10>
    28fa:	be 01 00 00 00       	mov    $0x1,%esi
    28ff:	48 8b 3d 9a 4a 00 00 	mov    0x4a9a(%rip),%rdi        # 73a0 <stderr@@GLIBC_2.2.5>
    2906:	b8 00 00 00 00       	mov    $0x0,%eax
    290b:	e8 10 eb ff ff       	callq  1420 <__fprintf_chk@plt>
    2910:	bf 01 00 00 00       	mov    $0x1,%edi
    2915:	e8 e6 ea ff ff       	callq  1400 <exit@plt>

000000000000291a <rio_writen>:
    291a:	41 55                	push   %r13
    291c:	41 54                	push   %r12
    291e:	55                   	push   %rbp
    291f:	53                   	push   %rbx
    2920:	48 83 ec 08          	sub    $0x8,%rsp
    2924:	41 89 fc             	mov    %edi,%r12d
    2927:	48 89 f5             	mov    %rsi,%rbp
    292a:	49 89 d5             	mov    %rdx,%r13
    292d:	48 89 d3             	mov    %rdx,%rbx
    2930:	eb 06                	jmp    2938 <rio_writen+0x1e>
    2932:	48 29 c3             	sub    %rax,%rbx
    2935:	48 01 c5             	add    %rax,%rbp
    2938:	48 85 db             	test   %rbx,%rbx
    293b:	74 24                	je     2961 <rio_writen+0x47>
    293d:	48 89 da             	mov    %rbx,%rdx
    2940:	48 89 ee             	mov    %rbp,%rsi
    2943:	44 89 e7             	mov    %r12d,%edi
    2946:	e8 65 e9 ff ff       	callq  12b0 <write@plt>
    294b:	48 85 c0             	test   %rax,%rax
    294e:	7f e2                	jg     2932 <rio_writen+0x18>
    2950:	e8 0b e9 ff ff       	callq  1260 <__errno_location@plt>
    2955:	83 38 04             	cmpl   $0x4,(%rax)
    2958:	75 15                	jne    296f <rio_writen+0x55>
    295a:	b8 00 00 00 00       	mov    $0x0,%eax
    295f:	eb d1                	jmp    2932 <rio_writen+0x18>
    2961:	4c 89 e8             	mov    %r13,%rax
    2964:	48 83 c4 08          	add    $0x8,%rsp
    2968:	5b                   	pop    %rbx
    2969:	5d                   	pop    %rbp
    296a:	41 5c                	pop    %r12
    296c:	41 5d                	pop    %r13
    296e:	c3                   	retq   
    296f:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
    2976:	eb ec                	jmp    2964 <rio_writen+0x4a>

0000000000002978 <rio_read>:
    2978:	41 55                	push   %r13
    297a:	41 54                	push   %r12
    297c:	55                   	push   %rbp
    297d:	53                   	push   %rbx
    297e:	48 83 ec 08          	sub    $0x8,%rsp
    2982:	48 89 fb             	mov    %rdi,%rbx
    2985:	49 89 f5             	mov    %rsi,%r13
    2988:	49 89 d4             	mov    %rdx,%r12
    298b:	eb 17                	jmp    29a4 <rio_read+0x2c>
    298d:	e8 ce e8 ff ff       	callq  1260 <__errno_location@plt>
    2992:	83 38 04             	cmpl   $0x4,(%rax)
    2995:	74 0d                	je     29a4 <rio_read+0x2c>
    2997:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
    299e:	eb 54                	jmp    29f4 <rio_read+0x7c>
    29a0:	48 89 6b 08          	mov    %rbp,0x8(%rbx)
    29a4:	8b 6b 04             	mov    0x4(%rbx),%ebp
    29a7:	85 ed                	test   %ebp,%ebp
    29a9:	7f 23                	jg     29ce <rio_read+0x56>
    29ab:	48 8d 6b 10          	lea    0x10(%rbx),%rbp
    29af:	8b 3b                	mov    (%rbx),%edi
    29b1:	ba 00 20 00 00       	mov    $0x2000,%edx
    29b6:	48 89 ee             	mov    %rbp,%rsi
    29b9:	e8 52 e9 ff ff       	callq  1310 <read@plt>
    29be:	89 43 04             	mov    %eax,0x4(%rbx)
    29c1:	85 c0                	test   %eax,%eax
    29c3:	78 c8                	js     298d <rio_read+0x15>
    29c5:	75 d9                	jne    29a0 <rio_read+0x28>
    29c7:	b8 00 00 00 00       	mov    $0x0,%eax
    29cc:	eb 26                	jmp    29f4 <rio_read+0x7c>
    29ce:	89 e8                	mov    %ebp,%eax
    29d0:	4c 39 e0             	cmp    %r12,%rax
    29d3:	72 03                	jb     29d8 <rio_read+0x60>
    29d5:	44 89 e5             	mov    %r12d,%ebp
    29d8:	4c 63 e5             	movslq %ebp,%r12
    29db:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    29df:	4c 89 e2             	mov    %r12,%rdx
    29e2:	4c 89 ef             	mov    %r13,%rdi
    29e5:	e8 76 e9 ff ff       	callq  1360 <memcpy@plt>
    29ea:	4c 01 63 08          	add    %r12,0x8(%rbx)
    29ee:	29 6b 04             	sub    %ebp,0x4(%rbx)
    29f1:	4c 89 e0             	mov    %r12,%rax
    29f4:	48 83 c4 08          	add    $0x8,%rsp
    29f8:	5b                   	pop    %rbx
    29f9:	5d                   	pop    %rbp
    29fa:	41 5c                	pop    %r12
    29fc:	41 5d                	pop    %r13
    29fe:	c3                   	retq   

00000000000029ff <rio_readlineb>:
    29ff:	41 55                	push   %r13
    2a01:	41 54                	push   %r12
    2a03:	55                   	push   %rbp
    2a04:	53                   	push   %rbx
    2a05:	48 83 ec 18          	sub    $0x18,%rsp
    2a09:	49 89 fd             	mov    %rdi,%r13
    2a0c:	48 89 f5             	mov    %rsi,%rbp
    2a0f:	49 89 d4             	mov    %rdx,%r12
    2a12:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    2a19:	00 00 
    2a1b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    2a20:	31 c0                	xor    %eax,%eax
    2a22:	bb 01 00 00 00       	mov    $0x1,%ebx
    2a27:	eb 18                	jmp    2a41 <rio_readlineb+0x42>
    2a29:	85 c0                	test   %eax,%eax
    2a2b:	75 65                	jne    2a92 <rio_readlineb+0x93>
    2a2d:	48 83 fb 01          	cmp    $0x1,%rbx
    2a31:	75 3d                	jne    2a70 <rio_readlineb+0x71>
    2a33:	b8 00 00 00 00       	mov    $0x0,%eax
    2a38:	eb 3d                	jmp    2a77 <rio_readlineb+0x78>
    2a3a:	48 83 c3 01          	add    $0x1,%rbx
    2a3e:	48 89 d5             	mov    %rdx,%rbp
    2a41:	4c 39 e3             	cmp    %r12,%rbx
    2a44:	73 2a                	jae    2a70 <rio_readlineb+0x71>
    2a46:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
    2a4b:	ba 01 00 00 00       	mov    $0x1,%edx
    2a50:	4c 89 ef             	mov    %r13,%rdi
    2a53:	e8 20 ff ff ff       	callq  2978 <rio_read>
    2a58:	83 f8 01             	cmp    $0x1,%eax
    2a5b:	75 cc                	jne    2a29 <rio_readlineb+0x2a>
    2a5d:	48 8d 55 01          	lea    0x1(%rbp),%rdx
    2a61:	0f b6 44 24 07       	movzbl 0x7(%rsp),%eax
    2a66:	88 45 00             	mov    %al,0x0(%rbp)
    2a69:	3c 0a                	cmp    $0xa,%al
    2a6b:	75 cd                	jne    2a3a <rio_readlineb+0x3b>
    2a6d:	48 89 d5             	mov    %rdx,%rbp
    2a70:	c6 45 00 00          	movb   $0x0,0x0(%rbp)
    2a74:	48 89 d8             	mov    %rbx,%rax
    2a77:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    2a7c:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
    2a83:	00 00 
    2a85:	75 14                	jne    2a9b <rio_readlineb+0x9c>
    2a87:	48 83 c4 18          	add    $0x18,%rsp
    2a8b:	5b                   	pop    %rbx
    2a8c:	5d                   	pop    %rbp
    2a8d:	41 5c                	pop    %r12
    2a8f:	41 5d                	pop    %r13
    2a91:	c3                   	retq   
    2a92:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
    2a99:	eb dc                	jmp    2a77 <rio_readlineb+0x78>
    2a9b:	e8 20 e8 ff ff       	callq  12c0 <__stack_chk_fail@plt>

0000000000002aa0 <urlencode>:
    2aa0:	41 54                	push   %r12
    2aa2:	55                   	push   %rbp
    2aa3:	53                   	push   %rbx
    2aa4:	48 83 ec 10          	sub    $0x10,%rsp
    2aa8:	48 89 fb             	mov    %rdi,%rbx
    2aab:	48 89 f5             	mov    %rsi,%rbp
    2aae:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    2ab5:	00 00 
    2ab7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    2abc:	31 c0                	xor    %eax,%eax
    2abe:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
    2ac5:	f2 ae                	repnz scas %es:(%rdi),%al
    2ac7:	48 f7 d1             	not    %rcx
    2aca:	8d 41 ff             	lea    -0x1(%rcx),%eax
    2acd:	eb 0f                	jmp    2ade <urlencode+0x3e>
    2acf:	44 88 45 00          	mov    %r8b,0x0(%rbp)
    2ad3:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
    2ad7:	48 83 c3 01          	add    $0x1,%rbx
    2adb:	44 89 e0             	mov    %r12d,%eax
    2ade:	44 8d 60 ff          	lea    -0x1(%rax),%r12d
    2ae2:	85 c0                	test   %eax,%eax
    2ae4:	0f 84 a8 00 00 00    	je     2b92 <urlencode+0xf2>
    2aea:	44 0f b6 03          	movzbl (%rbx),%r8d
    2aee:	41 80 f8 2a          	cmp    $0x2a,%r8b
    2af2:	0f 94 c2             	sete   %dl
    2af5:	41 80 f8 2d          	cmp    $0x2d,%r8b
    2af9:	0f 94 c0             	sete   %al
    2afc:	08 c2                	or     %al,%dl
    2afe:	75 cf                	jne    2acf <urlencode+0x2f>
    2b00:	41 80 f8 2e          	cmp    $0x2e,%r8b
    2b04:	74 c9                	je     2acf <urlencode+0x2f>
    2b06:	41 80 f8 5f          	cmp    $0x5f,%r8b
    2b0a:	74 c3                	je     2acf <urlencode+0x2f>
    2b0c:	41 8d 40 d0          	lea    -0x30(%r8),%eax
    2b10:	3c 09                	cmp    $0x9,%al
    2b12:	76 bb                	jbe    2acf <urlencode+0x2f>
    2b14:	41 8d 40 bf          	lea    -0x41(%r8),%eax
    2b18:	3c 19                	cmp    $0x19,%al
    2b1a:	76 b3                	jbe    2acf <urlencode+0x2f>
    2b1c:	41 8d 40 9f          	lea    -0x61(%r8),%eax
    2b20:	3c 19                	cmp    $0x19,%al
    2b22:	76 ab                	jbe    2acf <urlencode+0x2f>
    2b24:	41 80 f8 20          	cmp    $0x20,%r8b
    2b28:	74 56                	je     2b80 <urlencode+0xe0>
    2b2a:	41 8d 40 e0          	lea    -0x20(%r8),%eax
    2b2e:	3c 5f                	cmp    $0x5f,%al
    2b30:	0f 96 c2             	setbe  %dl
    2b33:	41 80 f8 09          	cmp    $0x9,%r8b
    2b37:	0f 94 c0             	sete   %al
    2b3a:	08 c2                	or     %al,%dl
    2b3c:	74 4f                	je     2b8d <urlencode+0xed>
    2b3e:	48 89 e7             	mov    %rsp,%rdi
    2b41:	45 0f b6 c0          	movzbl %r8b,%r8d
    2b45:	48 8d 0d a9 1c 00 00 	lea    0x1ca9(%rip),%rcx        # 47f5 <trans_char+0xa5>
    2b4c:	ba 08 00 00 00       	mov    $0x8,%edx
    2b51:	be 01 00 00 00       	mov    $0x1,%esi
    2b56:	b8 00 00 00 00       	mov    $0x0,%eax
    2b5b:	e8 e0 e8 ff ff       	callq  1440 <__sprintf_chk@plt>
    2b60:	0f b6 04 24          	movzbl (%rsp),%eax
    2b64:	88 45 00             	mov    %al,0x0(%rbp)
    2b67:	0f b6 44 24 01       	movzbl 0x1(%rsp),%eax
    2b6c:	88 45 01             	mov    %al,0x1(%rbp)
    2b6f:	0f b6 44 24 02       	movzbl 0x2(%rsp),%eax
    2b74:	88 45 02             	mov    %al,0x2(%rbp)
    2b77:	48 8d 6d 03          	lea    0x3(%rbp),%rbp
    2b7b:	e9 57 ff ff ff       	jmpq   2ad7 <urlencode+0x37>
    2b80:	c6 45 00 2b          	movb   $0x2b,0x0(%rbp)
    2b84:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
    2b88:	e9 4a ff ff ff       	jmpq   2ad7 <urlencode+0x37>
    2b8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2b92:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    2b97:	64 48 33 34 25 28 00 	xor    %fs:0x28,%rsi
    2b9e:	00 00 
    2ba0:	75 09                	jne    2bab <urlencode+0x10b>
    2ba2:	48 83 c4 10          	add    $0x10,%rsp
    2ba6:	5b                   	pop    %rbx
    2ba7:	5d                   	pop    %rbp
    2ba8:	41 5c                	pop    %r12
    2baa:	c3                   	retq   
    2bab:	e8 10 e7 ff ff       	callq  12c0 <__stack_chk_fail@plt>

0000000000002bb0 <submitr>:
    2bb0:	f3 0f 1e fa          	endbr64 
    2bb4:	41 57                	push   %r15
    2bb6:	41 56                	push   %r14
    2bb8:	41 55                	push   %r13
    2bba:	41 54                	push   %r12
    2bbc:	55                   	push   %rbp
    2bbd:	53                   	push   %rbx
    2bbe:	4c 8d 9c 24 00 60 ff 	lea    -0xa000(%rsp),%r11
    2bc5:	ff 
    2bc6:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    2bcd:	48 83 0c 24 00       	orq    $0x0,(%rsp)
    2bd2:	4c 39 dc             	cmp    %r11,%rsp
    2bd5:	75 ef                	jne    2bc6 <submitr+0x16>
    2bd7:	48 83 ec 68          	sub    $0x68,%rsp
    2bdb:	49 89 fc             	mov    %rdi,%r12
    2bde:	89 74 24 14          	mov    %esi,0x14(%rsp)
    2be2:	49 89 d6             	mov    %rdx,%r14
    2be5:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
    2bea:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
    2bef:	4d 89 cd             	mov    %r9,%r13
    2bf2:	48 8b ac 24 a0 a0 00 	mov    0xa0a0(%rsp),%rbp
    2bf9:	00 
    2bfa:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    2c01:	00 00 
    2c03:	48 89 84 24 58 a0 00 	mov    %rax,0xa058(%rsp)
    2c0a:	00 
    2c0b:	31 c0                	xor    %eax,%eax
    2c0d:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%rsp)
    2c14:	00 
    2c15:	ba 00 00 00 00       	mov    $0x0,%edx
    2c1a:	be 01 00 00 00       	mov    $0x1,%esi
    2c1f:	bf 02 00 00 00       	mov    $0x2,%edi
    2c24:	e8 27 e8 ff ff       	callq  1450 <socket@plt>
    2c29:	85 c0                	test   %eax,%eax
    2c2b:	0f 88 a0 02 00 00    	js     2ed1 <submitr+0x321>
    2c31:	89 c3                	mov    %eax,%ebx
    2c33:	4c 89 e7             	mov    %r12,%rdi
    2c36:	e8 f5 e6 ff ff       	callq  1330 <gethostbyname@plt>
    2c3b:	48 85 c0             	test   %rax,%rax
    2c3e:	0f 84 d9 02 00 00    	je     2f1d <submitr+0x36d>
    2c44:	4c 8d 7c 24 30       	lea    0x30(%rsp),%r15
    2c49:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    2c50:	00 00 
    2c52:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
    2c59:	00 00 
    2c5b:	66 c7 44 24 30 02 00 	movw   $0x2,0x30(%rsp)
    2c62:	48 63 50 14          	movslq 0x14(%rax),%rdx
    2c66:	48 8b 40 18          	mov    0x18(%rax),%rax
    2c6a:	48 8b 30             	mov    (%rax),%rsi
    2c6d:	48 8d 7c 24 34       	lea    0x34(%rsp),%rdi
    2c72:	b9 0c 00 00 00       	mov    $0xc,%ecx
    2c77:	e8 c4 e6 ff ff       	callq  1340 <__memmove_chk@plt>
    2c7c:	0f b7 74 24 14       	movzwl 0x14(%rsp),%esi
    2c81:	66 c1 c6 08          	rol    $0x8,%si
    2c85:	66 89 74 24 32       	mov    %si,0x32(%rsp)
    2c8a:	ba 10 00 00 00       	mov    $0x10,%edx
    2c8f:	4c 89 fe             	mov    %r15,%rsi
    2c92:	89 df                	mov    %ebx,%edi
    2c94:	e8 77 e7 ff ff       	callq  1410 <connect@plt>
    2c99:	85 c0                	test   %eax,%eax
    2c9b:	0f 88 e4 02 00 00    	js     2f85 <submitr+0x3d5>
    2ca1:	49 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%r8
    2ca8:	b8 00 00 00 00       	mov    $0x0,%eax
    2cad:	4c 89 c1             	mov    %r8,%rcx
    2cb0:	4c 89 ef             	mov    %r13,%rdi
    2cb3:	f2 ae                	repnz scas %es:(%rdi),%al
    2cb5:	48 89 ca             	mov    %rcx,%rdx
    2cb8:	48 f7 d2             	not    %rdx
    2cbb:	4c 89 c1             	mov    %r8,%rcx
    2cbe:	4c 89 f7             	mov    %r14,%rdi
    2cc1:	f2 ae                	repnz scas %es:(%rdi),%al
    2cc3:	48 f7 d1             	not    %rcx
    2cc6:	48 89 ce             	mov    %rcx,%rsi
    2cc9:	4c 89 c1             	mov    %r8,%rcx
    2ccc:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    2cd1:	f2 ae                	repnz scas %es:(%rdi),%al
    2cd3:	48 f7 d1             	not    %rcx
    2cd6:	48 8d 74 0e fe       	lea    -0x2(%rsi,%rcx,1),%rsi
    2cdb:	4c 89 c1             	mov    %r8,%rcx
    2cde:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    2ce3:	f2 ae                	repnz scas %es:(%rdi),%al
    2ce5:	48 89 c8             	mov    %rcx,%rax
    2ce8:	48 f7 d0             	not    %rax
    2ceb:	48 8d 4c 06 ff       	lea    -0x1(%rsi,%rax,1),%rcx
    2cf0:	48 8d 44 52 fd       	lea    -0x3(%rdx,%rdx,2),%rax
    2cf5:	48 8d 84 01 80 00 00 	lea    0x80(%rcx,%rax,1),%rax
    2cfc:	00 
    2cfd:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
    2d03:	0f 87 d6 02 00 00    	ja     2fdf <submitr+0x42f>
    2d09:	48 8d b4 24 50 40 00 	lea    0x4050(%rsp),%rsi
    2d10:	00 
    2d11:	b9 00 04 00 00       	mov    $0x400,%ecx
    2d16:	b8 00 00 00 00       	mov    $0x0,%eax
    2d1b:	48 89 f7             	mov    %rsi,%rdi
    2d1e:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    2d21:	4c 89 ef             	mov    %r13,%rdi
    2d24:	e8 77 fd ff ff       	callq  2aa0 <urlencode>
    2d29:	85 c0                	test   %eax,%eax
    2d2b:	0f 88 21 03 00 00    	js     3052 <submitr+0x4a2>
    2d31:	4c 8d bc 24 50 20 00 	lea    0x2050(%rsp),%r15
    2d38:	00 
    2d39:	41 54                	push   %r12
    2d3b:	48 8d 84 24 58 40 00 	lea    0x4058(%rsp),%rax
    2d42:	00 
    2d43:	50                   	push   %rax
    2d44:	4d 89 f1             	mov    %r14,%r9
    2d47:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
    2d4c:	48 8d 0d 35 1a 00 00 	lea    0x1a35(%rip),%rcx        # 4788 <trans_char+0x38>
    2d53:	ba 00 20 00 00       	mov    $0x2000,%edx
    2d58:	be 01 00 00 00       	mov    $0x1,%esi
    2d5d:	4c 89 ff             	mov    %r15,%rdi
    2d60:	b8 00 00 00 00       	mov    $0x0,%eax
    2d65:	e8 d6 e6 ff ff       	callq  1440 <__sprintf_chk@plt>
    2d6a:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
    2d71:	b8 00 00 00 00       	mov    $0x0,%eax
    2d76:	4c 89 ff             	mov    %r15,%rdi
    2d79:	f2 ae                	repnz scas %es:(%rdi),%al
    2d7b:	48 f7 d1             	not    %rcx
    2d7e:	48 8d 51 ff          	lea    -0x1(%rcx),%rdx
    2d82:	4c 89 fe             	mov    %r15,%rsi
    2d85:	89 df                	mov    %ebx,%edi
    2d87:	e8 8e fb ff ff       	callq  291a <rio_writen>
    2d8c:	48 83 c4 10          	add    $0x10,%rsp
    2d90:	48 85 c0             	test   %rax,%rax
    2d93:	0f 88 44 03 00 00    	js     30dd <submitr+0x52d>
    2d99:	4c 8d 64 24 40       	lea    0x40(%rsp),%r12
    2d9e:	89 de                	mov    %ebx,%esi
    2da0:	4c 89 e7             	mov    %r12,%rdi
    2da3:	e8 2a fb ff ff       	callq  28d2 <rio_readinitb>
    2da8:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    2daf:	00 
    2db0:	ba 00 20 00 00       	mov    $0x2000,%edx
    2db5:	4c 89 e7             	mov    %r12,%rdi
    2db8:	e8 42 fc ff ff       	callq  29ff <rio_readlineb>
    2dbd:	48 85 c0             	test   %rax,%rax
    2dc0:	0f 8e 86 03 00 00    	jle    314c <submitr+0x59c>
    2dc6:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
    2dcb:	48 8d 94 24 50 60 00 	lea    0x6050(%rsp),%rdx
    2dd2:	00 
    2dd3:	48 8d bc 24 50 20 00 	lea    0x2050(%rsp),%rdi
    2dda:	00 
    2ddb:	4c 8d 84 24 50 80 00 	lea    0x8050(%rsp),%r8
    2de2:	00 
    2de3:	48 8d 35 12 1a 00 00 	lea    0x1a12(%rip),%rsi        # 47fc <trans_char+0xac>
    2dea:	b8 00 00 00 00       	mov    $0x0,%eax
    2def:	e8 9c e5 ff ff       	callq  1390 <__isoc99_sscanf@plt>
    2df4:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    2dfb:	00 
    2dfc:	b9 03 00 00 00       	mov    $0x3,%ecx
    2e01:	48 8d 3d 0b 1a 00 00 	lea    0x1a0b(%rip),%rdi        # 4813 <trans_char+0xc3>
    2e08:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
    2e0a:	0f 97 c0             	seta   %al
    2e0d:	1c 00                	sbb    $0x0,%al
    2e0f:	84 c0                	test   %al,%al
    2e11:	0f 84 b3 03 00 00    	je     31ca <submitr+0x61a>
    2e17:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    2e1e:	00 
    2e1f:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    2e24:	ba 00 20 00 00       	mov    $0x2000,%edx
    2e29:	e8 d1 fb ff ff       	callq  29ff <rio_readlineb>
    2e2e:	48 85 c0             	test   %rax,%rax
    2e31:	7f c1                	jg     2df4 <submitr+0x244>
    2e33:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    2e3a:	3a 20 43 
    2e3d:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    2e44:	20 75 6e 
    2e47:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2e4b:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2e4f:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2e56:	74 6f 20 
    2e59:	48 ba 72 65 61 64 20 	movabs $0x6165682064616572,%rdx
    2e60:	68 65 61 
    2e63:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2e67:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2e6b:	48 b8 64 65 72 73 20 	movabs $0x6f72662073726564,%rax
    2e72:	66 72 6f 
    2e75:	48 ba 6d 20 74 68 65 	movabs $0x657220656874206d,%rdx
    2e7c:	20 72 65 
    2e7f:	48 89 45 20          	mov    %rax,0x20(%rbp)
    2e83:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    2e87:	48 b8 73 75 6c 74 20 	movabs $0x72657320746c7573,%rax
    2e8e:	73 65 72 
    2e91:	48 89 45 30          	mov    %rax,0x30(%rbp)
    2e95:	c7 45 38 76 65 72 00 	movl   $0x726576,0x38(%rbp)
    2e9c:	89 df                	mov    %ebx,%edi
    2e9e:	e8 5d e4 ff ff       	callq  1300 <close@plt>
    2ea3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2ea8:	48 8b 9c 24 58 a0 00 	mov    0xa058(%rsp),%rbx
    2eaf:	00 
    2eb0:	64 48 33 1c 25 28 00 	xor    %fs:0x28,%rbx
    2eb7:	00 00 
    2eb9:	0f 85 7e 04 00 00    	jne    333d <submitr+0x78d>
    2ebf:	48 81 c4 68 a0 00 00 	add    $0xa068,%rsp
    2ec6:	5b                   	pop    %rbx
    2ec7:	5d                   	pop    %rbp
    2ec8:	41 5c                	pop    %r12
    2eca:	41 5d                	pop    %r13
    2ecc:	41 5e                	pop    %r14
    2ece:	41 5f                	pop    %r15
    2ed0:	c3                   	retq   
    2ed1:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    2ed8:	3a 20 43 
    2edb:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    2ee2:	20 75 6e 
    2ee5:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2ee9:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2eed:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2ef4:	74 6f 20 
    2ef7:	48 ba 63 72 65 61 74 	movabs $0x7320657461657263,%rdx
    2efe:	65 20 73 
    2f01:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2f05:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2f09:	c7 45 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%rbp)
    2f10:	66 c7 45 24 74 00    	movw   $0x74,0x24(%rbp)
    2f16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2f1b:	eb 8b                	jmp    2ea8 <submitr+0x2f8>
    2f1d:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
    2f24:	3a 20 44 
    2f27:	48 ba 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rdx
    2f2e:	20 75 6e 
    2f31:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2f35:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2f39:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2f40:	74 6f 20 
    2f43:	48 ba 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rdx
    2f4a:	76 65 20 
    2f4d:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2f51:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2f55:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
    2f5c:	72 20 61 
    2f5f:	48 89 45 20          	mov    %rax,0x20(%rbp)
    2f63:	c7 45 28 64 64 72 65 	movl   $0x65726464,0x28(%rbp)
    2f6a:	66 c7 45 2c 73 73    	movw   $0x7373,0x2c(%rbp)
    2f70:	c6 45 2e 00          	movb   $0x0,0x2e(%rbp)
    2f74:	89 df                	mov    %ebx,%edi
    2f76:	e8 85 e3 ff ff       	callq  1300 <close@plt>
    2f7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2f80:	e9 23 ff ff ff       	jmpq   2ea8 <submitr+0x2f8>
    2f85:	48 b8 45 72 72 6f 72 	movabs $0x55203a726f727245,%rax
    2f8c:	3a 20 55 
    2f8f:	48 ba 6e 61 62 6c 65 	movabs $0x6f7420656c62616e,%rdx
    2f96:	20 74 6f 
    2f99:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2f9d:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2fa1:	48 b8 20 63 6f 6e 6e 	movabs $0x7463656e6e6f6320,%rax
    2fa8:	65 63 74 
    2fab:	48 ba 20 74 6f 20 74 	movabs $0x20656874206f7420,%rdx
    2fb2:	68 65 20 
    2fb5:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2fb9:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2fbd:	c7 45 20 73 65 72 76 	movl   $0x76726573,0x20(%rbp)
    2fc4:	66 c7 45 24 65 72    	movw   $0x7265,0x24(%rbp)
    2fca:	c6 45 26 00          	movb   $0x0,0x26(%rbp)
    2fce:	89 df                	mov    %ebx,%edi
    2fd0:	e8 2b e3 ff ff       	callq  1300 <close@plt>
    2fd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2fda:	e9 c9 fe ff ff       	jmpq   2ea8 <submitr+0x2f8>
    2fdf:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
    2fe6:	3a 20 52 
    2fe9:	48 ba 65 73 75 6c 74 	movabs $0x747320746c757365,%rdx
    2ff0:	20 73 74 
    2ff3:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2ff7:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2ffb:	48 b8 72 69 6e 67 20 	movabs $0x6f6f7420676e6972,%rax
    3002:	74 6f 6f 
    3005:	48 ba 20 6c 61 72 67 	movabs $0x202e656772616c20,%rdx
    300c:	65 2e 20 
    300f:	48 89 45 10          	mov    %rax,0x10(%rbp)
    3013:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    3017:	48 b8 49 6e 63 72 65 	movabs $0x6573616572636e49,%rax
    301e:	61 73 65 
    3021:	48 ba 20 53 55 42 4d 	movabs $0x5254494d42555320,%rdx
    3028:	49 54 52 
    302b:	48 89 45 20          	mov    %rax,0x20(%rbp)
    302f:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    3033:	48 b8 5f 4d 41 58 42 	movabs $0x46554258414d5f,%rax
    303a:	55 46 00 
    303d:	48 89 45 30          	mov    %rax,0x30(%rbp)
    3041:	89 df                	mov    %ebx,%edi
    3043:	e8 b8 e2 ff ff       	callq  1300 <close@plt>
    3048:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    304d:	e9 56 fe ff ff       	jmpq   2ea8 <submitr+0x2f8>
    3052:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
    3059:	3a 20 52 
    305c:	48 ba 65 73 75 6c 74 	movabs $0x747320746c757365,%rdx
    3063:	20 73 74 
    3066:	48 89 45 00          	mov    %rax,0x0(%rbp)
    306a:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    306e:	48 b8 72 69 6e 67 20 	movabs $0x6e6f6320676e6972,%rax
    3075:	63 6f 6e 
    3078:	48 ba 74 61 69 6e 73 	movabs $0x6e6120736e696174,%rdx
    307f:	20 61 6e 
    3082:	48 89 45 10          	mov    %rax,0x10(%rbp)
    3086:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    308a:	48 b8 20 69 6c 6c 65 	movabs $0x6c6167656c6c6920,%rax
    3091:	67 61 6c 
    3094:	48 ba 20 6f 72 20 75 	movabs $0x72706e7520726f20,%rdx
    309b:	6e 70 72 
    309e:	48 89 45 20          	mov    %rax,0x20(%rbp)
    30a2:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    30a6:	48 b8 69 6e 74 61 62 	movabs $0x20656c6261746e69,%rax
    30ad:	6c 65 20 
    30b0:	48 ba 63 68 61 72 61 	movabs $0x6574636172616863,%rdx
    30b7:	63 74 65 
    30ba:	48 89 45 30          	mov    %rax,0x30(%rbp)
    30be:	48 89 55 38          	mov    %rdx,0x38(%rbp)
    30c2:	66 c7 45 40 72 2e    	movw   $0x2e72,0x40(%rbp)
    30c8:	c6 45 42 00          	movb   $0x0,0x42(%rbp)
    30cc:	89 df                	mov    %ebx,%edi
    30ce:	e8 2d e2 ff ff       	callq  1300 <close@plt>
    30d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    30d8:	e9 cb fd ff ff       	jmpq   2ea8 <submitr+0x2f8>
    30dd:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    30e4:	3a 20 43 
    30e7:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    30ee:	20 75 6e 
    30f1:	48 89 45 00          	mov    %rax,0x0(%rbp)
    30f5:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    30f9:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    3100:	74 6f 20 
    3103:	48 ba 77 72 69 74 65 	movabs $0x6f74206574697277,%rdx
    310a:	20 74 6f 
    310d:	48 89 45 10          	mov    %rax,0x10(%rbp)
    3111:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    3115:	48 b8 20 74 68 65 20 	movabs $0x7365722065687420,%rax
    311c:	72 65 73 
    311f:	48 ba 75 6c 74 20 73 	movabs $0x7672657320746c75,%rdx
    3126:	65 72 76 
    3129:	48 89 45 20          	mov    %rax,0x20(%rbp)
    312d:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    3131:	66 c7 45 30 65 72    	movw   $0x7265,0x30(%rbp)
    3137:	c6 45 32 00          	movb   $0x0,0x32(%rbp)
    313b:	89 df                	mov    %ebx,%edi
    313d:	e8 be e1 ff ff       	callq  1300 <close@plt>
    3142:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3147:	e9 5c fd ff ff       	jmpq   2ea8 <submitr+0x2f8>
    314c:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    3153:	3a 20 43 
    3156:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    315d:	20 75 6e 
    3160:	48 89 45 00          	mov    %rax,0x0(%rbp)
    3164:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    3168:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    316f:	74 6f 20 
    3172:	48 ba 72 65 61 64 20 	movabs $0x7269662064616572,%rdx
    3179:	66 69 72 
    317c:	48 89 45 10          	mov    %rax,0x10(%rbp)
    3180:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    3184:	48 b8 73 74 20 68 65 	movabs $0x6564616568207473,%rax
    318b:	61 64 65 
    318e:	48 ba 72 20 66 72 6f 	movabs $0x72206d6f72662072,%rdx
    3195:	6d 20 72 
    3198:	48 89 45 20          	mov    %rax,0x20(%rbp)
    319c:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    31a0:	48 b8 65 73 75 6c 74 	movabs $0x657320746c757365,%rax
    31a7:	20 73 65 
    31aa:	48 89 45 30          	mov    %rax,0x30(%rbp)
    31ae:	c7 45 38 72 76 65 72 	movl   $0x72657672,0x38(%rbp)
    31b5:	c6 45 3c 00          	movb   $0x0,0x3c(%rbp)
    31b9:	89 df                	mov    %ebx,%edi
    31bb:	e8 40 e1 ff ff       	callq  1300 <close@plt>
    31c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    31c5:	e9 de fc ff ff       	jmpq   2ea8 <submitr+0x2f8>
    31ca:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    31d1:	00 
    31d2:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    31d7:	ba 00 20 00 00       	mov    $0x2000,%edx
    31dc:	e8 1e f8 ff ff       	callq  29ff <rio_readlineb>
    31e1:	48 85 c0             	test   %rax,%rax
    31e4:	0f 8e 96 00 00 00    	jle    3280 <submitr+0x6d0>
    31ea:	44 8b 44 24 2c       	mov    0x2c(%rsp),%r8d
    31ef:	41 81 f8 c8 00 00 00 	cmp    $0xc8,%r8d
    31f6:	0f 85 08 01 00 00    	jne    3304 <submitr+0x754>
    31fc:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    3203:	00 
    3204:	48 89 ef             	mov    %rbp,%rdi
    3207:	e8 84 e0 ff ff       	callq  1290 <strcpy@plt>
    320c:	89 df                	mov    %ebx,%edi
    320e:	e8 ed e0 ff ff       	callq  1300 <close@plt>
    3213:	b9 04 00 00 00       	mov    $0x4,%ecx
    3218:	48 8d 3d ee 15 00 00 	lea    0x15ee(%rip),%rdi        # 480d <trans_char+0xbd>
    321f:	48 89 ee             	mov    %rbp,%rsi
    3222:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
    3224:	0f 97 c0             	seta   %al
    3227:	1c 00                	sbb    $0x0,%al
    3229:	0f be c0             	movsbl %al,%eax
    322c:	85 c0                	test   %eax,%eax
    322e:	0f 84 74 fc ff ff    	je     2ea8 <submitr+0x2f8>
    3234:	b9 05 00 00 00       	mov    $0x5,%ecx
    3239:	48 8d 3d d1 15 00 00 	lea    0x15d1(%rip),%rdi        # 4811 <trans_char+0xc1>
    3240:	48 89 ee             	mov    %rbp,%rsi
    3243:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
    3245:	0f 97 c0             	seta   %al
    3248:	1c 00                	sbb    $0x0,%al
    324a:	0f be c0             	movsbl %al,%eax
    324d:	85 c0                	test   %eax,%eax
    324f:	0f 84 53 fc ff ff    	je     2ea8 <submitr+0x2f8>
    3255:	b9 03 00 00 00       	mov    $0x3,%ecx
    325a:	48 8d 3d b5 15 00 00 	lea    0x15b5(%rip),%rdi        # 4816 <trans_char+0xc6>
    3261:	48 89 ee             	mov    %rbp,%rsi
    3264:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
    3266:	0f 97 c0             	seta   %al
    3269:	1c 00                	sbb    $0x0,%al
    326b:	0f be c0             	movsbl %al,%eax
    326e:	85 c0                	test   %eax,%eax
    3270:	0f 84 32 fc ff ff    	je     2ea8 <submitr+0x2f8>
    3276:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    327b:	e9 28 fc ff ff       	jmpq   2ea8 <submitr+0x2f8>
    3280:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    3287:	3a 20 43 
    328a:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    3291:	20 75 6e 
    3294:	48 89 45 00          	mov    %rax,0x0(%rbp)
    3298:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    329c:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    32a3:	74 6f 20 
    32a6:	48 ba 72 65 61 64 20 	movabs $0x6174732064616572,%rdx
    32ad:	73 74 61 
    32b0:	48 89 45 10          	mov    %rax,0x10(%rbp)
    32b4:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    32b8:	48 b8 74 75 73 20 6d 	movabs $0x7373656d20737574,%rax
    32bf:	65 73 73 
    32c2:	48 ba 61 67 65 20 66 	movabs $0x6d6f726620656761,%rdx
    32c9:	72 6f 6d 
    32cc:	48 89 45 20          	mov    %rax,0x20(%rbp)
    32d0:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    32d4:	48 b8 20 72 65 73 75 	movabs $0x20746c7573657220,%rax
    32db:	6c 74 20 
    32de:	48 89 45 30          	mov    %rax,0x30(%rbp)
    32e2:	c7 45 38 73 65 72 76 	movl   $0x76726573,0x38(%rbp)
    32e9:	66 c7 45 3c 65 72    	movw   $0x7265,0x3c(%rbp)
    32ef:	c6 45 3e 00          	movb   $0x0,0x3e(%rbp)
    32f3:	89 df                	mov    %ebx,%edi
    32f5:	e8 06 e0 ff ff       	callq  1300 <close@plt>
    32fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    32ff:	e9 a4 fb ff ff       	jmpq   2ea8 <submitr+0x2f8>
    3304:	4c 8d 8c 24 50 80 00 	lea    0x8050(%rsp),%r9
    330b:	00 
    330c:	48 8d 0d b5 14 00 00 	lea    0x14b5(%rip),%rcx        # 47c8 <trans_char+0x78>
    3313:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
    331a:	be 01 00 00 00       	mov    $0x1,%esi
    331f:	48 89 ef             	mov    %rbp,%rdi
    3322:	b8 00 00 00 00       	mov    $0x0,%eax
    3327:	e8 14 e1 ff ff       	callq  1440 <__sprintf_chk@plt>
    332c:	89 df                	mov    %ebx,%edi
    332e:	e8 cd df ff ff       	callq  1300 <close@plt>
    3333:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3338:	e9 6b fb ff ff       	jmpq   2ea8 <submitr+0x2f8>
    333d:	e8 7e df ff ff       	callq  12c0 <__stack_chk_fail@plt>

0000000000003342 <init_timeout>:
    3342:	f3 0f 1e fa          	endbr64 
    3346:	85 ff                	test   %edi,%edi
    3348:	74 26                	je     3370 <init_timeout+0x2e>
    334a:	53                   	push   %rbx
    334b:	89 fb                	mov    %edi,%ebx
    334d:	78 1a                	js     3369 <init_timeout+0x27>
    334f:	48 8d 35 8e f5 ff ff 	lea    -0xa72(%rip),%rsi        # 28e4 <sigalrm_handler>
    3356:	bf 0e 00 00 00       	mov    $0xe,%edi
    335b:	e8 c0 df ff ff       	callq  1320 <signal@plt>
    3360:	89 df                	mov    %ebx,%edi
    3362:	e8 89 df ff ff       	callq  12f0 <alarm@plt>
    3367:	5b                   	pop    %rbx
    3368:	c3                   	retq   
    3369:	bb 00 00 00 00       	mov    $0x0,%ebx
    336e:	eb df                	jmp    334f <init_timeout+0xd>
    3370:	c3                   	retq   

0000000000003371 <init_driver>:
    3371:	f3 0f 1e fa          	endbr64 
    3375:	41 54                	push   %r12
    3377:	55                   	push   %rbp
    3378:	53                   	push   %rbx
    3379:	48 83 ec 20          	sub    $0x20,%rsp
    337d:	48 89 fd             	mov    %rdi,%rbp
    3380:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    3387:	00 00 
    3389:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    338e:	31 c0                	xor    %eax,%eax
    3390:	be 01 00 00 00       	mov    $0x1,%esi
    3395:	bf 0d 00 00 00       	mov    $0xd,%edi
    339a:	e8 81 df ff ff       	callq  1320 <signal@plt>
    339f:	be 01 00 00 00       	mov    $0x1,%esi
    33a4:	bf 1d 00 00 00       	mov    $0x1d,%edi
    33a9:	e8 72 df ff ff       	callq  1320 <signal@plt>
    33ae:	be 01 00 00 00       	mov    $0x1,%esi
    33b3:	bf 1d 00 00 00       	mov    $0x1d,%edi
    33b8:	e8 63 df ff ff       	callq  1320 <signal@plt>
    33bd:	ba 00 00 00 00       	mov    $0x0,%edx
    33c2:	be 01 00 00 00       	mov    $0x1,%esi
    33c7:	bf 02 00 00 00       	mov    $0x2,%edi
    33cc:	e8 7f e0 ff ff       	callq  1450 <socket@plt>
    33d1:	85 c0                	test   %eax,%eax
    33d3:	0f 88 9c 00 00 00    	js     3475 <init_driver+0x104>
    33d9:	89 c3                	mov    %eax,%ebx
    33db:	48 8d 3d 13 0f 00 00 	lea    0xf13(%rip),%rdi        # 42f5 <_IO_stdin_used+0x2f5>
    33e2:	e8 49 df ff ff       	callq  1330 <gethostbyname@plt>
    33e7:	48 85 c0             	test   %rax,%rax
    33ea:	0f 84 d1 00 00 00    	je     34c1 <init_driver+0x150>
    33f0:	49 89 e4             	mov    %rsp,%r12
    33f3:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    33fa:	00 
    33fb:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    3402:	00 00 
    3404:	66 c7 04 24 02 00    	movw   $0x2,(%rsp)
    340a:	48 63 50 14          	movslq 0x14(%rax),%rdx
    340e:	48 8b 40 18          	mov    0x18(%rax),%rax
    3412:	48 8b 30             	mov    (%rax),%rsi
    3415:	48 8d 7c 24 04       	lea    0x4(%rsp),%rdi
    341a:	b9 0c 00 00 00       	mov    $0xc,%ecx
    341f:	e8 1c df ff ff       	callq  1340 <__memmove_chk@plt>
    3424:	66 c7 44 24 02 3c 9a 	movw   $0x9a3c,0x2(%rsp)
    342b:	ba 10 00 00 00       	mov    $0x10,%edx
    3430:	4c 89 e6             	mov    %r12,%rsi
    3433:	89 df                	mov    %ebx,%edi
    3435:	e8 d6 df ff ff       	callq  1410 <connect@plt>
    343a:	85 c0                	test   %eax,%eax
    343c:	0f 88 e7 00 00 00    	js     3529 <init_driver+0x1b8>
    3442:	89 df                	mov    %ebx,%edi
    3444:	e8 b7 de ff ff       	callq  1300 <close@plt>
    3449:	66 c7 45 00 4f 4b    	movw   $0x4b4f,0x0(%rbp)
    344f:	c6 45 02 00          	movb   $0x0,0x2(%rbp)
    3453:	b8 00 00 00 00       	mov    $0x0,%eax
    3458:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    345d:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
    3464:	00 00 
    3466:	0f 85 10 01 00 00    	jne    357c <init_driver+0x20b>
    346c:	48 83 c4 20          	add    $0x20,%rsp
    3470:	5b                   	pop    %rbx
    3471:	5d                   	pop    %rbp
    3472:	41 5c                	pop    %r12
    3474:	c3                   	retq   
    3475:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    347c:	3a 20 43 
    347f:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    3486:	20 75 6e 
    3489:	48 89 45 00          	mov    %rax,0x0(%rbp)
    348d:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    3491:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    3498:	74 6f 20 
    349b:	48 ba 63 72 65 61 74 	movabs $0x7320657461657263,%rdx
    34a2:	65 20 73 
    34a5:	48 89 45 10          	mov    %rax,0x10(%rbp)
    34a9:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    34ad:	c7 45 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%rbp)
    34b4:	66 c7 45 24 74 00    	movw   $0x74,0x24(%rbp)
    34ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    34bf:	eb 97                	jmp    3458 <init_driver+0xe7>
    34c1:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
    34c8:	3a 20 44 
    34cb:	48 ba 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rdx
    34d2:	20 75 6e 
    34d5:	48 89 45 00          	mov    %rax,0x0(%rbp)
    34d9:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    34dd:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    34e4:	74 6f 20 
    34e7:	48 ba 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rdx
    34ee:	76 65 20 
    34f1:	48 89 45 10          	mov    %rax,0x10(%rbp)
    34f5:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    34f9:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
    3500:	72 20 61 
    3503:	48 89 45 20          	mov    %rax,0x20(%rbp)
    3507:	c7 45 28 64 64 72 65 	movl   $0x65726464,0x28(%rbp)
    350e:	66 c7 45 2c 73 73    	movw   $0x7373,0x2c(%rbp)
    3514:	c6 45 2e 00          	movb   $0x0,0x2e(%rbp)
    3518:	89 df                	mov    %ebx,%edi
    351a:	e8 e1 dd ff ff       	callq  1300 <close@plt>
    351f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3524:	e9 2f ff ff ff       	jmpq   3458 <init_driver+0xe7>
    3529:	48 b8 45 72 72 6f 72 	movabs $0x55203a726f727245,%rax
    3530:	3a 20 55 
    3533:	48 ba 6e 61 62 6c 65 	movabs $0x6f7420656c62616e,%rdx
    353a:	20 74 6f 
    353d:	48 89 45 00          	mov    %rax,0x0(%rbp)
    3541:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    3545:	48 b8 20 63 6f 6e 6e 	movabs $0x7463656e6e6f6320,%rax
    354c:	65 63 74 
    354f:	48 ba 20 74 6f 20 73 	movabs $0x76726573206f7420,%rdx
    3556:	65 72 76 
    3559:	48 89 45 10          	mov    %rax,0x10(%rbp)
    355d:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    3561:	66 c7 45 20 65 72    	movw   $0x7265,0x20(%rbp)
    3567:	c6 45 22 00          	movb   $0x0,0x22(%rbp)
    356b:	89 df                	mov    %ebx,%edi
    356d:	e8 8e dd ff ff       	callq  1300 <close@plt>
    3572:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3577:	e9 dc fe ff ff       	jmpq   3458 <init_driver+0xe7>
    357c:	e8 3f dd ff ff       	callq  12c0 <__stack_chk_fail@plt>

0000000000003581 <driver_post>:
    3581:	f3 0f 1e fa          	endbr64 
    3585:	53                   	push   %rbx
    3586:	4c 89 cb             	mov    %r9,%rbx
    3589:	45 85 c0             	test   %r8d,%r8d
    358c:	75 18                	jne    35a6 <driver_post+0x25>
    358e:	48 85 ff             	test   %rdi,%rdi
    3591:	74 05                	je     3598 <driver_post+0x17>
    3593:	80 3f 00             	cmpb   $0x0,(%rdi)
    3596:	75 37                	jne    35cf <driver_post+0x4e>
    3598:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
    359d:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
    35a1:	44 89 c0             	mov    %r8d,%eax
    35a4:	5b                   	pop    %rbx
    35a5:	c3                   	retq   
    35a6:	48 89 ca             	mov    %rcx,%rdx
    35a9:	48 8d 35 69 12 00 00 	lea    0x1269(%rip),%rsi        # 4819 <trans_char+0xc9>
    35b0:	bf 01 00 00 00       	mov    $0x1,%edi
    35b5:	b8 00 00 00 00       	mov    $0x0,%eax
    35ba:	e8 f1 dd ff ff       	callq  13b0 <__printf_chk@plt>
    35bf:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
    35c4:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
    35c8:	b8 00 00 00 00       	mov    $0x0,%eax
    35cd:	eb d5                	jmp    35a4 <driver_post+0x23>
    35cf:	48 83 ec 08          	sub    $0x8,%rsp
    35d3:	41 51                	push   %r9
    35d5:	49 89 c9             	mov    %rcx,%r9
    35d8:	49 89 d0             	mov    %rdx,%r8
    35db:	48 89 f9             	mov    %rdi,%rcx
    35de:	48 89 f2             	mov    %rsi,%rdx
    35e1:	be 9a 3c 00 00       	mov    $0x3c9a,%esi
    35e6:	48 8d 3d 08 0d 00 00 	lea    0xd08(%rip),%rdi        # 42f5 <_IO_stdin_used+0x2f5>
    35ed:	e8 be f5 ff ff       	callq  2bb0 <submitr>
    35f2:	48 83 c4 10          	add    $0x10,%rsp
    35f6:	eb ac                	jmp    35a4 <driver_post+0x23>

00000000000035f8 <check>:
    35f8:	f3 0f 1e fa          	endbr64 
    35fc:	89 f8                	mov    %edi,%eax
    35fe:	c1 e8 1c             	shr    $0x1c,%eax
    3601:	74 1d                	je     3620 <check+0x28>
    3603:	b9 00 00 00 00       	mov    $0x0,%ecx
    3608:	83 f9 1f             	cmp    $0x1f,%ecx
    360b:	7f 0d                	jg     361a <check+0x22>
    360d:	89 f8                	mov    %edi,%eax
    360f:	d3 e8                	shr    %cl,%eax
    3611:	3c 0a                	cmp    $0xa,%al
    3613:	74 11                	je     3626 <check+0x2e>
    3615:	83 c1 08             	add    $0x8,%ecx
    3618:	eb ee                	jmp    3608 <check+0x10>
    361a:	b8 01 00 00 00       	mov    $0x1,%eax
    361f:	c3                   	retq   
    3620:	b8 00 00 00 00       	mov    $0x0,%eax
    3625:	c3                   	retq   
    3626:	b8 00 00 00 00       	mov    $0x0,%eax
    362b:	c3                   	retq   

000000000000362c <gencookie>:
    362c:	f3 0f 1e fa          	endbr64 
    3630:	53                   	push   %rbx
    3631:	83 c7 01             	add    $0x1,%edi
    3634:	e8 37 dc ff ff       	callq  1270 <srandom@plt>
    3639:	e8 42 dd ff ff       	callq  1380 <random@plt>
    363e:	48 89 c7             	mov    %rax,%rdi
    3641:	89 c3                	mov    %eax,%ebx
    3643:	e8 b0 ff ff ff       	callq  35f8 <check>
    3648:	85 c0                	test   %eax,%eax
    364a:	74 ed                	je     3639 <gencookie+0xd>
    364c:	89 d8                	mov    %ebx,%eax
    364e:	5b                   	pop    %rbx
    364f:	c3                   	retq   

0000000000003650 <__libc_csu_init>:
    3650:	f3 0f 1e fa          	endbr64 
    3654:	41 57                	push   %r15
    3656:	4c 8d 3d 5b 36 00 00 	lea    0x365b(%rip),%r15        # 6cb8 <__frame_dummy_init_array_entry>
    365d:	41 56                	push   %r14
    365f:	49 89 d6             	mov    %rdx,%r14
    3662:	41 55                	push   %r13
    3664:	49 89 f5             	mov    %rsi,%r13
    3667:	41 54                	push   %r12
    3669:	41 89 fc             	mov    %edi,%r12d
    366c:	55                   	push   %rbp
    366d:	48 8d 2d 4c 36 00 00 	lea    0x364c(%rip),%rbp        # 6cc0 <__do_global_dtors_aux_fini_array_entry>
    3674:	53                   	push   %rbx
    3675:	4c 29 fd             	sub    %r15,%rbp
    3678:	48 83 ec 08          	sub    $0x8,%rsp
    367c:	e8 7f d9 ff ff       	callq  1000 <_init>
    3681:	48 c1 fd 03          	sar    $0x3,%rbp
    3685:	74 1f                	je     36a6 <__libc_csu_init+0x56>
    3687:	31 db                	xor    %ebx,%ebx
    3689:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    3690:	4c 89 f2             	mov    %r14,%rdx
    3693:	4c 89 ee             	mov    %r13,%rsi
    3696:	44 89 e7             	mov    %r12d,%edi
    3699:	41 ff 14 df          	callq  *(%r15,%rbx,8)
    369d:	48 83 c3 01          	add    $0x1,%rbx
    36a1:	48 39 dd             	cmp    %rbx,%rbp
    36a4:	75 ea                	jne    3690 <__libc_csu_init+0x40>
    36a6:	48 83 c4 08          	add    $0x8,%rsp
    36aa:	5b                   	pop    %rbx
    36ab:	5d                   	pop    %rbp
    36ac:	41 5c                	pop    %r12
    36ae:	41 5d                	pop    %r13
    36b0:	41 5e                	pop    %r14
    36b2:	41 5f                	pop    %r15
    36b4:	c3                   	retq   
    36b5:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
    36bc:	00 00 00 00 

00000000000036c0 <__libc_csu_fini>:
    36c0:	f3 0f 1e fa          	endbr64 
    36c4:	c3                   	retq   

Disassembly of section .fini:

00000000000036c8 <_fini>:
    36c8:	f3 0f 1e fa          	endbr64 
    36cc:	48 83 ec 08          	sub    $0x8,%rsp
    36d0:	48 83 c4 08          	add    $0x8,%rsp
    36d4:	c3                   	retq   
