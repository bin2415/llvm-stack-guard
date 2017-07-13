
stack_example_llvm：     文件格式 elf64-x86-64


Disassembly of section .init:

0000000000400460 <_init>:
  400460:	48 83 ec 08          	sub    $0x8,%rsp
  400464:	48 8b 05 8d 0b 20 00 	mov    0x200b8d(%rip),%rax        # 600ff8 <_DYNAMIC+0x1d0>
  40046b:	48 85 c0             	test   %rax,%rax
  40046e:	74 05                	je     400475 <_init+0x15>
  400470:	e8 5b 00 00 00       	callq  4004d0 <gets@plt+0x10>
  400475:	48 83 c4 08          	add    $0x8,%rsp
  400479:	c3                   	retq   

Disassembly of section .plt:

0000000000400480 <puts@plt-0x10>:
  400480:	ff 35 82 0b 20 00    	pushq  0x200b82(%rip)        # 601008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400486:	ff 25 84 0b 20 00    	jmpq   *0x200b84(%rip)        # 601010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40048c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400490 <puts@plt>:
  400490:	ff 25 82 0b 20 00    	jmpq   *0x200b82(%rip)        # 601018 <_GLOBAL_OFFSET_TABLE_+0x18>
  400496:	68 00 00 00 00       	pushq  $0x0
  40049b:	e9 e0 ff ff ff       	jmpq   400480 <_init+0x20>

00000000004004a0 <__stack_chk_fail@plt>:
  4004a0:	ff 25 7a 0b 20 00    	jmpq   *0x200b7a(%rip)        # 601020 <_GLOBAL_OFFSET_TABLE_+0x20>
  4004a6:	68 01 00 00 00       	pushq  $0x1
  4004ab:	e9 d0 ff ff ff       	jmpq   400480 <_init+0x20>

00000000004004b0 <__libc_start_main@plt>:
  4004b0:	ff 25 72 0b 20 00    	jmpq   *0x200b72(%rip)        # 601028 <_GLOBAL_OFFSET_TABLE_+0x28>
  4004b6:	68 02 00 00 00       	pushq  $0x2
  4004bb:	e9 c0 ff ff ff       	jmpq   400480 <_init+0x20>

00000000004004c0 <gets@plt>:
  4004c0:	ff 25 6a 0b 20 00    	jmpq   *0x200b6a(%rip)        # 601030 <_GLOBAL_OFFSET_TABLE_+0x30>
  4004c6:	68 03 00 00 00       	pushq  $0x3
  4004cb:	e9 b0 ff ff ff       	jmpq   400480 <_init+0x20>

Disassembly of section .plt.got:

00000000004004d0 <.plt.got>:
  4004d0:	ff 25 22 0b 20 00    	jmpq   *0x200b22(%rip)        # 600ff8 <_DYNAMIC+0x1d0>
  4004d6:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

00000000004004e0 <_start>:
  4004e0:	31 ed                	xor    %ebp,%ebp
  4004e2:	49 89 d1             	mov    %rdx,%r9
  4004e5:	5e                   	pop    %rsi
  4004e6:	48 89 e2             	mov    %rsp,%rdx
  4004e9:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4004ed:	50                   	push   %rax
  4004ee:	54                   	push   %rsp
  4004ef:	49 c7 c0 10 07 40 00 	mov    $0x400710,%r8
  4004f6:	48 c7 c1 a0 06 40 00 	mov    $0x4006a0,%rcx
  4004fd:	48 c7 c7 70 06 40 00 	mov    $0x400670,%rdi
  400504:	e8 a7 ff ff ff       	callq  4004b0 <__libc_start_main@plt>
  400509:	f4                   	hlt    
  40050a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400510 <deregister_tm_clones>:
  400510:	b8 4f 10 60 00       	mov    $0x60104f,%eax
  400515:	55                   	push   %rbp
  400516:	48 2d 48 10 60 00    	sub    $0x601048,%rax
  40051c:	48 83 f8 0e          	cmp    $0xe,%rax
  400520:	48 89 e5             	mov    %rsp,%rbp
  400523:	76 1b                	jbe    400540 <deregister_tm_clones+0x30>
  400525:	b8 00 00 00 00       	mov    $0x0,%eax
  40052a:	48 85 c0             	test   %rax,%rax
  40052d:	74 11                	je     400540 <deregister_tm_clones+0x30>
  40052f:	5d                   	pop    %rbp
  400530:	bf 48 10 60 00       	mov    $0x601048,%edi
  400535:	ff e0                	jmpq   *%rax
  400537:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40053e:	00 00 
  400540:	5d                   	pop    %rbp
  400541:	c3                   	retq   
  400542:	0f 1f 40 00          	nopl   0x0(%rax)
  400546:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40054d:	00 00 00 

