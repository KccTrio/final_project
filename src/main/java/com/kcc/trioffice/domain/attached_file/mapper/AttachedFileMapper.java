package com.kcc.trioffice.domain.attached_file.mapper;

import com.kcc.trioffice.global.image.dto.response.S3UploadFile;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Optional;

@Mapper
public interface AttachedFileMapper {

    int saveAttachedFile(@Param("chatId") Long chatId, @Param("employeeId") Long employeeId, @Param("s3UploadFile") S3UploadFile s3UploadFile);
    Optional<S3UploadFile> getAttachedFileByChatId(@Param("chatId") Long chatId);
}
