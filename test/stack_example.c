/*************************************************************************
	> File Name: stack_example.c
	> Author: binpang 
	> Mail: 
	> Created Time: 2017年07月13日 星期四 19时12分59秒
 ************************************************************************/

#include<stdio.h>
#include<string.h>
void success() {puts("You have already controlled it.");}

void vulnerable(){
    char s[12];
    gets(s);
    puts(s);
    return;
}
int main(int argc, char **argv){
    vulnerable();
    return 0;
}