0000000000400550 <register_tm_clones>:
  400550:	be 48 10 60 00       	mov    $0x601048,%esi
  400555:	55                   	push   %rbp
  400556:	48 81 ee 48 10 60 00 	sub    $0x601048,%rsi
  40055d:	48 c1 fe 03          	sar    $0x3,%rsi
  400561:	48 89 e5             	mov    %rsp,%rbp
  400564:	48 89 f0             	mov    %rsi,%rax
  400567:	48 c1 e8 3f          	shr    $0x3f,%rax
  40056b:	48 01 c6             	add    %rax,%rsi
  40056e:	48 d1 fe             	sar    %rsi
  400571:	74 15                	je     400588 <register_tm_clones+0x38>
  400573:	b8 00 00 00 00       	mov    $0x0,%eax
  400578:	48 85 c0             	test   %rax,%rax
  40057b:	74 0b                	je     400588 <register_tm_clones+0x38>
  40057d:	5d                   	pop    %rbp
  40057e:	bf 48 10 60 00       	mov    $0x601048,%edi
  400583:	ff e0                	jmpq   *%rax
  400585:	0f 1f 00             	nopl   (%rax)
  400588:	5d                   	pop    %rbp
  400589:	c3                   	retq   
  40058a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400590 <__do_global_dtors_aux>:
  400590:	80 3d b1 0a 20 00 00 	cmpb   $0x0,0x200ab1(%rip)        # 601048 <__TMC_END__>
  400597:	75 11                	jne    4005aa <__do_global_dtors_aux+0x1a>
  400599:	55                   	push   %rbp
  40059a:	48 89 e5             	mov    %rsp,%rbp
  40059d:	e8 6e ff ff ff       	callq  400510 <deregister_tm_clones>
  4005a2:	5d                   	pop    %rbp
  4005a3:	c6 05 9e 0a 20 00 01 	movb   $0x1,0x200a9e(%rip)        # 601048 <__TMC_END__>
  4005aa:	f3 c3                	repz retq 
  4005ac:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004005b0 <frame_dummy>:
  4005b0:	bf 20 0e 60 00       	mov    $0x600e20,%edi
  4005b5:	48 83 3f 00          	cmpq   $0x0,(%rdi)
  4005b9:	75 05                	jne    4005c0 <frame_dummy+0x10>
  4005bb:	eb 93                	jmp    400550 <register_tm_clones>
  4005bd:	0f 1f 00             	nopl   (%rax)
  4005c0:	b8 00 00 00 00       	mov    $0x0,%eax
  4005c5:	48 85 c0             	test   %rax,%rax
  4005c8:	74 f1                	je     4005bb <frame_dummy+0xb>
  4005ca:	55                   	push   %rbp
  4005cb:	48 89 e5             	mov    %rsp,%rbp
  4005ce:	ff d0                	callq  *%rax
  4005d0:	5d                   	pop    %rbp
  4005d1:	e9 7a ff ff ff       	jmpq   400550 <register_tm_clones>
  4005d6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4005dd:	00 00 00 

