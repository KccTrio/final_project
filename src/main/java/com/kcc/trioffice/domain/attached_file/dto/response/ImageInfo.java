package com.kcc.trioffice.domain.attached_file.dto.response;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class ImageInfo {

    private Long chatId;
    private Long fileId;
    private String fileName;
    private String fileUrl;
    List<String> tags;

    public void setTags(String tags) {
        if (tags == null) {
            this.tags = new ArrayList<>();

            return;
        }
        this.tags = List.of(tags.split(","));
    }
}
