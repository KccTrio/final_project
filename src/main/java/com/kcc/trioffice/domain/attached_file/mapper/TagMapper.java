package com.kcc.trioffice.domain.attached_file.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TagMapper {

    int saveTag(Long fileId, String tagName, Long employeeId);
}
