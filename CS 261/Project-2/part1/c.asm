
ctarget:     file format elf64-x86-64


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
    1473:	4c 8d 05 76 20 00 00 	lea    0x2076(%rip),%r8        # 34f0 <__libc_csu_fini>
    147a:	48 8d 0d ff 1f 00 00 	lea    0x1fff(%rip),%rcx        # 3480 <__libc_csu_init>
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
    1629:	e8 2a 1e 00 00       	callq  3458 <gencookie>
    162e:	89 c7                	mov    %eax,%edi
    1630:	89 05 ae 5d 00 00    	mov    %eax,0x5dae(%rip)        # 73e4 <cookie>
    1636:	e8 1d 1e 00 00       	callq  3458 <gencookie>
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
    167c:	c6 05 85 69 00 00 63 	movb   $0x63,0x6985(%rip)        # 8008 <target_prefix>
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
    172f:	e8 69 1a 00 00       	callq  319d <init_driver>
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
    179d:	48 8d 35 9c 0c 00 00 	lea    0xc9c(%rip),%rsi        # 2440 <seghandler>
    17a4:	bf 0b 00 00 00       	mov    $0xb,%edi
    17a9:	e8 72 fb ff ff       	callq  1320 <signal@plt>
    17ae:	48 8d 35 31 0c 00 00 	lea    0xc31(%rip),%rsi        # 23e6 <bushandler>
    17b5:	bf 07 00 00 00       	mov    $0x7,%edi
    17ba:	e8 61 fb ff ff       	callq  1320 <signal@plt>
    17bf:	48 8d 35 d4 0c 00 00 	lea    0xcd4(%rip),%rsi        # 249a <illegalhandler>
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
    17ff:	48 8d 35 ee 0c 00 00 	lea    0xcee(%rip),%rsi        # 24f4 <sigalrmhandler>
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
    1902:	be 00 00 00 00       	mov    $0x0,%esi
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
    1944:	e8 fd 0c 00 00       	callq  2646 <stable_launch>
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
    1975:	e8 bb 06 00 00       	callq  2035 <check_fail>
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
    1db9:	e8 b5 02 00 00       	callq  2073 <Gets>
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
    1ded:	e8 f4 04 00 00       	callq  22e6 <validate>
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
    1e35:	e8 80 05 00 00       	callq  23ba <fail>
    1e3a:	bf 00 00 00 00       	mov    $0x0,%edi
    1e3f:	e8 bc f5 ff ff       	callq  1400 <exit@plt>
    1e44:	48 8d 35 3d 25 00 00 	lea    0x253d(%rip),%rsi        # 4388 <_IO_stdin_used+0x388>
    1e4b:	bf 01 00 00 00       	mov    $0x1,%edi
    1e50:	b8 00 00 00 00       	mov    $0x0,%eax
    1e55:	e8 56 f5 ff ff       	callq  13b0 <__printf_chk@plt>
    1e5a:	bf 02 00 00 00       	mov    $0x2,%edi
    1e5f:	e8 82 04 00 00       	callq  22e6 <validate>
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
    1f63:	e8 7e 03 00 00       	callq  22e6 <validate>
    1f68:	bf 00 00 00 00       	mov    $0x0,%edi
    1f6d:	e8 8e f4 ff ff       	callq  1400 <exit@plt>
    1f72:	48 89 da             	mov    %rbx,%rdx
    1f75:	48 8d 35 84 24 00 00 	lea    0x2484(%rip),%rsi        # 4400 <_IO_stdin_used+0x400>
    1f7c:	bf 01 00 00 00       	mov    $0x1,%edi
    1f81:	b8 00 00 00 00       	mov    $0x0,%eax
    1f86:	e8 25 f4 ff ff       	callq  13b0 <__printf_chk@plt>
    1f8b:	bf 03 00 00 00       	mov    $0x3,%edi
    1f90:	e8 25 04 00 00       	callq  23ba <fail>
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

0000000000001fc6 <save_char>:
    1fc6:	8b 05 38 60 00 00    	mov    0x6038(%rip),%eax        # 8004 <gets_cnt>
    1fcc:	3d ff 03 00 00       	cmp    $0x3ff,%eax
    1fd1:	7f 4a                	jg     201d <save_char+0x57>
    1fd3:	89 f9                	mov    %edi,%ecx
    1fd5:	c0 e9 04             	shr    $0x4,%cl
    1fd8:	8d 14 40             	lea    (%rax,%rax,2),%edx
    1fdb:	4c 8d 05 6e 27 00 00 	lea    0x276e(%rip),%r8        # 4750 <trans_char>
    1fe2:	83 e1 0f             	and    $0xf,%ecx
    1fe5:	45 0f b6 0c 08       	movzbl (%r8,%rcx,1),%r9d
    1fea:	48 8d 0d 0f 54 00 00 	lea    0x540f(%rip),%rcx        # 7400 <gets_buf>
    1ff1:	48 63 f2             	movslq %edx,%rsi
    1ff4:	44 88 0c 31          	mov    %r9b,(%rcx,%rsi,1)
    1ff8:	8d 72 01             	lea    0x1(%rdx),%esi
    1ffb:	83 e7 0f             	and    $0xf,%edi
    1ffe:	41 0f b6 3c 38       	movzbl (%r8,%rdi,1),%edi
    2003:	48 63 f6             	movslq %esi,%rsi
    2006:	40 88 3c 31          	mov    %dil,(%rcx,%rsi,1)
    200a:	83 c2 02             	add    $0x2,%edx
    200d:	48 63 d2             	movslq %edx,%rdx
    2010:	c6 04 11 20          	movb   $0x20,(%rcx,%rdx,1)
    2014:	83 c0 01             	add    $0x1,%eax
    2017:	89 05 e7 5f 00 00    	mov    %eax,0x5fe7(%rip)        # 8004 <gets_cnt>
    201d:	c3                   	retq   

000000000000201e <save_term>:
    201e:	8b 05 e0 5f 00 00    	mov    0x5fe0(%rip),%eax        # 8004 <gets_cnt>
    2024:	8d 04 40             	lea    (%rax,%rax,2),%eax
    2027:	48 98                	cltq   
    2029:	48 8d 15 d0 53 00 00 	lea    0x53d0(%rip),%rdx        # 7400 <gets_buf>
    2030:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
    2034:	c3                   	retq   

0000000000002035 <check_fail>:
    2035:	f3 0f 1e fa          	endbr64 
    2039:	50                   	push   %rax
    203a:	58                   	pop    %rax
    203b:	48 83 ec 08          	sub    $0x8,%rsp
    203f:	0f be 15 c2 5f 00 00 	movsbl 0x5fc2(%rip),%edx        # 8008 <target_prefix>
    2046:	4c 8d 05 b3 53 00 00 	lea    0x53b3(%rip),%r8        # 7400 <gets_buf>
    204d:	8b 0d 85 53 00 00    	mov    0x5385(%rip),%ecx        # 73d8 <check_level>
    2053:	48 8d 35 f1 23 00 00 	lea    0x23f1(%rip),%rsi        # 444b <_IO_stdin_used+0x44b>
    205a:	bf 01 00 00 00       	mov    $0x1,%edi
    205f:	b8 00 00 00 00       	mov    $0x0,%eax
    2064:	e8 47 f3 ff ff       	callq  13b0 <__printf_chk@plt>
    2069:	bf 01 00 00 00       	mov    $0x1,%edi
    206e:	e8 8d f3 ff ff       	callq  1400 <exit@plt>

0000000000002073 <Gets>:
    2073:	f3 0f 1e fa          	endbr64 
    2077:	41 54                	push   %r12
    2079:	55                   	push   %rbp
    207a:	53                   	push   %rbx
    207b:	49 89 fc             	mov    %rdi,%r12
    207e:	c7 05 7c 5f 00 00 00 	movl   $0x0,0x5f7c(%rip)        # 8004 <gets_cnt>
    2085:	00 00 00 
    2088:	48 89 fb             	mov    %rdi,%rbx
    208b:	48 8b 3d 3e 53 00 00 	mov    0x533e(%rip),%rdi        # 73d0 <infile>
    2092:	e8 99 f3 ff ff       	callq  1430 <getc@plt>
    2097:	83 f8 ff             	cmp    $0xffffffff,%eax
    209a:	74 18                	je     20b4 <Gets+0x41>
    209c:	83 f8 0a             	cmp    $0xa,%eax
    209f:	74 13                	je     20b4 <Gets+0x41>
    20a1:	48 8d 6b 01          	lea    0x1(%rbx),%rbp
    20a5:	88 03                	mov    %al,(%rbx)
    20a7:	0f b6 f8             	movzbl %al,%edi
    20aa:	e8 17 ff ff ff       	callq  1fc6 <save_char>
    20af:	48 89 eb             	mov    %rbp,%rbx
    20b2:	eb d7                	jmp    208b <Gets+0x18>
    20b4:	c6 03 00             	movb   $0x0,(%rbx)
    20b7:	b8 00 00 00 00       	mov    $0x0,%eax
    20bc:	e8 5d ff ff ff       	callq  201e <save_term>
    20c1:	4c 89 e0             	mov    %r12,%rax
    20c4:	5b                   	pop    %rbx
    20c5:	5d                   	pop    %rbp
    20c6:	41 5c                	pop    %r12
    20c8:	c3                   	retq   

