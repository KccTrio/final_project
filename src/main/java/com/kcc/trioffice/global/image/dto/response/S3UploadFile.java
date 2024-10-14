package com.kcc.trioffice.global.image.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class S3UploadFile {

    private String fileName;
    private String fileUrl;
    private String fileExtension;
    private Long fileSize;
    private Long fileType;
    private Long fileId;
}
