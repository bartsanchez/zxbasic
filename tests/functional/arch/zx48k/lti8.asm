	org 32768
.core.__START_PROGRAM:
	di
	push ix
	push iy
	exx
	push hl
	exx
	ld hl, 0
	add hl, sp
	ld (.core.__CALL_BACK__), hl
	ei
	jp .core.__MAIN_PROGRAM__
.core.__CALL_BACK__:
	DEFW 0
.core.ZXBASIC_USER_DATA:
	; Defines USER DATA Length in bytes
.core.ZXBASIC_USER_DATA_LEN EQU .core.ZXBASIC_USER_DATA_END - .core.ZXBASIC_USER_DATA
	.core.__LABEL__.ZXBASIC_USER_DATA_LEN EQU .core.ZXBASIC_USER_DATA_LEN
	.core.__LABEL__.ZXBASIC_USER_DATA EQU .core.ZXBASIC_USER_DATA
_level:
	DEFB 01h
_le:
	DEFB 00h
_l:
	DEFB 00
.core.ZXBASIC_USER_DATA_END:
.core.__MAIN_PROGRAM__:
	ld a, (_level)
	ld h, a
	ld a, (_le)
	call .core.__LTI8
	ld (_l), a
	ld hl, (_level - 1)
	ld a, (_le)
	call .core.__LTI8
	ld (_l), a
	ld a, (_le)
	push af
	ld hl, (_level - 1)
	pop af
	call .core.__LTI8
	ld (_l), a
	ld a, (_le)
	ld hl, (_level - 1)
	call .core.__LTI8
	ld (_l), a
	ld a, (_level)
	ld h, a
	xor a
	call .core.__LTI8
	ld (_l), a
	ld hl, 0
	ld b, h
	ld c, l
.core.__END_PROGRAM:
	di
	ld hl, (.core.__CALL_BACK__)
	ld sp, hl
	exx
	pop hl
	exx
	pop iy
	pop ix
	ei
	ret
	;; --- end of user code ---
#line 1 "/zxbasic/src/lib/arch/zx48k/runtime/lti8.asm"
#line 1 "/zxbasic/src/lib/arch/zx48k/runtime/cmp/lei8.asm"
	    push namespace core
__LEI8: ; Signed <= comparison for 8bit int
	    ; A <= H (registers)
	    PROC
	    LOCAL checkParity
	    sub h
	    jr nz, __LTI
	    inc a
	    ret
__LTI8:  ; Test 8 bit values A < H
	    sub h
__LTI:   ; Generic signed comparison
	    jp po, checkParity
	    xor 0x80
checkParity:
	    ld a, 0     ; False
	    ret p
	    inc a       ; True
	    ret
	    ENDP
	    pop namespace
#line 2 "/zxbasic/src/lib/arch/zx48k/runtime/lti8.asm"
#line 41 "arch/zx48k/lti8.bas"
	END