00000000000020c9 <notify_server>:
    20c9:	f3 0f 1e fa          	endbr64 
    20cd:	55                   	push   %rbp
    20ce:	53                   	push   %rbx
    20cf:	4c 8d 9c 24 00 c0 ff 	lea    -0x4000(%rsp),%r11
    20d6:	ff 
    20d7:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    20de:	48 83 0c 24 00       	orq    $0x0,(%rsp)
    20e3:	4c 39 dc             	cmp    %r11,%rsp
    20e6:	75 ef                	jne    20d7 <notify_server+0xe>
    20e8:	48 83 ec 18          	sub    $0x18,%rsp
    20ec:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    20f3:	00 00 
    20f5:	48 89 84 24 08 40 00 	mov    %rax,0x4008(%rsp)
    20fc:	00 
    20fd:	31 c0                	xor    %eax,%eax
    20ff:	83 3d e2 52 00 00 00 	cmpl   $0x0,0x52e2(%rip)        # 73e8 <is_checker>
    2106:	0f 85 26 01 00 00    	jne    2232 <notify_server+0x169>
    210c:	89 fb                	mov    %edi,%ebx
    210e:	81 3d ec 5e 00 00 9c 	cmpl   $0x1f9c,0x5eec(%rip)        # 8004 <gets_cnt>
    2115:	1f 00 00 
    2118:	7f 18                	jg     2132 <notify_server+0x69>
    211a:	0f be 05 e7 5e 00 00 	movsbl 0x5ee7(%rip),%eax        # 8008 <target_prefix>
    2121:	83 3d 40 52 00 00 00 	cmpl   $0x0,0x5240(%rip)        # 7368 <notify>
    2128:	74 23                	je     214d <notify_server+0x84>
    212a:	8b 15 b0 52 00 00    	mov    0x52b0(%rip),%edx        # 73e0 <authkey>
    2130:	eb 20                	jmp    2152 <notify_server+0x89>
    2132:	48 8d 35 47 24 00 00 	lea    0x2447(%rip),%rsi        # 4580 <_IO_stdin_used+0x580>
    2139:	bf 01 00 00 00       	mov    $0x1,%edi
    213e:	e8 6d f2 ff ff       	callq  13b0 <__printf_chk@plt>
    2143:	bf 01 00 00 00       	mov    $0x1,%edi
    2148:	e8 b3 f2 ff ff       	callq  1400 <exit@plt>
    214d:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    2152:	85 db                	test   %ebx,%ebx
    2154:	0f 84 98 00 00 00    	je     21f2 <notify_server+0x129>
    215a:	48 8d 2d 05 23 00 00 	lea    0x2305(%rip),%rbp        # 4466 <_IO_stdin_used+0x466>
    2161:	48 89 e7             	mov    %rsp,%rdi
    2164:	48 8d 0d 95 52 00 00 	lea    0x5295(%rip),%rcx        # 7400 <gets_buf>
    216b:	51                   	push   %rcx
    216c:	56                   	push   %rsi
    216d:	50                   	push   %rax
    216e:	52                   	push   %rdx
    216f:	49 89 e9             	mov    %rbp,%r9
    2172:	44 8b 05 97 4e 00 00 	mov    0x4e97(%rip),%r8d        # 7010 <target_id>
    2179:	48 8d 0d eb 22 00 00 	lea    0x22eb(%rip),%rcx        # 446b <_IO_stdin_used+0x46b>
    2180:	ba 00 20 00 00       	mov    $0x2000,%edx
    2185:	be 01 00 00 00       	mov    $0x1,%esi
    218a:	b8 00 00 00 00       	mov    $0x0,%eax
    218f:	e8 ac f2 ff ff       	callq  1440 <__sprintf_chk@plt>
    2194:	48 83 c4 20          	add    $0x20,%rsp
    2198:	83 3d c9 51 00 00 00 	cmpl   $0x0,0x51c9(%rip)        # 7368 <notify>
    219f:	0f 84 ae 00 00 00    	je     2253 <notify_server+0x18a>
    21a5:	85 db                	test   %ebx,%ebx
    21a7:	74 7d                	je     2226 <notify_server+0x15d>
    21a9:	48 89 e1             	mov    %rsp,%rcx
    21ac:	4c 8d 8c 24 00 20 00 	lea    0x2000(%rsp),%r9
    21b3:	00 
    21b4:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    21ba:	48 8b 15 67 4e 00 00 	mov    0x4e67(%rip),%rdx        # 7028 <lab>
    21c1:	48 8b 35 68 4e 00 00 	mov    0x4e68(%rip),%rsi        # 7030 <course>
    21c8:	48 8b 3d 51 4e 00 00 	mov    0x4e51(%rip),%rdi        # 7020 <user_id>
    21cf:	e8 d9 11 00 00       	callq  33ad <driver_post>
    21d4:	85 c0                	test   %eax,%eax
    21d6:	78 26                	js     21fe <notify_server+0x135>
    21d8:	48 8d 3d d1 23 00 00 	lea    0x23d1(%rip),%rdi        # 45b0 <_IO_stdin_used+0x5b0>
    21df:	e8 bc f0 ff ff       	callq  12a0 <puts@plt>
    21e4:	48 8d 3d a8 22 00 00 	lea    0x22a8(%rip),%rdi        # 4493 <_IO_stdin_used+0x493>
    21eb:	e8 b0 f0 ff ff       	callq  12a0 <puts@plt>
    21f0:	eb 40                	jmp    2232 <notify_server+0x169>
    21f2:	48 8d 2d 68 22 00 00 	lea    0x2268(%rip),%rbp        # 4461 <_IO_stdin_used+0x461>
    21f9:	e9 63 ff ff ff       	jmpq   2161 <notify_server+0x98>
    21fe:	48 8d 94 24 00 20 00 	lea    0x2000(%rsp),%rdx
    2205:	00 
    2206:	48 8d 35 7a 22 00 00 	lea    0x227a(%rip),%rsi        # 4487 <_IO_stdin_used+0x487>
    220d:	bf 01 00 00 00       	mov    $0x1,%edi
    2212:	b8 00 00 00 00       	mov    $0x0,%eax
    2217:	e8 94 f1 ff ff       	callq  13b0 <__printf_chk@plt>
    221c:	bf 01 00 00 00       	mov    $0x1,%edi
    2221:	e8 da f1 ff ff       	callq  1400 <exit@plt>
    2226:	48 8d 3d 70 22 00 00 	lea    0x2270(%rip),%rdi        # 449d <_IO_stdin_used+0x49d>
    222d:	e8 6e f0 ff ff       	callq  12a0 <puts@plt>
    2232:	48 8b 84 24 08 40 00 	mov    0x4008(%rsp),%rax
    2239:	00 
    223a:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    2241:	00 00 
    2243:	0f 85 98 00 00 00    	jne    22e1 <notify_server+0x218>
    2249:	48 81 c4 18 40 00 00 	add    $0x4018,%rsp
    2250:	5b                   	pop    %rbx
    2251:	5d                   	pop    %rbp
    2252:	c3                   	retq   
    2253:	48 89 ea             	mov    %rbp,%rdx
    2256:	48 8d 35 8b 23 00 00 	lea    0x238b(%rip),%rsi        # 45e8 <_IO_stdin_used+0x5e8>
    225d:	bf 01 00 00 00       	mov    $0x1,%edi
    2262:	b8 00 00 00 00       	mov    $0x0,%eax
    2267:	e8 44 f1 ff ff       	callq  13b0 <__printf_chk@plt>
    226c:	48 8b 15 ad 4d 00 00 	mov    0x4dad(%rip),%rdx        # 7020 <user_id>
    2273:	48 8d 35 2a 22 00 00 	lea    0x222a(%rip),%rsi        # 44a4 <_IO_stdin_used+0x4a4>
    227a:	bf 01 00 00 00       	mov    $0x1,%edi
    227f:	b8 00 00 00 00       	mov    $0x0,%eax
    2284:	e8 27 f1 ff ff       	callq  13b0 <__printf_chk@plt>
    2289:	48 8b 15 a0 4d 00 00 	mov    0x4da0(%rip),%rdx        # 7030 <course>
    2290:	48 8d 35 1a 22 00 00 	lea    0x221a(%rip),%rsi        # 44b1 <_IO_stdin_used+0x4b1>
    2297:	bf 01 00 00 00       	mov    $0x1,%edi
    229c:	b8 00 00 00 00       	mov    $0x0,%eax
    22a1:	e8 0a f1 ff ff       	callq  13b0 <__printf_chk@plt>
    22a6:	48 8b 15 7b 4d 00 00 	mov    0x4d7b(%rip),%rdx        # 7028 <lab>
    22ad:	48 8d 35 09 22 00 00 	lea    0x2209(%rip),%rsi        # 44bd <_IO_stdin_used+0x4bd>
    22b4:	bf 01 00 00 00       	mov    $0x1,%edi
    22b9:	b8 00 00 00 00       	mov    $0x0,%eax
    22be:	e8 ed f0 ff ff       	callq  13b0 <__printf_chk@plt>
    22c3:	48 89 e2             	mov    %rsp,%rdx
    22c6:	48 8d 35 f9 21 00 00 	lea    0x21f9(%rip),%rsi        # 44c6 <_IO_stdin_used+0x4c6>
    22cd:	bf 01 00 00 00       	mov    $0x1,%edi
    22d2:	b8 00 00 00 00       	mov    $0x0,%eax
    22d7:	e8 d4 f0 ff ff       	callq  13b0 <__printf_chk@plt>
    22dc:	e9 51 ff ff ff       	jmpq   2232 <notify_server+0x169>
    22e1:	e8 da ef ff ff       	callq  12c0 <__stack_chk_fail@plt>

00000000000022e6 <validate>:
    22e6:	f3 0f 1e fa          	endbr64 
    22ea:	53                   	push   %rbx
    22eb:	89 fb                	mov    %edi,%ebx
    22ed:	83 3d f4 50 00 00 00 	cmpl   $0x0,0x50f4(%rip)        # 73e8 <is_checker>
    22f4:	74 72                	je     2368 <validate+0x82>
    22f6:	39 3d e0 50 00 00    	cmp    %edi,0x50e0(%rip)        # 73dc <vlevel>
    22fc:	75 32                	jne    2330 <validate+0x4a>
    22fe:	8b 15 d4 50 00 00    	mov    0x50d4(%rip),%edx        # 73d8 <check_level>
    2304:	39 fa                	cmp    %edi,%edx
    2306:	75 3e                	jne    2346 <validate+0x60>
    2308:	0f be 15 f9 5c 00 00 	movsbl 0x5cf9(%rip),%edx        # 8008 <target_prefix>
    230f:	4c 8d 05 ea 50 00 00 	lea    0x50ea(%rip),%r8        # 7400 <gets_buf>
    2316:	89 f9                	mov    %edi,%ecx
    2318:	48 8d 35 d1 21 00 00 	lea    0x21d1(%rip),%rsi        # 44f0 <_IO_stdin_used+0x4f0>
    231f:	bf 01 00 00 00       	mov    $0x1,%edi
    2324:	b8 00 00 00 00       	mov    $0x0,%eax
    2329:	e8 82 f0 ff ff       	callq  13b0 <__printf_chk@plt>
    232e:	5b                   	pop    %rbx
    232f:	c3                   	retq   
    2330:	48 8d 3d 9b 21 00 00 	lea    0x219b(%rip),%rdi        # 44d2 <_IO_stdin_used+0x4d2>
    2337:	e8 64 ef ff ff       	callq  12a0 <puts@plt>
    233c:	b8 00 00 00 00       	mov    $0x0,%eax
    2341:	e8 ef fc ff ff       	callq  2035 <check_fail>
    2346:	89 f9                	mov    %edi,%ecx
    2348:	48 8d 35 c1 22 00 00 	lea    0x22c1(%rip),%rsi        # 4610 <_IO_stdin_used+0x610>
    234f:	bf 01 00 00 00       	mov    $0x1,%edi
    2354:	b8 00 00 00 00       	mov    $0x0,%eax
    2359:	e8 52 f0 ff ff       	callq  13b0 <__printf_chk@plt>
    235e:	b8 00 00 00 00       	mov    $0x0,%eax
    2363:	e8 cd fc ff ff       	callq  2035 <check_fail>
    2368:	39 3d 6e 50 00 00    	cmp    %edi,0x506e(%rip)        # 73dc <vlevel>
    236e:	74 1a                	je     238a <validate+0xa4>
    2370:	48 8d 3d 5b 21 00 00 	lea    0x215b(%rip),%rdi        # 44d2 <_IO_stdin_used+0x4d2>
    2377:	e8 24 ef ff ff       	callq  12a0 <puts@plt>
    237c:	89 de                	mov    %ebx,%esi
    237e:	bf 00 00 00 00       	mov    $0x0,%edi
    2383:	e8 41 fd ff ff       	callq  20c9 <notify_server>
    2388:	eb a4                	jmp    232e <validate+0x48>
    238a:	0f be 0d 77 5c 00 00 	movsbl 0x5c77(%rip),%ecx        # 8008 <target_prefix>
    2391:	89 fa                	mov    %edi,%edx
    2393:	48 8d 35 9e 22 00 00 	lea    0x229e(%rip),%rsi        # 4638 <_IO_stdin_used+0x638>
    239a:	bf 01 00 00 00       	mov    $0x1,%edi
    239f:	b8 00 00 00 00       	mov    $0x0,%eax
    23a4:	e8 07 f0 ff ff       	callq  13b0 <__printf_chk@plt>
    23a9:	89 de                	mov    %ebx,%esi
    23ab:	bf 01 00 00 00       	mov    $0x1,%edi
    23b0:	e8 14 fd ff ff       	callq  20c9 <notify_server>
    23b5:	e9 74 ff ff ff       	jmpq   232e <validate+0x48>