00000000004005e0 <success>:
  4005e0:	55                   	push   %rbp
  4005e1:	48 89 e5             	mov    %rsp,%rbp
  4005e4:	48 83 ec 10          	sub    $0x10,%rsp
  4005e8:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  4005ef:	00 00 
  4005f1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  4005f5:	bf 24 07 40 00       	mov    $0x400724,%edi
  4005fa:	e8 91 fe ff ff       	callq  400490 <puts@plt>
  4005ff:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  400606:	00 00 
  400608:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
  40060c:	75 06                	jne    400614 <success+0x34>
  40060e:	48 83 c4 10          	add    $0x10,%rsp
  400612:	5d                   	pop    %rbp
  400613:	c3                   	retq   
  400614:	e8 87 fe ff ff       	callq  4004a0 <__stack_chk_fail@plt>
  400619:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000400620 <vulnerable>:
  400620:	55                   	push   %rbp
  400621:	48 89 e5             	mov    %rsp,%rbp
  400624:	53                   	push   %rbx
  400625:	48 83 ec 18          	sub    $0x18,%rsp
  400629:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  400630:	00 00 
  400632:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  400636:	48 8d 5d e4          	lea    -0x1c(%rbp),%rbx
  40063a:	31 c0                	xor    %eax,%eax
  40063c:	48 89 df             	mov    %rbx,%rdi
  40063f:	e8 7c fe ff ff       	callq  4004c0 <gets@plt>
  400644:	48 89 df             	mov    %rbx,%rdi
  400647:	e8 44 fe ff ff       	callq  400490 <puts@plt>
  40064c:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  400653:	00 00 
  400655:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  400659:	75 07                	jne    400662 <vulnerable+0x42>
  40065b:	48 83 c4 18          	add    $0x18,%rsp
  40065f:	5b                   	pop    %rbx
  400660:	5d                   	pop    %rbp
  400661:	c3                   	retq   
  400662:	e8 39 fe ff ff       	callq  4004a0 <__stack_chk_fail@plt>
  400667:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40066e:	00 00 

0000000000400670 <main>:
  400670:	55                   	push   %rbp
  400671:	48 89 e5             	mov    %rsp,%rbp
  400674:	48 83 ec 10          	sub    $0x10,%rsp
  400678:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  40067f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  400682:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  400686:	e8 95 ff ff ff       	callq  400620 <vulnerable>
  40068b:	31 c0                	xor    %eax,%eax
  40068d:	48 83 c4 10          	add    $0x10,%rsp
  400691:	5d                   	pop    %rbp
  400692:	c3                   	retq   
  400693:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40069a:	00 00 00 
  40069d:	0f 1f 00             	nopl   (%rax)

00000000004006a0 <__libc_csu_init>:
  4006a0:	41 57                	push   %r15
  4006a2:	41 56                	push   %r14
  4006a4:	41 89 ff             	mov    %edi,%r15d
  4006a7:	41 55                	push   %r13
  4006a9:	41 54                	push   %r12
  4006ab:	4c 8d 25 5e 07 20 00 	lea    0x20075e(%rip),%r12        # 600e10 <__frame_dummy_init_array_entry>
  4006b2:	55                   	push   %rbp
  4006b3:	48 8d 2d 5e 07 20 00 	lea    0x20075e(%rip),%rbp        # 600e18 <__init_array_end>
  4006ba:	53                   	push   %rbx
  4006bb:	49 89 f6             	mov    %rsi,%r14
  4006be:	49 89 d5             	mov    %rdx,%r13
  4006c1:	4c 29 e5             	sub    %r12,%rbp
  4006c4:	48 83 ec 08          	sub    $0x8,%rsp
  4006c8:	48 c1 fd 03          	sar    $0x3,%rbp
  4006cc:	e8 8f fd ff ff       	callq  400460 <_init>
  4006d1:	48 85 ed             	test   %rbp,%rbp
  4006d4:	74 20                	je     4006f6 <__libc_csu_init+0x56>
  4006d6:	31 db                	xor    %ebx,%ebx
  4006d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4006df:	00 
  4006e0:	4c 89 ea             	mov    %r13,%rdx
  4006e3:	4c 89 f6             	mov    %r14,%rsi
  4006e6:	44 89 ff             	mov    %r15d,%edi
  4006e9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  4006ed:	48 83 c3 01          	add    $0x1,%rbx
  4006f1:	48 39 eb             	cmp    %rbp,%rbx
  4006f4:	75 ea                	jne    4006e0 <__libc_csu_init+0x40>
  4006f6:	48 83 c4 08          	add    $0x8,%rsp
  4006fa:	5b                   	pop    %rbx
  4006fb:	5d                   	pop    %rbp
  4006fc:	41 5c                	pop    %r12
  4006fe:	41 5d                	pop    %r13
  400700:	41 5e                	pop    %r14
  400702:	41 5f                	pop    %r15
  400704:	c3                   	retq   
  400705:	90                   	nop
  400706:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40070d:	00 00 00 

0000000000400710 <__libc_csu_fini>:
  400710:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000400714 <_fini>:
  400714:	48 83 ec 08          	sub    $0x8,%rsp
  400718:	48 83 c4 08          	add    $0x8,%rsp
  40071c:	c3                   	retq   
