TITLE Number Guessing Game 
; gonna use basic concepts

INCLUDE Irvine32.inc

.data
    ; do defining Data (Strings and Variables)
    welcomeMsg  BYTE "===== NUMBER GUESSING GAME =====", 0dh, 0ah
                BYTE "I'm thinking of a number 1-100", 0dh, 0ah
                BYTE "Can you guess it?", 0dh, 0ah, 0
    
    promptMsg   BYTE 0dh, 0ah, "Enter your guess: ", 0
    tooHighMsg  BYTE "Too HIGH! Try again.", 0dh, 0ah, 0
    tooLowMsg   BYTE "Too LOW! Try again.", 0dh, 0ah, 0
    winMsg      BYTE 0dh, 0ah, "YOU WIN! Great job!", 0dh, 0ah, 0
    triesMsg    BYTE "Number of tries: ", 0
    
    ; DWORD Variables
    secretNum   DWORD ?
    userGuess   DWORD ?
    numTries    DWORD 0

.code
main PROC
    ; procedures
    
    call Randomize              ; do initialize random seed
    
    ; Generate random number 1-100
    ; random numbers
    mov eax, 100
    call RandomRange            ; Returns 0-99
    inc eax                     ; INC makes it 1-100
    mov secretNum, eax
    
    ; Display welcome
    ; use irvine32 Library - WriteString
    mov edx, OFFSET welcomeMsg  ; OFFSET Operator
    call WriteString
    call Crlf
    
GuessLoop:
    ; WHILE Loop structure
    
    ; Prompt for guess
    mov edx, OFFSET promptMsg
    call WriteString
    
    ; Read user input
    ; ReadInt reads integer
    call ReadInt                ; Result in EAX
    mov userGuess, eax
    
    ; Count this try
    ; ADD Instruction
    inc numTries
    
    ; compare guess with secret
    ; CMP Instruction
    mov eax, userGuess
    cmp eax, secretNum
    je  Winner                  ; JE Jump if Equal
    jg  TooHigh                 ; JG Jump if Greater
    jl  TooLow                  ; Jump if Less
    
TooHigh:
    mov edx, OFFSET tooHighMsg
    call WriteString
    jmp GuessLoop               ; JMP Instruction
    
TooLow:
    mov edx, OFFSET tooLowMsg
    call WriteString
    jmp GuessLoop
    
Winner:
    ; Player won!
    mov edx, OFFSET winMsg
    call WriteString
    
    ; Show number of tries
    mov edx, OFFSET triesMsg
    call WriteString
    mov eax, numTries
    call WriteDec               ; writeDec displays decimal
    call Crlf
    
    exit                        ; do exit program
main ENDP

END main