00000000000023ba <fail>:
    23ba:	f3 0f 1e fa          	endbr64 
    23be:	48 83 ec 08          	sub    $0x8,%rsp
    23c2:	83 3d 1f 50 00 00 00 	cmpl   $0x0,0x501f(%rip)        # 73e8 <is_checker>
    23c9:	75 11                	jne    23dc <fail+0x22>
    23cb:	89 fe                	mov    %edi,%esi
    23cd:	bf 00 00 00 00       	mov    $0x0,%edi
    23d2:	e8 f2 fc ff ff       	callq  20c9 <notify_server>
    23d7:	48 83 c4 08          	add    $0x8,%rsp
    23db:	c3                   	retq   
    23dc:	b8 00 00 00 00       	mov    $0x0,%eax
    23e1:	e8 4f fc ff ff       	callq  2035 <check_fail>

00000000000023e6 <bushandler>:
    23e6:	f3 0f 1e fa          	endbr64 
    23ea:	50                   	push   %rax
    23eb:	58                   	pop    %rax
    23ec:	48 83 ec 08          	sub    $0x8,%rsp
    23f0:	83 3d f1 4f 00 00 00 	cmpl   $0x0,0x4ff1(%rip)        # 73e8 <is_checker>
    23f7:	74 16                	je     240f <bushandler+0x29>
    23f9:	48 8d 3d 05 21 00 00 	lea    0x2105(%rip),%rdi        # 4505 <_IO_stdin_used+0x505>
    2400:	e8 9b ee ff ff       	callq  12a0 <puts@plt>
    2405:	b8 00 00 00 00       	mov    $0x0,%eax
    240a:	e8 26 fc ff ff       	callq  2035 <check_fail>
    240f:	48 8d 3d 5a 22 00 00 	lea    0x225a(%rip),%rdi        # 4670 <_IO_stdin_used+0x670>
    2416:	e8 85 ee ff ff       	callq  12a0 <puts@plt>
    241b:	48 8d 3d ed 20 00 00 	lea    0x20ed(%rip),%rdi        # 450f <_IO_stdin_used+0x50f>
    2422:	e8 79 ee ff ff       	callq  12a0 <puts@plt>
    2427:	be 00 00 00 00       	mov    $0x0,%esi
    242c:	bf 00 00 00 00       	mov    $0x0,%edi
    2431:	e8 93 fc ff ff       	callq  20c9 <notify_server>
    2436:	bf 01 00 00 00       	mov    $0x1,%edi
    243b:	e8 c0 ef ff ff       	callq  1400 <exit@plt>

0000000000002440 <seghandler>:
    2440:	f3 0f 1e fa          	endbr64 
    2444:	50                   	push   %rax
    2445:	58                   	pop    %rax
    2446:	48 83 ec 08          	sub    $0x8,%rsp
    244a:	83 3d 97 4f 00 00 00 	cmpl   $0x0,0x4f97(%rip)        # 73e8 <is_checker>
    2451:	74 16                	je     2469 <seghandler+0x29>
    2453:	48 8d 3d cb 20 00 00 	lea    0x20cb(%rip),%rdi        # 4525 <_IO_stdin_used+0x525>
    245a:	e8 41 ee ff ff       	callq  12a0 <puts@plt>
    245f:	b8 00 00 00 00       	mov    $0x0,%eax
    2464:	e8 cc fb ff ff       	callq  2035 <check_fail>
    2469:	48 8d 3d 20 22 00 00 	lea    0x2220(%rip),%rdi        # 4690 <_IO_stdin_used+0x690>
    2470:	e8 2b ee ff ff       	callq  12a0 <puts@plt>
    2475:	48 8d 3d 93 20 00 00 	lea    0x2093(%rip),%rdi        # 450f <_IO_stdin_used+0x50f>
    247c:	e8 1f ee ff ff       	callq  12a0 <puts@plt>
    2481:	be 00 00 00 00       	mov    $0x0,%esi
    2486:	bf 00 00 00 00       	mov    $0x0,%edi
    248b:	e8 39 fc ff ff       	callq  20c9 <notify_server>
    2490:	bf 01 00 00 00       	mov    $0x1,%edi
    2495:	e8 66 ef ff ff       	callq  1400 <exit@plt>

000000000000249a <illegalhandler>:
    249a:	f3 0f 1e fa          	endbr64 
    249e:	50                   	push   %rax
    249f:	58                   	pop    %rax
    24a0:	48 83 ec 08          	sub    $0x8,%rsp
    24a4:	83 3d 3d 4f 00 00 00 	cmpl   $0x0,0x4f3d(%rip)        # 73e8 <is_checker>
    24ab:	74 16                	je     24c3 <illegalhandler+0x29>
    24ad:	48 8d 3d 84 20 00 00 	lea    0x2084(%rip),%rdi        # 4538 <_IO_stdin_used+0x538>
    24b4:	e8 e7 ed ff ff       	callq  12a0 <puts@plt>
    24b9:	b8 00 00 00 00       	mov    $0x0,%eax
    24be:	e8 72 fb ff ff       	callq  2035 <check_fail>
    24c3:	48 8d 3d ee 21 00 00 	lea    0x21ee(%rip),%rdi        # 46b8 <_IO_stdin_used+0x6b8>
    24ca:	e8 d1 ed ff ff       	callq  12a0 <puts@plt>
    24cf:	48 8d 3d 39 20 00 00 	lea    0x2039(%rip),%rdi        # 450f <_IO_stdin_used+0x50f>
    24d6:	e8 c5 ed ff ff       	callq  12a0 <puts@plt>
    24db:	be 00 00 00 00       	mov    $0x0,%esi
    24e0:	bf 00 00 00 00       	mov    $0x0,%edi
    24e5:	e8 df fb ff ff       	callq  20c9 <notify_server>
    24ea:	bf 01 00 00 00       	mov    $0x1,%edi
    24ef:	e8 0c ef ff ff       	callq  1400 <exit@plt>

00000000000024f4 <sigalrmhandler>:
    24f4:	f3 0f 1e fa          	endbr64 
    24f8:	50                   	push   %rax
    24f9:	58                   	pop    %rax
    24fa:	48 83 ec 08          	sub    $0x8,%rsp
    24fe:	83 3d e3 4e 00 00 00 	cmpl   $0x0,0x4ee3(%rip)        # 73e8 <is_checker>
    2505:	74 16                	je     251d <sigalrmhandler+0x29>
    2507:	48 8d 3d 3e 20 00 00 	lea    0x203e(%rip),%rdi        # 454c <_IO_stdin_used+0x54c>
    250e:	e8 8d ed ff ff       	callq  12a0 <puts@plt>
    2513:	b8 00 00 00 00       	mov    $0x0,%eax
    2518:	e8 18 fb ff ff       	callq  2035 <check_fail>
    251d:	ba 05 00 00 00       	mov    $0x5,%edx
    2522:	48 8d 35 bf 21 00 00 	lea    0x21bf(%rip),%rsi        # 46e8 <_IO_stdin_used+0x6e8>
    2529:	bf 01 00 00 00       	mov    $0x1,%edi
    252e:	b8 00 00 00 00       	mov    $0x0,%eax
    2533:	e8 78 ee ff ff       	callq  13b0 <__printf_chk@plt>
    2538:	be 00 00 00 00       	mov    $0x0,%esi
    253d:	bf 00 00 00 00       	mov    $0x0,%edi
    2542:	e8 82 fb ff ff       	callq  20c9 <notify_server>
    2547:	bf 01 00 00 00       	mov    $0x1,%edi
    254c:	e8 af ee ff ff       	callq  1400 <exit@plt>

0000000000002551 <launch>:
    2551:	f3 0f 1e fa          	endbr64 
    2555:	55                   	push   %rbp
    2556:	48 89 e5             	mov    %rsp,%rbp
    2559:	48 83 ec 10          	sub    $0x10,%rsp
    255d:	48 89 fa             	mov    %rdi,%rdx
    2560:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    2567:	00 00 
    2569:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    256d:	31 c0                	xor    %eax,%eax
    256f:	48 8d 47 17          	lea    0x17(%rdi),%rax
    2573:	48 89 c1             	mov    %rax,%rcx
    2576:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    257a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
    2580:	48 89 e6             	mov    %rsp,%rsi
    2583:	48 29 c6             	sub    %rax,%rsi
    2586:	48 89 f0             	mov    %rsi,%rax
    2589:	48 39 c4             	cmp    %rax,%rsp
    258c:	74 12                	je     25a0 <launch+0x4f>
    258e:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    2595:	48 83 8c 24 f8 0f 00 	orq    $0x0,0xff8(%rsp)
    259c:	00 00 
    259e:	eb e9                	jmp    2589 <launch+0x38>
    25a0:	48 89 c8             	mov    %rcx,%rax
    25a3:	25 ff 0f 00 00       	and    $0xfff,%eax
    25a8:	48 29 c4             	sub    %rax,%rsp
    25ab:	48 85 c0             	test   %rax,%rax
    25ae:	74 06                	je     25b6 <launch+0x65>
    25b0:	48 83 4c 04 f8 00    	orq    $0x0,-0x8(%rsp,%rax,1)
    25b6:	48 8d 7c 24 0f       	lea    0xf(%rsp),%rdi
    25bb:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
    25bf:	be f4 00 00 00       	mov    $0xf4,%esi
    25c4:	e8 17 ed ff ff       	callq  12e0 <memset@plt>
    25c9:	48 8b 05 b0 4d 00 00 	mov    0x4db0(%rip),%rax        # 7380 <stdin@@GLIBC_2.2.5>
    25d0:	48 39 05 f9 4d 00 00 	cmp    %rax,0x4df9(%rip)        # 73d0 <infile>
    25d7:	74 3a                	je     2613 <launch+0xc2>
    25d9:	c7 05 f9 4d 00 00 00 	movl   $0x0,0x4df9(%rip)        # 73dc <vlevel>
    25e0:	00 00 00 
    25e3:	b8 00 00 00 00       	mov    $0x0,%eax
    25e8:	e8 aa f9 ff ff       	callq  1f97 <test>
    25ed:	83 3d f4 4d 00 00 00 	cmpl   $0x0,0x4df4(%rip)        # 73e8 <is_checker>
    25f4:	75 35                	jne    262b <launch+0xda>
    25f6:	48 8d 3d 6f 1f 00 00 	lea    0x1f6f(%rip),%rdi        # 456c <_IO_stdin_used+0x56c>
    25fd:	e8 9e ec ff ff       	callq  12a0 <puts@plt>
    2602:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2606:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    260d:	00 00 
    260f:	75 30                	jne    2641 <launch+0xf0>
    2611:	c9                   	leaveq 
    2612:	c3                   	retq   
    2613:	48 8d 35 3a 1f 00 00 	lea    0x1f3a(%rip),%rsi        # 4554 <_IO_stdin_used+0x554>
    261a:	bf 01 00 00 00       	mov    $0x1,%edi
    261f:	b8 00 00 00 00       	mov    $0x0,%eax
    2624:	e8 87 ed ff ff       	callq  13b0 <__printf_chk@plt>
    2629:	eb ae                	jmp    25d9 <launch+0x88>
    262b:	48 8d 3d 2f 1f 00 00 	lea    0x1f2f(%rip),%rdi        # 4561 <_IO_stdin_used+0x561>
    2632:	e8 69 ec ff ff       	callq  12a0 <puts@plt>
    2637:	b8 00 00 00 00       	mov    $0x0,%eax
    263c:	e8 f4 f9 ff ff       	callq  2035 <check_fail>
    2641:	e8 7a ec ff ff       	callq  12c0 <__stack_chk_fail@plt>

