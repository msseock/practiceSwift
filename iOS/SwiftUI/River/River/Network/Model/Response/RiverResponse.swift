//
//  RiverResponse.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

struct RiverResponse: Decodable {
    /// 수위계코드
    let waterGaugeCode: String

    /// 수위계명
    let waterGaugeName: String

    /// 하천명
    let riverName: String

    /// 구청코드
    let districtCode: String

    /// 구청명
    let districtName: String

    /// 송신지 자료수집 시각
    let collectTime: String

    /// 수신서버 저장 시각
    let serverStoredTime: String

    /// 실시간 하천 수위값(m)
    let realTimeWaterLevel: Double

    /// 제방고(m)
    let leveeHeight: Double

    /// 계획홍수위(m)
    let planFloodLevel: Double

    /// 하상고(m)
    let riverBedHeight: Double

    /// 통제수위(m)
    let controlWaterLevel: Double

    enum CodingKeys: String, CodingKey {
        case waterGaugeCode = "WATG_CD"
        case waterGaugeName = "WATG_NM"
        case riverName = "RVR_NM"
        case districtCode = "STDG_SGG_CD"
        case districtName = "GU_OFC_NM"
        case collectTime = "DTRSM_DATA_CLCT_TM"
        case serverStoredTime = "RCPTN_SRVR_STRG_TM"
        case realTimeWaterLevel = "RLTM_RVR_WATL_CNT"
        case leveeHeight = "EBM_HGT"
        case planFloodLevel = "PLAN_FLDE"
        case riverBedHeight = "RBH"
        case controlWaterLevel = "CNTRL_WATL"
    }
}
