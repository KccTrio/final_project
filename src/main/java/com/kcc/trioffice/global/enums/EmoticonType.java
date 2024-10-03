package com.kcc.trioffice.global.enums;

import com.kcc.trioffice.global.exception.type.BadRequestException;
import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum EmoticonType {
    CHECK(1),
    HEART(2),
    THUMBS_UP(3),
    SMILE(4),
    SAD(5);

    private final long value;

    public static long toValue(String emoticonType) {
        switch (emoticonType) {
            case "CHECK":
                return CHECK.value;
            case "HEART":
                return HEART.value;
            case "THUMBS_UP":
                return THUMBS_UP.value;
            case "SMILE":
                return SMILE.value;
            case "SAD":
                return SAD.value;
            default:
                throw new BadRequestException("emoticonType이 잘못되었습니다.");
        }
    }
}