0000000000002646 <stable_launch>:
    2646:	f3 0f 1e fa          	endbr64 
    264a:	53                   	push   %rbx
    264b:	48 89 3d 76 4d 00 00 	mov    %rdi,0x4d76(%rip)        # 73c8 <global_offset>
    2652:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    2658:	41 b8 00 00 00 00    	mov    $0x0,%r8d
    265e:	b9 32 01 00 00       	mov    $0x132,%ecx
    2663:	ba 07 00 00 00       	mov    $0x7,%edx
    2668:	be 00 00 10 00       	mov    $0x100000,%esi
    266d:	bf 00 60 58 55       	mov    $0x55586000,%edi
    2672:	e8 59 ec ff ff       	callq  12d0 <mmap@plt>
    2677:	48 89 c3             	mov    %rax,%rbx
    267a:	48 3d 00 60 58 55    	cmp    $0x55586000,%rax
    2680:	75 43                	jne    26c5 <stable_launch+0x7f>
    2682:	48 8d 90 f8 ff 0f 00 	lea    0xffff8(%rax),%rdx
    2689:	48 89 15 80 59 00 00 	mov    %rdx,0x5980(%rip)        # 8010 <stack_top>
    2690:	48 89 e0             	mov    %rsp,%rax
    2693:	48 89 d4             	mov    %rdx,%rsp
    2696:	48 89 c2             	mov    %rax,%rdx
    2699:	48 89 15 20 4d 00 00 	mov    %rdx,0x4d20(%rip)        # 73c0 <global_save_stack>
    26a0:	48 8b 3d 21 4d 00 00 	mov    0x4d21(%rip),%rdi        # 73c8 <global_offset>
    26a7:	e8 a5 fe ff ff       	callq  2551 <launch>
    26ac:	48 8b 05 0d 4d 00 00 	mov    0x4d0d(%rip),%rax        # 73c0 <global_save_stack>
    26b3:	48 89 c4             	mov    %rax,%rsp
    26b6:	be 00 00 10 00       	mov    $0x100000,%esi
    26bb:	48 89 df             	mov    %rbx,%rdi
    26be:	e8 dd ec ff ff       	callq  13a0 <munmap@plt>
    26c3:	5b                   	pop    %rbx
    26c4:	c3                   	retq   
    26c5:	be 00 00 10 00       	mov    $0x100000,%esi
    26ca:	48 89 c7             	mov    %rax,%rdi
    26cd:	e8 ce ec ff ff       	callq  13a0 <munmap@plt>
    26d2:	b9 00 60 58 55       	mov    $0x55586000,%ecx
    26d7:	48 8d 15 42 20 00 00 	lea    0x2042(%rip),%rdx        # 4720 <_IO_stdin_used+0x720>
    26de:	be 01 00 00 00       	mov    $0x1,%esi
    26e3:	48 8b 3d b6 4c 00 00 	mov    0x4cb6(%rip),%rdi        # 73a0 <stderr@@GLIBC_2.2.5>
    26ea:	b8 00 00 00 00       	mov    $0x0,%eax
    26ef:	e8 2c ed ff ff       	callq  1420 <__fprintf_chk@plt>
    26f4:	bf 01 00 00 00       	mov    $0x1,%edi
    26f9:	e8 02 ed ff ff       	callq  1400 <exit@plt>

00000000000026fe <rio_readinitb>:
    26fe:	89 37                	mov    %esi,(%rdi)
    2700:	c7 47 04 00 00 00 00 	movl   $0x0,0x4(%rdi)
    2707:	48 8d 47 10          	lea    0x10(%rdi),%rax
    270b:	48 89 47 08          	mov    %rax,0x8(%rdi)
    270f:	c3                   	retq   

0000000000002710 <sigalrm_handler>:
    2710:	f3 0f 1e fa          	endbr64 
    2714:	50                   	push   %rax
    2715:	58                   	pop    %rax
    2716:	48 83 ec 08          	sub    $0x8,%rsp
    271a:	b9 00 00 00 00       	mov    $0x0,%ecx
    271f:	48 8d 15 3a 20 00 00 	lea    0x203a(%rip),%rdx        # 4760 <trans_char+0x10>
    2726:	be 01 00 00 00       	mov    $0x1,%esi
    272b:	48 8b 3d 6e 4c 00 00 	mov    0x4c6e(%rip),%rdi        # 73a0 <stderr@@GLIBC_2.2.5>
    2732:	b8 00 00 00 00       	mov    $0x0,%eax
    2737:	e8 e4 ec ff ff       	callq  1420 <__fprintf_chk@plt>
    273c:	bf 01 00 00 00       	mov    $0x1,%edi
    2741:	e8 ba ec ff ff       	callq  1400 <exit@plt>

0000000000002746 <rio_writen>:
    2746:	41 55                	push   %r13
    2748:	41 54                	push   %r12
    274a:	55                   	push   %rbp
    274b:	53                   	push   %rbx
    274c:	48 83 ec 08          	sub    $0x8,%rsp
    2750:	41 89 fc             	mov    %edi,%r12d
    2753:	48 89 f5             	mov    %rsi,%rbp
    2756:	49 89 d5             	mov    %rdx,%r13
    2759:	48 89 d3             	mov    %rdx,%rbx
    275c:	eb 06                	jmp    2764 <rio_writen+0x1e>
    275e:	48 29 c3             	sub    %rax,%rbx
    2761:	48 01 c5             	add    %rax,%rbp
    2764:	48 85 db             	test   %rbx,%rbx
    2767:	74 24                	je     278d <rio_writen+0x47>
    2769:	48 89 da             	mov    %rbx,%rdx
    276c:	48 89 ee             	mov    %rbp,%rsi
    276f:	44 89 e7             	mov    %r12d,%edi
    2772:	e8 39 eb ff ff       	callq  12b0 <write@plt>
    2777:	48 85 c0             	test   %rax,%rax
    277a:	7f e2                	jg     275e <rio_writen+0x18>
    277c:	e8 df ea ff ff       	callq  1260 <__errno_location@plt>
    2781:	83 38 04             	cmpl   $0x4,(%rax)
    2784:	75 15                	jne    279b <rio_writen+0x55>
    2786:	b8 00 00 00 00       	mov    $0x0,%eax
    278b:	eb d1                	jmp    275e <rio_writen+0x18>
    278d:	4c 89 e8             	mov    %r13,%rax
    2790:	48 83 c4 08          	add    $0x8,%rsp
    2794:	5b                   	pop    %rbx
    2795:	5d                   	pop    %rbp
    2796:	41 5c                	pop    %r12
    2798:	41 5d                	pop    %r13
    279a:	c3                   	retq   
    279b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
    27a2:	eb ec                	jmp    2790 <rio_writen+0x4a>

00000000000027a4 <rio_read>:
    27a4:	41 55                	push   %r13
    27a6:	41 54                	push   %r12
    27a8:	55                   	push   %rbp
    27a9:	53                   	push   %rbx
    27aa:	48 83 ec 08          	sub    $0x8,%rsp
    27ae:	48 89 fb             	mov    %rdi,%rbx
    27b1:	49 89 f5             	mov    %rsi,%r13
    27b4:	49 89 d4             	mov    %rdx,%r12
    27b7:	eb 17                	jmp    27d0 <rio_read+0x2c>
    27b9:	e8 a2 ea ff ff       	callq  1260 <__errno_location@plt>
    27be:	83 38 04             	cmpl   $0x4,(%rax)
    27c1:	74 0d                	je     27d0 <rio_read+0x2c>
    27c3:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
    27ca:	eb 54                	jmp    2820 <rio_read+0x7c>
    27cc:	48 89 6b 08          	mov    %rbp,0x8(%rbx)
    27d0:	8b 6b 04             	mov    0x4(%rbx),%ebp
    27d3:	85 ed                	test   %ebp,%ebp
    27d5:	7f 23                	jg     27fa <rio_read+0x56>
    27d7:	48 8d 6b 10          	lea    0x10(%rbx),%rbp
    27db:	8b 3b                	mov    (%rbx),%edi
    27dd:	ba 00 20 00 00       	mov    $0x2000,%edx
    27e2:	48 89 ee             	mov    %rbp,%rsi
    27e5:	e8 26 eb ff ff       	callq  1310 <read@plt>
    27ea:	89 43 04             	mov    %eax,0x4(%rbx)
    27ed:	85 c0                	test   %eax,%eax
    27ef:	78 c8                	js     27b9 <rio_read+0x15>
    27f1:	75 d9                	jne    27cc <rio_read+0x28>
    27f3:	b8 00 00 00 00       	mov    $0x0,%eax
    27f8:	eb 26                	jmp    2820 <rio_read+0x7c>
    27fa:	89 e8                	mov    %ebp,%eax
    27fc:	4c 39 e0             	cmp    %r12,%rax
    27ff:	72 03                	jb     2804 <rio_read+0x60>
    2801:	44 89 e5             	mov    %r12d,%ebp
    2804:	4c 63 e5             	movslq %ebp,%r12
    2807:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    280b:	4c 89 e2             	mov    %r12,%rdx
    280e:	4c 89 ef             	mov    %r13,%rdi
    2811:	e8 4a eb ff ff       	callq  1360 <memcpy@plt>
    2816:	4c 01 63 08          	add    %r12,0x8(%rbx)
    281a:	29 6b 04             	sub    %ebp,0x4(%rbx)
    281d:	4c 89 e0             	mov    %r12,%rax
    2820:	48 83 c4 08          	add    $0x8,%rsp
    2824:	5b                   	pop    %rbx
    2825:	5d                   	pop    %rbp
    2826:	41 5c                	pop    %r12
    2828:	41 5d                	pop    %r13
    282a:	c3                   	retq   

000000000000282b <rio_readlineb>:
    282b:	41 55                	push   %r13
    282d:	41 54                	push   %r12
    282f:	55                   	push   %rbp
    2830:	53                   	push   %rbx
    2831:	48 83 ec 18          	sub    $0x18,%rsp
    2835:	49 89 fd             	mov    %rdi,%r13
    2838:	48 89 f5             	mov    %rsi,%rbp
    283b:	49 89 d4             	mov    %rdx,%r12
    283e:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    2845:	00 00 
    2847:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    284c:	31 c0                	xor    %eax,%eax
    284e:	bb 01 00 00 00       	mov    $0x1,%ebx
    2853:	eb 18                	jmp    286d <rio_readlineb+0x42>
    2855:	85 c0                	test   %eax,%eax
    2857:	75 65                	jne    28be <rio_readlineb+0x93>
    2859:	48 83 fb 01          	cmp    $0x1,%rbx
    285d:	75 3d                	jne    289c <rio_readlineb+0x71>
    285f:	b8 00 00 00 00       	mov    $0x0,%eax
    2864:	eb 3d                	jmp    28a3 <rio_readlineb+0x78>
    2866:	48 83 c3 01          	add    $0x1,%rbx
    286a:	48 89 d5             	mov    %rdx,%rbp
    286d:	4c 39 e3             	cmp    %r12,%rbx
    2870:	73 2a                	jae    289c <rio_readlineb+0x71>
    2872:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
    2877:	ba 01 00 00 00       	mov    $0x1,%edx
    287c:	4c 89 ef             	mov    %r13,%rdi
    287f:	e8 20 ff ff ff       	callq  27a4 <rio_read>
    2884:	83 f8 01             	cmp    $0x1,%eax
    2887:	75 cc                	jne    2855 <rio_readlineb+0x2a>
    2889:	48 8d 55 01          	lea    0x1(%rbp),%rdx
    288d:	0f b6 44 24 07       	movzbl 0x7(%rsp),%eax
    2892:	88 45 00             	mov    %al,0x0(%rbp)
    2895:	3c 0a                	cmp    $0xa,%al
    2897:	75 cd                	jne    2866 <rio_readlineb+0x3b>
    2899:	48 89 d5             	mov    %rdx,%rbp
    289c:	c6 45 00 00          	movb   $0x0,0x0(%rbp)
    28a0:	48 89 d8             	mov    %rbx,%rax
    28a3:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    28a8:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
    28af:	00 00 
    28b1:	75 14                	jne    28c7 <rio_readlineb+0x9c>
    28b3:	48 83 c4 18          	add    $0x18,%rsp
    28b7:	5b                   	pop    %rbx
    28b8:	5d                   	pop    %rbp
    28b9:	41 5c                	pop    %r12
    28bb:	41 5d                	pop    %r13
    28bd:	c3                   	retq   
    28be:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
    28c5:	eb dc                	jmp    28a3 <rio_readlineb+0x78>
    28c7:	e8 f4 e9 ff ff       	callq  12c0 <__stack_chk_fail@plt>

