package com.kcc.trioffice.global.enums;

import com.kcc.trioffice.global.exception.type.BadRequestException;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum FileType {

    IMAGE(1),
    FILE(2);

    private final long value;

    public static long toValue(String fileType) {
        switch (fileType) {
            case "IMAGE":
                return IMAGE.value;
            case "FILE":
                return FILE.value;
            default:
                throw new BadRequestException("fileType이 잘못되었습니다.");
        }
    }
}
