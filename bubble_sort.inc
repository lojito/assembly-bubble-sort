swap:
	push ebp
	mov  ebp,esp
	sub esp,dword [ebp + 8]
	
	push eax
	push ebx
	push ecx
	push esi
	push edi
	
; save first element	
	mov ecx,dword [ebp + 8]
	mov esi,dword [ebp + 16]
save:
	mov al,byte[esi]
	mov ebx,ecx
	neg ebx
	mov byte [ebp + ebx],al 
	inc esi
	loop save
	
; update first element
	mov ecx,dword [ebp + 8]
	mov esi,dword [ebp + 12]
	mov edi,dword [ebp + 16]
first_element:
	movsb
	loop first_element
	
; update second element	
	mov ecx,dword [ebp + 8]
	mov edi,dword [ebp + 12]	
second_element:
	mov ebx,ecx
	neg ebx
	mov al,byte [ebp + ebx]
	mov byte[edi],al
	inc edi
	loop second_element

	pop edi
	pop esi
	pop ecx
	pop ebx
	pop eax
	
	add esp,dword [ebp + 8]
	pop ebp

	ret 12
	
; ****************************************************************

; bubblesort(array, number of elements, size of one of the elements, callback)

bubble_sort:
	push ebp
	mov  ebp,esp
	
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	
	xor ebx,ebx
	
outer_loop:
	mov edx,ebx
	inc edx
	
inner_loop:
	mov eax,[ebp + 12]
	push edx
	mul ebx
	mov esi,dword [ebp + 20]
	lea esi,[esi + eax]
	pop edx
	
	mov eax,[ebp + 12]
	push edx
	mul edx
	mov edi,dword [ebp + 20]	
	lea edi,[edi + eax]
	pop edx

	push esi
	push edi	
	call dword [ebp + 8]
	cmp eax,0
	jle is_inner_loop_over
	
	push esi
	push edi
	mov eax,[ebp + 12]
	push eax	
	call swap
	
is_inner_loop_over:	
	inc edx
	cmp edx,dword [ebp + 16]
	jnz inner_loop
	
	inc ebx
	mov ecx,dword [ebp +16]
	dec ecx
	cmp ebx,ecx
	jnz outer_loop
	
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax	
	
	pop ebp
	ret 16