00000000000028cc <urlencode>:
    28cc:	41 54                	push   %r12
    28ce:	55                   	push   %rbp
    28cf:	53                   	push   %rbx
    28d0:	48 83 ec 10          	sub    $0x10,%rsp
    28d4:	48 89 fb             	mov    %rdi,%rbx
    28d7:	48 89 f5             	mov    %rsi,%rbp
    28da:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    28e1:	00 00 
    28e3:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    28e8:	31 c0                	xor    %eax,%eax
    28ea:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
    28f1:	f2 ae                	repnz scas %es:(%rdi),%al
    28f3:	48 f7 d1             	not    %rcx
    28f6:	8d 41 ff             	lea    -0x1(%rcx),%eax
    28f9:	eb 0f                	jmp    290a <urlencode+0x3e>
    28fb:	44 88 45 00          	mov    %r8b,0x0(%rbp)
    28ff:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
    2903:	48 83 c3 01          	add    $0x1,%rbx
    2907:	44 89 e0             	mov    %r12d,%eax
    290a:	44 8d 60 ff          	lea    -0x1(%rax),%r12d
    290e:	85 c0                	test   %eax,%eax
    2910:	0f 84 a8 00 00 00    	je     29be <urlencode+0xf2>
    2916:	44 0f b6 03          	movzbl (%rbx),%r8d
    291a:	41 80 f8 2a          	cmp    $0x2a,%r8b
    291e:	0f 94 c2             	sete   %dl
    2921:	41 80 f8 2d          	cmp    $0x2d,%r8b
    2925:	0f 94 c0             	sete   %al
    2928:	08 c2                	or     %al,%dl
    292a:	75 cf                	jne    28fb <urlencode+0x2f>
    292c:	41 80 f8 2e          	cmp    $0x2e,%r8b
    2930:	74 c9                	je     28fb <urlencode+0x2f>
    2932:	41 80 f8 5f          	cmp    $0x5f,%r8b
    2936:	74 c3                	je     28fb <urlencode+0x2f>
    2938:	41 8d 40 d0          	lea    -0x30(%r8),%eax
    293c:	3c 09                	cmp    $0x9,%al
    293e:	76 bb                	jbe    28fb <urlencode+0x2f>
    2940:	41 8d 40 bf          	lea    -0x41(%r8),%eax
    2944:	3c 19                	cmp    $0x19,%al
    2946:	76 b3                	jbe    28fb <urlencode+0x2f>
    2948:	41 8d 40 9f          	lea    -0x61(%r8),%eax
    294c:	3c 19                	cmp    $0x19,%al
    294e:	76 ab                	jbe    28fb <urlencode+0x2f>
    2950:	41 80 f8 20          	cmp    $0x20,%r8b
    2954:	74 56                	je     29ac <urlencode+0xe0>
    2956:	41 8d 40 e0          	lea    -0x20(%r8),%eax
    295a:	3c 5f                	cmp    $0x5f,%al
    295c:	0f 96 c2             	setbe  %dl
    295f:	41 80 f8 09          	cmp    $0x9,%r8b
    2963:	0f 94 c0             	sete   %al
    2966:	08 c2                	or     %al,%dl
    2968:	74 4f                	je     29b9 <urlencode+0xed>
    296a:	48 89 e7             	mov    %rsp,%rdi
    296d:	45 0f b6 c0          	movzbl %r8b,%r8d
    2971:	48 8d 0d 7d 1e 00 00 	lea    0x1e7d(%rip),%rcx        # 47f5 <trans_char+0xa5>
    2978:	ba 08 00 00 00       	mov    $0x8,%edx
    297d:	be 01 00 00 00       	mov    $0x1,%esi
    2982:	b8 00 00 00 00       	mov    $0x0,%eax
    2987:	e8 b4 ea ff ff       	callq  1440 <__sprintf_chk@plt>
    298c:	0f b6 04 24          	movzbl (%rsp),%eax
    2990:	88 45 00             	mov    %al,0x0(%rbp)
    2993:	0f b6 44 24 01       	movzbl 0x1(%rsp),%eax
    2998:	88 45 01             	mov    %al,0x1(%rbp)
    299b:	0f b6 44 24 02       	movzbl 0x2(%rsp),%eax
    29a0:	88 45 02             	mov    %al,0x2(%rbp)
    29a3:	48 8d 6d 03          	lea    0x3(%rbp),%rbp
    29a7:	e9 57 ff ff ff       	jmpq   2903 <urlencode+0x37>
    29ac:	c6 45 00 2b          	movb   $0x2b,0x0(%rbp)
    29b0:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
    29b4:	e9 4a ff ff ff       	jmpq   2903 <urlencode+0x37>
    29b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    29be:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    29c3:	64 48 33 34 25 28 00 	xor    %fs:0x28,%rsi
    29ca:	00 00 
    29cc:	75 09                	jne    29d7 <urlencode+0x10b>
    29ce:	48 83 c4 10          	add    $0x10,%rsp
    29d2:	5b                   	pop    %rbx
    29d3:	5d                   	pop    %rbp
    29d4:	41 5c                	pop    %r12
    29d6:	c3                   	retq   
    29d7:	e8 e4 e8 ff ff       	callq  12c0 <__stack_chk_fail@plt>

