#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

uint64_t __llvm_profile_get_size_for_buffer(void);
int __llvm_profile_write_buffer(char *Buffer);

void dump() {
    FILE *fd = fopen("manual.profraw", "w");
    uint64_t size = __llvm_profile_get_size_for_buffer();
    char *buffer = (char *)malloc(size);
    __llvm_profile_write_buffer(buffer);
    fwrite(buffer, 1, size, fd);
    fclose(fd);
    free(buffer);
}

int main() {
    int a = 1, b = 2;
    if ( a && b ) {
        dump();
        return 3;
    }
    dump();
    return 4;
}
