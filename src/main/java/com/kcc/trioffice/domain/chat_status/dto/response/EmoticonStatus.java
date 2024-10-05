package com.kcc.trioffice.domain.chat_status.dto.response;

import lombok.Data;

@Data
public class EmoticonStatus {

    private int checkEmoticonCount;
    private Boolean isClickedCheckEmoticon;
    private int heartEmoticonCount;
    private Boolean isClickedHeartEmoticon;
    private int thumbsUpEmoticonCount;
    private Boolean isClickedThumbsUpEmoticon;
    private int smileEmoticonCount;
    private Boolean isClickedSmileEmoticon;
    private int sadEmoticonCount;
    private Boolean isClickedSadEmoticon;

}