00000000000029dc <submitr>:
    29dc:	f3 0f 1e fa          	endbr64 
    29e0:	41 57                	push   %r15
    29e2:	41 56                	push   %r14
    29e4:	41 55                	push   %r13
    29e6:	41 54                	push   %r12
    29e8:	55                   	push   %rbp
    29e9:	53                   	push   %rbx
    29ea:	4c 8d 9c 24 00 60 ff 	lea    -0xa000(%rsp),%r11
    29f1:	ff 
    29f2:	48 81 ec 00 10 00 00 	sub    $0x1000,%rsp
    29f9:	48 83 0c 24 00       	orq    $0x0,(%rsp)
    29fe:	4c 39 dc             	cmp    %r11,%rsp
    2a01:	75 ef                	jne    29f2 <submitr+0x16>
    2a03:	48 83 ec 68          	sub    $0x68,%rsp
    2a07:	49 89 fc             	mov    %rdi,%r12
    2a0a:	89 74 24 14          	mov    %esi,0x14(%rsp)
    2a0e:	49 89 d6             	mov    %rdx,%r14
    2a11:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
    2a16:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
    2a1b:	4d 89 cd             	mov    %r9,%r13
    2a1e:	48 8b ac 24 a0 a0 00 	mov    0xa0a0(%rsp),%rbp
    2a25:	00 
    2a26:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    2a2d:	00 00 
    2a2f:	48 89 84 24 58 a0 00 	mov    %rax,0xa058(%rsp)
    2a36:	00 
    2a37:	31 c0                	xor    %eax,%eax
    2a39:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%rsp)
    2a40:	00 
    2a41:	ba 00 00 00 00       	mov    $0x0,%edx
    2a46:	be 01 00 00 00       	mov    $0x1,%esi
    2a4b:	bf 02 00 00 00       	mov    $0x2,%edi
    2a50:	e8 fb e9 ff ff       	callq  1450 <socket@plt>
    2a55:	85 c0                	test   %eax,%eax
    2a57:	0f 88 a0 02 00 00    	js     2cfd <submitr+0x321>
    2a5d:	89 c3                	mov    %eax,%ebx
    2a5f:	4c 89 e7             	mov    %r12,%rdi
    2a62:	e8 c9 e8 ff ff       	callq  1330 <gethostbyname@plt>
    2a67:	48 85 c0             	test   %rax,%rax
    2a6a:	0f 84 d9 02 00 00    	je     2d49 <submitr+0x36d>
    2a70:	4c 8d 7c 24 30       	lea    0x30(%rsp),%r15
    2a75:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    2a7c:	00 00 
    2a7e:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
    2a85:	00 00 
    2a87:	66 c7 44 24 30 02 00 	movw   $0x2,0x30(%rsp)
    2a8e:	48 63 50 14          	movslq 0x14(%rax),%rdx
    2a92:	48 8b 40 18          	mov    0x18(%rax),%rax
    2a96:	48 8b 30             	mov    (%rax),%rsi
    2a99:	48 8d 7c 24 34       	lea    0x34(%rsp),%rdi
    2a9e:	b9 0c 00 00 00       	mov    $0xc,%ecx
    2aa3:	e8 98 e8 ff ff       	callq  1340 <__memmove_chk@plt>
    2aa8:	0f b7 74 24 14       	movzwl 0x14(%rsp),%esi
    2aad:	66 c1 c6 08          	rol    $0x8,%si
    2ab1:	66 89 74 24 32       	mov    %si,0x32(%rsp)
    2ab6:	ba 10 00 00 00       	mov    $0x10,%edx
    2abb:	4c 89 fe             	mov    %r15,%rsi
    2abe:	89 df                	mov    %ebx,%edi
    2ac0:	e8 4b e9 ff ff       	callq  1410 <connect@plt>
    2ac5:	85 c0                	test   %eax,%eax
    2ac7:	0f 88 e4 02 00 00    	js     2db1 <submitr+0x3d5>
    2acd:	49 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%r8
    2ad4:	b8 00 00 00 00       	mov    $0x0,%eax
    2ad9:	4c 89 c1             	mov    %r8,%rcx
    2adc:	4c 89 ef             	mov    %r13,%rdi
    2adf:	f2 ae                	repnz scas %es:(%rdi),%al
    2ae1:	48 89 ca             	mov    %rcx,%rdx
    2ae4:	48 f7 d2             	not    %rdx
    2ae7:	4c 89 c1             	mov    %r8,%rcx
    2aea:	4c 89 f7             	mov    %r14,%rdi
    2aed:	f2 ae                	repnz scas %es:(%rdi),%al
    2aef:	48 f7 d1             	not    %rcx
    2af2:	48 89 ce             	mov    %rcx,%rsi
    2af5:	4c 89 c1             	mov    %r8,%rcx
    2af8:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    2afd:	f2 ae                	repnz scas %es:(%rdi),%al
    2aff:	48 f7 d1             	not    %rcx
    2b02:	48 8d 74 0e fe       	lea    -0x2(%rsi,%rcx,1),%rsi
    2b07:	4c 89 c1             	mov    %r8,%rcx
    2b0a:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    2b0f:	f2 ae                	repnz scas %es:(%rdi),%al
    2b11:	48 89 c8             	mov    %rcx,%rax
    2b14:	48 f7 d0             	not    %rax
    2b17:	48 8d 4c 06 ff       	lea    -0x1(%rsi,%rax,1),%rcx
    2b1c:	48 8d 44 52 fd       	lea    -0x3(%rdx,%rdx,2),%rax
    2b21:	48 8d 84 01 80 00 00 	lea    0x80(%rcx,%rax,1),%rax
    2b28:	00 
    2b29:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
    2b2f:	0f 87 d6 02 00 00    	ja     2e0b <submitr+0x42f>
    2b35:	48 8d b4 24 50 40 00 	lea    0x4050(%rsp),%rsi
    2b3c:	00 
    2b3d:	b9 00 04 00 00       	mov    $0x400,%ecx
    2b42:	b8 00 00 00 00       	mov    $0x0,%eax
    2b47:	48 89 f7             	mov    %rsi,%rdi
    2b4a:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    2b4d:	4c 89 ef             	mov    %r13,%rdi
    2b50:	e8 77 fd ff ff       	callq  28cc <urlencode>
    2b55:	85 c0                	test   %eax,%eax
    2b57:	0f 88 21 03 00 00    	js     2e7e <submitr+0x4a2>
    2b5d:	4c 8d bc 24 50 20 00 	lea    0x2050(%rsp),%r15
    2b64:	00 
    2b65:	41 54                	push   %r12
    2b67:	48 8d 84 24 58 40 00 	lea    0x4058(%rsp),%rax
    2b6e:	00 
    2b6f:	50                   	push   %rax
    2b70:	4d 89 f1             	mov    %r14,%r9
    2b73:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
    2b78:	48 8d 0d 09 1c 00 00 	lea    0x1c09(%rip),%rcx        # 4788 <trans_char+0x38>
    2b7f:	ba 00 20 00 00       	mov    $0x2000,%edx
    2b84:	be 01 00 00 00       	mov    $0x1,%esi
    2b89:	4c 89 ff             	mov    %r15,%rdi
    2b8c:	b8 00 00 00 00       	mov    $0x0,%eax
    2b91:	e8 aa e8 ff ff       	callq  1440 <__sprintf_chk@plt>
    2b96:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
    2b9d:	b8 00 00 00 00       	mov    $0x0,%eax
    2ba2:	4c 89 ff             	mov    %r15,%rdi
    2ba5:	f2 ae                	repnz scas %es:(%rdi),%al
    2ba7:	48 f7 d1             	not    %rcx
    2baa:	48 8d 51 ff          	lea    -0x1(%rcx),%rdx
    2bae:	4c 89 fe             	mov    %r15,%rsi
    2bb1:	89 df                	mov    %ebx,%edi
    2bb3:	e8 8e fb ff ff       	callq  2746 <rio_writen>
    2bb8:	48 83 c4 10          	add    $0x10,%rsp
    2bbc:	48 85 c0             	test   %rax,%rax
    2bbf:	0f 88 44 03 00 00    	js     2f09 <submitr+0x52d>
    2bc5:	4c 8d 64 24 40       	lea    0x40(%rsp),%r12
    2bca:	89 de                	mov    %ebx,%esi
    2bcc:	4c 89 e7             	mov    %r12,%rdi
    2bcf:	e8 2a fb ff ff       	callq  26fe <rio_readinitb>
    2bd4:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    2bdb:	00 
    2bdc:	ba 00 20 00 00       	mov    $0x2000,%edx
    2be1:	4c 89 e7             	mov    %r12,%rdi
    2be4:	e8 42 fc ff ff       	callq  282b <rio_readlineb>
    2be9:	48 85 c0             	test   %rax,%rax
    2bec:	0f 8e 86 03 00 00    	jle    2f78 <submitr+0x59c>
    2bf2:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
    2bf7:	48 8d 94 24 50 60 00 	lea    0x6050(%rsp),%rdx
    2bfe:	00 
    2bff:	48 8d bc 24 50 20 00 	lea    0x2050(%rsp),%rdi
    2c06:	00 
    2c07:	4c 8d 84 24 50 80 00 	lea    0x8050(%rsp),%r8
    2c0e:	00 
    2c0f:	48 8d 35 e6 1b 00 00 	lea    0x1be6(%rip),%rsi        # 47fc <trans_char+0xac>
    2c16:	b8 00 00 00 00       	mov    $0x0,%eax
    2c1b:	e8 70 e7 ff ff       	callq  1390 <__isoc99_sscanf@plt>
    2c20:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    2c27:	00 
    2c28:	b9 03 00 00 00       	mov    $0x3,%ecx
    2c2d:	48 8d 3d df 1b 00 00 	lea    0x1bdf(%rip),%rdi        # 4813 <trans_char+0xc3>
    2c34:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
    2c36:	0f 97 c0             	seta   %al
    2c39:	1c 00                	sbb    $0x0,%al
    2c3b:	84 c0                	test   %al,%al
    2c3d:	0f 84 b3 03 00 00    	je     2ff6 <submitr+0x61a>
    2c43:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    2c4a:	00 
    2c4b:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    2c50:	ba 00 20 00 00       	mov    $0x2000,%edx
    2c55:	e8 d1 fb ff ff       	callq  282b <rio_readlineb>
    2c5a:	48 85 c0             	test   %rax,%rax
    2c5d:	7f c1                	jg     2c20 <submitr+0x244>
    2c5f:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    2c66:	3a 20 43 
    2c69:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    2c70:	20 75 6e 
    2c73:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2c77:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2c7b:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2c82:	74 6f 20 
    2c85:	48 ba 72 65 61 64 20 	movabs $0x6165682064616572,%rdx
    2c8c:	68 65 61 
    2c8f:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2c93:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2c97:	48 b8 64 65 72 73 20 	movabs $0x6f72662073726564,%rax
    2c9e:	66 72 6f 
    2ca1:	48 ba 6d 20 74 68 65 	movabs $0x657220656874206d,%rdx
    2ca8:	20 72 65 
    2cab:	48 89 45 20          	mov    %rax,0x20(%rbp)
    2caf:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    2cb3:	48 b8 73 75 6c 74 20 	movabs $0x72657320746c7573,%rax
    2cba:	73 65 72 
    2cbd:	48 89 45 30          	mov    %rax,0x30(%rbp)
    2cc1:	c7 45 38 76 65 72 00 	movl   $0x726576,0x38(%rbp)
    2cc8:	89 df                	mov    %ebx,%edi
    2cca:	e8 31 e6 ff ff       	callq  1300 <close@plt>
    2ccf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2cd4:	48 8b 9c 24 58 a0 00 	mov    0xa058(%rsp),%rbx
    2cdb:	00 
    2cdc:	64 48 33 1c 25 28 00 	xor    %fs:0x28,%rbx
    2ce3:	00 00 
    2ce5:	0f 85 7e 04 00 00    	jne    3169 <submitr+0x78d>
    2ceb:	48 81 c4 68 a0 00 00 	add    $0xa068,%rsp
    2cf2:	5b                   	pop    %rbx
    2cf3:	5d                   	pop    %rbp
    2cf4:	41 5c                	pop    %r12
    2cf6:	41 5d                	pop    %r13
    2cf8:	41 5e                	pop    %r14
    2cfa:	41 5f                	pop    %r15
    2cfc:	c3                   	retq   
    2cfd:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    2d04:	3a 20 43 
    2d07:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    2d0e:	20 75 6e 
    2d11:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2d15:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2d19:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2d20:	74 6f 20 
    2d23:	48 ba 63 72 65 61 74 	movabs $0x7320657461657263,%rdx
    2d2a:	65 20 73 
    2d2d:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2d31:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2d35:	c7 45 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%rbp)
    2d3c:	66 c7 45 24 74 00    	movw   $0x74,0x24(%rbp)
    2d42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2d47:	eb 8b                	jmp    2cd4 <submitr+0x2f8>
    2d49:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
    2d50:	3a 20 44 
    2d53:	48 ba 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rdx
    2d5a:	20 75 6e 
    2d5d:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2d61:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2d65:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2d6c:	74 6f 20 
    2d6f:	48 ba 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rdx
    2d76:	76 65 20 
    2d79:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2d7d:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2d81:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
    2d88:	72 20 61 
    2d8b:	48 89 45 20          	mov    %rax,0x20(%rbp)
    2d8f:	c7 45 28 64 64 72 65 	movl   $0x65726464,0x28(%rbp)
    2d96:	66 c7 45 2c 73 73    	movw   $0x7373,0x2c(%rbp)
    2d9c:	c6 45 2e 00          	movb   $0x0,0x2e(%rbp)
    2da0:	89 df                	mov    %ebx,%edi
    2da2:	e8 59 e5 ff ff       	callq  1300 <close@plt>
    2da7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2dac:	e9 23 ff ff ff       	jmpq   2cd4 <submitr+0x2f8>
    2db1:	48 b8 45 72 72 6f 72 	movabs $0x55203a726f727245,%rax
    2db8:	3a 20 55 
    2dbb:	48 ba 6e 61 62 6c 65 	movabs $0x6f7420656c62616e,%rdx
    2dc2:	20 74 6f 
    2dc5:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2dc9:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2dcd:	48 b8 20 63 6f 6e 6e 	movabs $0x7463656e6e6f6320,%rax
    2dd4:	65 63 74 
    2dd7:	48 ba 20 74 6f 20 74 	movabs $0x20656874206f7420,%rdx
    2dde:	68 65 20 
    2de1:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2de5:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2de9:	c7 45 20 73 65 72 76 	movl   $0x76726573,0x20(%rbp)
    2df0:	66 c7 45 24 65 72    	movw   $0x7265,0x24(%rbp)
    2df6:	c6 45 26 00          	movb   $0x0,0x26(%rbp)
    2dfa:	89 df                	mov    %ebx,%edi
    2dfc:	e8 ff e4 ff ff       	callq  1300 <close@plt>
    2e01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2e06:	e9 c9 fe ff ff       	jmpq   2cd4 <submitr+0x2f8>
    2e0b:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
    2e12:	3a 20 52 
    2e15:	48 ba 65 73 75 6c 74 	movabs $0x747320746c757365,%rdx
    2e1c:	20 73 74 
    2e1f:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2e23:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2e27:	48 b8 72 69 6e 67 20 	movabs $0x6f6f7420676e6972,%rax
    2e2e:	74 6f 6f 
    2e31:	48 ba 20 6c 61 72 67 	movabs $0x202e656772616c20,%rdx
    2e38:	65 2e 20 
    2e3b:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2e3f:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2e43:	48 b8 49 6e 63 72 65 	movabs $0x6573616572636e49,%rax
    2e4a:	61 73 65 
    2e4d:	48 ba 20 53 55 42 4d 	movabs $0x5254494d42555320,%rdx
    2e54:	49 54 52 
    2e57:	48 89 45 20          	mov    %rax,0x20(%rbp)
    2e5b:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    2e5f:	48 b8 5f 4d 41 58 42 	movabs $0x46554258414d5f,%rax
    2e66:	55 46 00 
    2e69:	48 89 45 30          	mov    %rax,0x30(%rbp)
    2e6d:	89 df                	mov    %ebx,%edi
    2e6f:	e8 8c e4 ff ff       	callq  1300 <close@plt>
    2e74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2e79:	e9 56 fe ff ff       	jmpq   2cd4 <submitr+0x2f8>
    2e7e:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
    2e85:	3a 20 52 
    2e88:	48 ba 65 73 75 6c 74 	movabs $0x747320746c757365,%rdx
    2e8f:	20 73 74 
    2e92:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2e96:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2e9a:	48 b8 72 69 6e 67 20 	movabs $0x6e6f6320676e6972,%rax
    2ea1:	63 6f 6e 
    2ea4:	48 ba 74 61 69 6e 73 	movabs $0x6e6120736e696174,%rdx
    2eab:	20 61 6e 
    2eae:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2eb2:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2eb6:	48 b8 20 69 6c 6c 65 	movabs $0x6c6167656c6c6920,%rax
    2ebd:	67 61 6c 
    2ec0:	48 ba 20 6f 72 20 75 	movabs $0x72706e7520726f20,%rdx
    2ec7:	6e 70 72 
    2eca:	48 89 45 20          	mov    %rax,0x20(%rbp)
    2ece:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    2ed2:	48 b8 69 6e 74 61 62 	movabs $0x20656c6261746e69,%rax
    2ed9:	6c 65 20 
    2edc:	48 ba 63 68 61 72 61 	movabs $0x6574636172616863,%rdx
    2ee3:	63 74 65 
    2ee6:	48 89 45 30          	mov    %rax,0x30(%rbp)
    2eea:	48 89 55 38          	mov    %rdx,0x38(%rbp)
    2eee:	66 c7 45 40 72 2e    	movw   $0x2e72,0x40(%rbp)
    2ef4:	c6 45 42 00          	movb   $0x0,0x42(%rbp)
    2ef8:	89 df                	mov    %ebx,%edi
    2efa:	e8 01 e4 ff ff       	callq  1300 <close@plt>
    2eff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2f04:	e9 cb fd ff ff       	jmpq   2cd4 <submitr+0x2f8>
    2f09:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    2f10:	3a 20 43 
    2f13:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    2f1a:	20 75 6e 
    2f1d:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2f21:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2f25:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2f2c:	74 6f 20 
    2f2f:	48 ba 77 72 69 74 65 	movabs $0x6f74206574697277,%rdx
    2f36:	20 74 6f 
    2f39:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2f3d:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2f41:	48 b8 20 74 68 65 20 	movabs $0x7365722065687420,%rax
    2f48:	72 65 73 
    2f4b:	48 ba 75 6c 74 20 73 	movabs $0x7672657320746c75,%rdx
    2f52:	65 72 76 
    2f55:	48 89 45 20          	mov    %rax,0x20(%rbp)
    2f59:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    2f5d:	66 c7 45 30 65 72    	movw   $0x7265,0x30(%rbp)
    2f63:	c6 45 32 00          	movb   $0x0,0x32(%rbp)
    2f67:	89 df                	mov    %ebx,%edi
    2f69:	e8 92 e3 ff ff       	callq  1300 <close@plt>
    2f6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2f73:	e9 5c fd ff ff       	jmpq   2cd4 <submitr+0x2f8>
    2f78:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    2f7f:	3a 20 43 
    2f82:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    2f89:	20 75 6e 
    2f8c:	48 89 45 00          	mov    %rax,0x0(%rbp)
    2f90:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    2f94:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    2f9b:	74 6f 20 
    2f9e:	48 ba 72 65 61 64 20 	movabs $0x7269662064616572,%rdx
    2fa5:	66 69 72 
    2fa8:	48 89 45 10          	mov    %rax,0x10(%rbp)
    2fac:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    2fb0:	48 b8 73 74 20 68 65 	movabs $0x6564616568207473,%rax
    2fb7:	61 64 65 
    2fba:	48 ba 72 20 66 72 6f 	movabs $0x72206d6f72662072,%rdx
    2fc1:	6d 20 72 
    2fc4:	48 89 45 20          	mov    %rax,0x20(%rbp)
    2fc8:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    2fcc:	48 b8 65 73 75 6c 74 	movabs $0x657320746c757365,%rax
    2fd3:	20 73 65 
    2fd6:	48 89 45 30          	mov    %rax,0x30(%rbp)
    2fda:	c7 45 38 72 76 65 72 	movl   $0x72657672,0x38(%rbp)
    2fe1:	c6 45 3c 00          	movb   $0x0,0x3c(%rbp)
    2fe5:	89 df                	mov    %ebx,%edi
    2fe7:	e8 14 e3 ff ff       	callq  1300 <close@plt>
    2fec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2ff1:	e9 de fc ff ff       	jmpq   2cd4 <submitr+0x2f8>
    2ff6:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    2ffd:	00 
    2ffe:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    3003:	ba 00 20 00 00       	mov    $0x2000,%edx
    3008:	e8 1e f8 ff ff       	callq  282b <rio_readlineb>
    300d:	48 85 c0             	test   %rax,%rax
    3010:	0f 8e 96 00 00 00    	jle    30ac <submitr+0x6d0>
    3016:	44 8b 44 24 2c       	mov    0x2c(%rsp),%r8d
    301b:	41 81 f8 c8 00 00 00 	cmp    $0xc8,%r8d
    3022:	0f 85 08 01 00 00    	jne    3130 <submitr+0x754>
    3028:	48 8d b4 24 50 20 00 	lea    0x2050(%rsp),%rsi
    302f:	00 
    3030:	48 89 ef             	mov    %rbp,%rdi
    3033:	e8 58 e2 ff ff       	callq  1290 <strcpy@plt>
    3038:	89 df                	mov    %ebx,%edi
    303a:	e8 c1 e2 ff ff       	callq  1300 <close@plt>
    303f:	b9 04 00 00 00       	mov    $0x4,%ecx
    3044:	48 8d 3d c2 17 00 00 	lea    0x17c2(%rip),%rdi        # 480d <trans_char+0xbd>
    304b:	48 89 ee             	mov    %rbp,%rsi
    304e:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
    3050:	0f 97 c0             	seta   %al
    3053:	1c 00                	sbb    $0x0,%al
    3055:	0f be c0             	movsbl %al,%eax
    3058:	85 c0                	test   %eax,%eax
    305a:	0f 84 74 fc ff ff    	je     2cd4 <submitr+0x2f8>
    3060:	b9 05 00 00 00       	mov    $0x5,%ecx
    3065:	48 8d 3d a5 17 00 00 	lea    0x17a5(%rip),%rdi        # 4811 <trans_char+0xc1>
    306c:	48 89 ee             	mov    %rbp,%rsi
    306f:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
    3071:	0f 97 c0             	seta   %al
    3074:	1c 00                	sbb    $0x0,%al
    3076:	0f be c0             	movsbl %al,%eax
    3079:	85 c0                	test   %eax,%eax
    307b:	0f 84 53 fc ff ff    	je     2cd4 <submitr+0x2f8>
    3081:	b9 03 00 00 00       	mov    $0x3,%ecx
    3086:	48 8d 3d 89 17 00 00 	lea    0x1789(%rip),%rdi        # 4816 <trans_char+0xc6>
    308d:	48 89 ee             	mov    %rbp,%rsi
    3090:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
    3092:	0f 97 c0             	seta   %al
    3095:	1c 00                	sbb    $0x0,%al
    3097:	0f be c0             	movsbl %al,%eax
    309a:	85 c0                	test   %eax,%eax
    309c:	0f 84 32 fc ff ff    	je     2cd4 <submitr+0x2f8>
    30a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    30a7:	e9 28 fc ff ff       	jmpq   2cd4 <submitr+0x2f8>
    30ac:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    30b3:	3a 20 43 
    30b6:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    30bd:	20 75 6e 
    30c0:	48 89 45 00          	mov    %rax,0x0(%rbp)
    30c4:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    30c8:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    30cf:	74 6f 20 
    30d2:	48 ba 72 65 61 64 20 	movabs $0x6174732064616572,%rdx
    30d9:	73 74 61 
    30dc:	48 89 45 10          	mov    %rax,0x10(%rbp)
    30e0:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    30e4:	48 b8 74 75 73 20 6d 	movabs $0x7373656d20737574,%rax
    30eb:	65 73 73 
    30ee:	48 ba 61 67 65 20 66 	movabs $0x6d6f726620656761,%rdx
    30f5:	72 6f 6d 
    30f8:	48 89 45 20          	mov    %rax,0x20(%rbp)
    30fc:	48 89 55 28          	mov    %rdx,0x28(%rbp)
    3100:	48 b8 20 72 65 73 75 	movabs $0x20746c7573657220,%rax
    3107:	6c 74 20 
    310a:	48 89 45 30          	mov    %rax,0x30(%rbp)
    310e:	c7 45 38 73 65 72 76 	movl   $0x76726573,0x38(%rbp)
    3115:	66 c7 45 3c 65 72    	movw   $0x7265,0x3c(%rbp)
    311b:	c6 45 3e 00          	movb   $0x0,0x3e(%rbp)
    311f:	89 df                	mov    %ebx,%edi
    3121:	e8 da e1 ff ff       	callq  1300 <close@plt>
    3126:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    312b:	e9 a4 fb ff ff       	jmpq   2cd4 <submitr+0x2f8>
    3130:	4c 8d 8c 24 50 80 00 	lea    0x8050(%rsp),%r9
    3137:	00 
    3138:	48 8d 0d 89 16 00 00 	lea    0x1689(%rip),%rcx        # 47c8 <trans_char+0x78>
    313f:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
    3146:	be 01 00 00 00       	mov    $0x1,%esi
    314b:	48 89 ef             	mov    %rbp,%rdi
    314e:	b8 00 00 00 00       	mov    $0x0,%eax
    3153:	e8 e8 e2 ff ff       	callq  1440 <__sprintf_chk@plt>
    3158:	89 df                	mov    %ebx,%edi
    315a:	e8 a1 e1 ff ff       	callq  1300 <close@plt>
    315f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3164:	e9 6b fb ff ff       	jmpq   2cd4 <submitr+0x2f8>
    3169:	e8 52 e1 ff ff       	callq  12c0 <__stack_chk_fail@plt>

