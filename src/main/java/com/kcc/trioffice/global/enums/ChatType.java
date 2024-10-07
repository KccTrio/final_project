package com.kcc.trioffice.global.enums;

import com.kcc.trioffice.global.exception.type.BadRequestException;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum ChatType {
    ENTER(1), CHAT(2), FILE(3), EXIT(4);

    private final long value;

    public static long toValue(String chatType) {
        switch (chatType) {
            case "ENTER":
                return ENTER.value;
            case "CHAT":
                return CHAT.value;
            case "FILE":
                return FILE.value;
            case "EXIT":
                return EXIT.value;
            default:
                throw new BadRequestException("chatType이 잘못되었습니다.");
        }
    }

    public static String toName(long chatType) {
        switch ((int) chatType) {
            case 1:
                return ENTER.name();
            case 2:
                return CHAT.name();
            case 3:
                return FILE.name();
            case 4:
                return EXIT.name();
            default:
                throw new BadRequestException("chatType이 잘못되었습니다.");
        }
    }
}
