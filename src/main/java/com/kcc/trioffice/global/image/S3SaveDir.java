package com.kcc.trioffice.global.image;

import com.kcc.trioffice.global.exception.type.BadRequestException;
import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum S3SaveDir {

    CHAT("/chat"),
    PROFILE("/profile");

    public final String path;

    public static S3SaveDir toEnum(String stringParam) {
        return switch (stringParam.toLowerCase()) {
            case "chat" -> CHAT;
            case "profile" -> PROFILE;

            default -> throw new BadRequestException("Invalid S3SaveDir");
        };
    }
}