000000000000316e <init_timeout>:
    316e:	f3 0f 1e fa          	endbr64 
    3172:	85 ff                	test   %edi,%edi
    3174:	74 26                	je     319c <init_timeout+0x2e>
    3176:	53                   	push   %rbx
    3177:	89 fb                	mov    %edi,%ebx
    3179:	78 1a                	js     3195 <init_timeout+0x27>
    317b:	48 8d 35 8e f5 ff ff 	lea    -0xa72(%rip),%rsi        # 2710 <sigalrm_handler>
    3182:	bf 0e 00 00 00       	mov    $0xe,%edi
    3187:	e8 94 e1 ff ff       	callq  1320 <signal@plt>
    318c:	89 df                	mov    %ebx,%edi
    318e:	e8 5d e1 ff ff       	callq  12f0 <alarm@plt>
    3193:	5b                   	pop    %rbx
    3194:	c3                   	retq   
    3195:	bb 00 00 00 00       	mov    $0x0,%ebx
    319a:	eb df                	jmp    317b <init_timeout+0xd>
    319c:	c3                   	retq   

000000000000319d <init_driver>:
    319d:	f3 0f 1e fa          	endbr64 
    31a1:	41 54                	push   %r12
    31a3:	55                   	push   %rbp
    31a4:	53                   	push   %rbx
    31a5:	48 83 ec 20          	sub    $0x20,%rsp
    31a9:	48 89 fd             	mov    %rdi,%rbp
    31ac:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    31b3:	00 00 
    31b5:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    31ba:	31 c0                	xor    %eax,%eax
    31bc:	be 01 00 00 00       	mov    $0x1,%esi
    31c1:	bf 0d 00 00 00       	mov    $0xd,%edi
    31c6:	e8 55 e1 ff ff       	callq  1320 <signal@plt>
    31cb:	be 01 00 00 00       	mov    $0x1,%esi
    31d0:	bf 1d 00 00 00       	mov    $0x1d,%edi
    31d5:	e8 46 e1 ff ff       	callq  1320 <signal@plt>
    31da:	be 01 00 00 00       	mov    $0x1,%esi
    31df:	bf 1d 00 00 00       	mov    $0x1d,%edi
    31e4:	e8 37 e1 ff ff       	callq  1320 <signal@plt>
    31e9:	ba 00 00 00 00       	mov    $0x0,%edx
    31ee:	be 01 00 00 00       	mov    $0x1,%esi
    31f3:	bf 02 00 00 00       	mov    $0x2,%edi
    31f8:	e8 53 e2 ff ff       	callq  1450 <socket@plt>
    31fd:	85 c0                	test   %eax,%eax
    31ff:	0f 88 9c 00 00 00    	js     32a1 <init_driver+0x104>
    3205:	89 c3                	mov    %eax,%ebx
    3207:	48 8d 3d e7 10 00 00 	lea    0x10e7(%rip),%rdi        # 42f5 <_IO_stdin_used+0x2f5>
    320e:	e8 1d e1 ff ff       	callq  1330 <gethostbyname@plt>
    3213:	48 85 c0             	test   %rax,%rax
    3216:	0f 84 d1 00 00 00    	je     32ed <init_driver+0x150>
    321c:	49 89 e4             	mov    %rsp,%r12
    321f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    3226:	00 
    3227:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    322e:	00 00 
    3230:	66 c7 04 24 02 00    	movw   $0x2,(%rsp)
    3236:	48 63 50 14          	movslq 0x14(%rax),%rdx
    323a:	48 8b 40 18          	mov    0x18(%rax),%rax
    323e:	48 8b 30             	mov    (%rax),%rsi
    3241:	48 8d 7c 24 04       	lea    0x4(%rsp),%rdi
    3246:	b9 0c 00 00 00       	mov    $0xc,%ecx
    324b:	e8 f0 e0 ff ff       	callq  1340 <__memmove_chk@plt>
    3250:	66 c7 44 24 02 3c 9a 	movw   $0x9a3c,0x2(%rsp)
    3257:	ba 10 00 00 00       	mov    $0x10,%edx
    325c:	4c 89 e6             	mov    %r12,%rsi
    325f:	89 df                	mov    %ebx,%edi
    3261:	e8 aa e1 ff ff       	callq  1410 <connect@plt>
    3266:	85 c0                	test   %eax,%eax
    3268:	0f 88 e7 00 00 00    	js     3355 <init_driver+0x1b8>
    326e:	89 df                	mov    %ebx,%edi
    3270:	e8 8b e0 ff ff       	callq  1300 <close@plt>
    3275:	66 c7 45 00 4f 4b    	movw   $0x4b4f,0x0(%rbp)
    327b:	c6 45 02 00          	movb   $0x0,0x2(%rbp)
    327f:	b8 00 00 00 00       	mov    $0x0,%eax
    3284:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    3289:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
    3290:	00 00 
    3292:	0f 85 10 01 00 00    	jne    33a8 <init_driver+0x20b>
    3298:	48 83 c4 20          	add    $0x20,%rsp
    329c:	5b                   	pop    %rbx
    329d:	5d                   	pop    %rbp
    329e:	41 5c                	pop    %r12
    32a0:	c3                   	retq   
    32a1:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
    32a8:	3a 20 43 
    32ab:	48 ba 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rdx
    32b2:	20 75 6e 
    32b5:	48 89 45 00          	mov    %rax,0x0(%rbp)
    32b9:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    32bd:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    32c4:	74 6f 20 
    32c7:	48 ba 63 72 65 61 74 	movabs $0x7320657461657263,%rdx
    32ce:	65 20 73 
    32d1:	48 89 45 10          	mov    %rax,0x10(%rbp)
    32d5:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    32d9:	c7 45 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%rbp)
    32e0:	66 c7 45 24 74 00    	movw   $0x74,0x24(%rbp)
    32e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    32eb:	eb 97                	jmp    3284 <init_driver+0xe7>
    32ed:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
    32f4:	3a 20 44 
    32f7:	48 ba 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rdx
    32fe:	20 75 6e 
    3301:	48 89 45 00          	mov    %rax,0x0(%rbp)
    3305:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    3309:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
    3310:	74 6f 20 
    3313:	48 ba 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rdx
    331a:	76 65 20 
    331d:	48 89 45 10          	mov    %rax,0x10(%rbp)
    3321:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    3325:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
    332c:	72 20 61 
    332f:	48 89 45 20          	mov    %rax,0x20(%rbp)
    3333:	c7 45 28 64 64 72 65 	movl   $0x65726464,0x28(%rbp)
    333a:	66 c7 45 2c 73 73    	movw   $0x7373,0x2c(%rbp)
    3340:	c6 45 2e 00          	movb   $0x0,0x2e(%rbp)
    3344:	89 df                	mov    %ebx,%edi
    3346:	e8 b5 df ff ff       	callq  1300 <close@plt>
    334b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3350:	e9 2f ff ff ff       	jmpq   3284 <init_driver+0xe7>
    3355:	48 b8 45 72 72 6f 72 	movabs $0x55203a726f727245,%rax
    335c:	3a 20 55 
    335f:	48 ba 6e 61 62 6c 65 	movabs $0x6f7420656c62616e,%rdx
    3366:	20 74 6f 
    3369:	48 89 45 00          	mov    %rax,0x0(%rbp)
    336d:	48 89 55 08          	mov    %rdx,0x8(%rbp)
    3371:	48 b8 20 63 6f 6e 6e 	movabs $0x7463656e6e6f6320,%rax
    3378:	65 63 74 
    337b:	48 ba 20 74 6f 20 73 	movabs $0x76726573206f7420,%rdx
    3382:	65 72 76 
    3385:	48 89 45 10          	mov    %rax,0x10(%rbp)
    3389:	48 89 55 18          	mov    %rdx,0x18(%rbp)
    338d:	66 c7 45 20 65 72    	movw   $0x7265,0x20(%rbp)
    3393:	c6 45 22 00          	movb   $0x0,0x22(%rbp)
    3397:	89 df                	mov    %ebx,%edi
    3399:	e8 62 df ff ff       	callq  1300 <close@plt>
    339e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    33a3:	e9 dc fe ff ff       	jmpq   3284 <init_driver+0xe7>
    33a8:	e8 13 df ff ff       	callq  12c0 <__stack_chk_fail@plt>

