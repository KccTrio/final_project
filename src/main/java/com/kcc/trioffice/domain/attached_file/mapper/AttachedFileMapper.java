package com.kcc.trioffice.domain.attached_file.mapper;

import com.kcc.trioffice.domain.attached_file.dto.response.AttachedFileInfo;
import com.kcc.trioffice.domain.attached_file.dto.response.ImageInfo;
import com.kcc.trioffice.global.image.dto.response.S3UploadFile;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface AttachedFileMapper {

    int saveAttachedFile(@Param("chatId") Long chatId, @Param("employeeId") Long employeeId, @Param("s3UploadFile") S3UploadFile s3UploadFile);
    Optional<S3UploadFile> getAttachedFileByChatId(@Param("chatId") Long chatId);
    List<AttachedFileInfo> getAttachedFile(@Param("chatRoomId") Long chatRoomId, @Param("limit") int limit, @Param("offset") int offset, String searchType, List<String> tags);
    List<ImageInfo> getImages(Long chatRoomId, String searchType, List<String> tags);
    Optional<S3UploadFile> getAttachedFileByFileId(@Param("fileId") Long fileId);
}