00000000000033ad <driver_post>:
    33ad:	f3 0f 1e fa          	endbr64 
    33b1:	53                   	push   %rbx
    33b2:	4c 89 cb             	mov    %r9,%rbx
    33b5:	45 85 c0             	test   %r8d,%r8d
    33b8:	75 18                	jne    33d2 <driver_post+0x25>
    33ba:	48 85 ff             	test   %rdi,%rdi
    33bd:	74 05                	je     33c4 <driver_post+0x17>
    33bf:	80 3f 00             	cmpb   $0x0,(%rdi)
    33c2:	75 37                	jne    33fb <driver_post+0x4e>
    33c4:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
    33c9:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
    33cd:	44 89 c0             	mov    %r8d,%eax
    33d0:	5b                   	pop    %rbx
    33d1:	c3                   	retq   
    33d2:	48 89 ca             	mov    %rcx,%rdx
    33d5:	48 8d 35 3d 14 00 00 	lea    0x143d(%rip),%rsi        # 4819 <trans_char+0xc9>
    33dc:	bf 01 00 00 00       	mov    $0x1,%edi
    33e1:	b8 00 00 00 00       	mov    $0x0,%eax
    33e6:	e8 c5 df ff ff       	callq  13b0 <__printf_chk@plt>
    33eb:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
    33f0:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
    33f4:	b8 00 00 00 00       	mov    $0x0,%eax
    33f9:	eb d5                	jmp    33d0 <driver_post+0x23>
    33fb:	48 83 ec 08          	sub    $0x8,%rsp
    33ff:	41 51                	push   %r9
    3401:	49 89 c9             	mov    %rcx,%r9
    3404:	49 89 d0             	mov    %rdx,%r8
    3407:	48 89 f9             	mov    %rdi,%rcx
    340a:	48 89 f2             	mov    %rsi,%rdx
    340d:	be 9a 3c 00 00       	mov    $0x3c9a,%esi
    3412:	48 8d 3d dc 0e 00 00 	lea    0xedc(%rip),%rdi        # 42f5 <_IO_stdin_used+0x2f5>
    3419:	e8 be f5 ff ff       	callq  29dc <submitr>
    341e:	48 83 c4 10          	add    $0x10,%rsp
    3422:	eb ac                	jmp    33d0 <driver_post+0x23>

0000000000003424 <check>:
    3424:	f3 0f 1e fa          	endbr64 
    3428:	89 f8                	mov    %edi,%eax
    342a:	c1 e8 1c             	shr    $0x1c,%eax
    342d:	74 1d                	je     344c <check+0x28>
    342f:	b9 00 00 00 00       	mov    $0x0,%ecx
    3434:	83 f9 1f             	cmp    $0x1f,%ecx
    3437:	7f 0d                	jg     3446 <check+0x22>
    3439:	89 f8                	mov    %edi,%eax
    343b:	d3 e8                	shr    %cl,%eax
    343d:	3c 0a                	cmp    $0xa,%al
    343f:	74 11                	je     3452 <check+0x2e>
    3441:	83 c1 08             	add    $0x8,%ecx
    3444:	eb ee                	jmp    3434 <check+0x10>
    3446:	b8 01 00 00 00       	mov    $0x1,%eax
    344b:	c3                   	retq   
    344c:	b8 00 00 00 00       	mov    $0x0,%eax
    3451:	c3                   	retq   
    3452:	b8 00 00 00 00       	mov    $0x0,%eax
    3457:	c3                   	retq   

0000000000003458 <gencookie>:
    3458:	f3 0f 1e fa          	endbr64 
    345c:	53                   	push   %rbx
    345d:	83 c7 01             	add    $0x1,%edi
    3460:	e8 0b de ff ff       	callq  1270 <srandom@plt>
    3465:	e8 16 df ff ff       	callq  1380 <random@plt>
    346a:	48 89 c7             	mov    %rax,%rdi
    346d:	89 c3                	mov    %eax,%ebx
    346f:	e8 b0 ff ff ff       	callq  3424 <check>
    3474:	85 c0                	test   %eax,%eax
    3476:	74 ed                	je     3465 <gencookie+0xd>
    3478:	89 d8                	mov    %ebx,%eax
    347a:	5b                   	pop    %rbx
    347b:	c3                   	retq   
    347c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000003480 <__libc_csu_init>:
    3480:	f3 0f 1e fa          	endbr64 
    3484:	41 57                	push   %r15
    3486:	4c 8d 3d 2b 38 00 00 	lea    0x382b(%rip),%r15        # 6cb8 <__frame_dummy_init_array_entry>
    348d:	41 56                	push   %r14
    348f:	49 89 d6             	mov    %rdx,%r14
    3492:	41 55                	push   %r13
    3494:	49 89 f5             	mov    %rsi,%r13
    3497:	41 54                	push   %r12
    3499:	41 89 fc             	mov    %edi,%r12d
    349c:	55                   	push   %rbp
    349d:	48 8d 2d 1c 38 00 00 	lea    0x381c(%rip),%rbp        # 6cc0 <__do_global_dtors_aux_fini_array_entry>
    34a4:	53                   	push   %rbx
    34a5:	4c 29 fd             	sub    %r15,%rbp
    34a8:	48 83 ec 08          	sub    $0x8,%rsp
    34ac:	e8 4f db ff ff       	callq  1000 <_init>
    34b1:	48 c1 fd 03          	sar    $0x3,%rbp
    34b5:	74 1f                	je     34d6 <__libc_csu_init+0x56>
    34b7:	31 db                	xor    %ebx,%ebx
    34b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    34c0:	4c 89 f2             	mov    %r14,%rdx
    34c3:	4c 89 ee             	mov    %r13,%rsi
    34c6:	44 89 e7             	mov    %r12d,%edi
    34c9:	41 ff 14 df          	callq  *(%r15,%rbx,8)
    34cd:	48 83 c3 01          	add    $0x1,%rbx
    34d1:	48 39 dd             	cmp    %rbx,%rbp
    34d4:	75 ea                	jne    34c0 <__libc_csu_init+0x40>
    34d6:	48 83 c4 08          	add    $0x8,%rsp
    34da:	5b                   	pop    %rbx
    34db:	5d                   	pop    %rbp
    34dc:	41 5c                	pop    %r12
    34de:	41 5d                	pop    %r13
    34e0:	41 5e                	pop    %r14
    34e2:	41 5f                	pop    %r15
    34e4:	c3                   	retq   
    34e5:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
    34ec:	00 00 00 00 

00000000000034f0 <__libc_csu_fini>:
    34f0:	f3 0f 1e fa          	endbr64 
    34f4:	c3                   	retq   

Disassembly of section .fini:

00000000000034f8 <_fini>:
    34f8:	f3 0f 1e fa          	endbr64 
    34fc:	48 83 ec 08          	sub    $0x8,%rsp
    3500:	48 83 c4 08          	add    $0x8,%rsp
    3504:	c3                   	retq   
