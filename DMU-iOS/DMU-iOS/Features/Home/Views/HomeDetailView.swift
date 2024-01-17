//
//  HomeDetailView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/10/24.
//

import SwiftUI

// MARK: -메인 HomeDetailView
struct HomeDetailView: View {
    
    let detailNotice: Notice
    let homeDetailViewNavigationBarTitle: String
    let viewModel: NoticeViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading) {
            DetailNoticeScrollView(detailNotice: detailNotice, homeDetailViewNavigationBarTitle: homeDetailViewNavigationBarTitle, viewModel: viewModel, presentationMode: presentationMode)
        }
    }
}

// MARK: -공지사항 디테일 뷰 스크롤 화면
struct DetailNoticeScrollView: View {
    
    let detailNotice: Notice
    let homeDetailViewNavigationBarTitle: String
    let viewModel: NoticeViewModel
    let presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                NoticeKeywordAndButtonStack(detailNotice: detailNotice)
                
                NoticeTitleText(detailNotice: detailNotice)
                
                NoticeStaffNameAndDateStack(detailNotice: detailNotice, viewModel: viewModel)
                
                NoticeDetail(detailNotice: detailNotice)
                
                NoticeFileAttachment()
            }
            .padding(20)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(homeDetailViewNavigationBarTitle, displayMode: .inline)
            .navigationBarItems(leading: BackButton(presentationMode: presentationMode))
        }
    }
}

// MARK: -키워드 뷰, 공유하기 버튼
struct NoticeKeywordAndButtonStack: View {
    
    let detailNotice: Notice
    
    var body: some View {
        HStack {
            Text(detailNotice.noticeKeyword)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .font(.SemiBold14)
                .background(Color.Blue300)
                .cornerRadius(30)
                .foregroundColor(Color.white)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.Blue300)
            }
        }
    }
}

// MARK: -공지사항 제목 텍스트
struct NoticeTitleText: View {
    
    let detailNotice: Notice
    
    var body: some View {
        Text(detailNotice.noticeTitle)
            .font(.SemiBold20)
            .foregroundColor(Color.Gray600)
            .padding(.top, 12)
    }
}

// MARK: -공지사항 직원명, 날짜
struct NoticeStaffNameAndDateStack: View {
    
    let detailNotice: Notice
    let viewModel: NoticeViewModel
    
    var body: some View {
        HStack {
            Text(detailNotice.noticeStaffName)
                .font(.Medium14)
                .foregroundColor(Color.Gray400)
                .padding(.trailing, 8)
            
            Divider()
                .background(Color.Gray400)
            
            Text(viewModel.formatDate(detailNotice.noticeDate))
                .font(.Medium14)
                .foregroundColor(Color.Gray400)
                .padding(.leading, 8)
        }
        .padding(.vertical, 4)
        
        Divider()
            .background(Color.Gray300)
            .padding(.top, 4)
    }
}

// MARK: -공지사항 디테일 뷰
struct NoticeDetail: View {
    
    let detailNotice: Notice
    
    var body: some View {
        Text(detailNotice.noticeDetail)
            .padding(.top)
            .font(.Medium16)
            .foregroundColor(Color.Gray500)
        
        Divider()
            .background(Color.Gray300)
            .padding(.vertical, 20)
    }
}

// MARK: -공지사항 첨부파일
struct NoticeFileAttachment: View {
    
    var body: some View {
        HStack {
            Text("첨부파일")
                .font(.Medium16)
                .foregroundColor(Color.Blue400)
            
            Image(systemName: "folder.circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(Color.Blue400)
        }
        .padding(8)
        .background(Color.Blue100)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.Blue300, lineWidth: 1)
        )
    }
}

// MARK: -뒤로 가기 버튼
struct BackButton: View {
    
    let presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color.Blue300)
        }
    }
}

// MARK: -HomeDetailView 미리보기
#Preview {
    HomeDetailView(detailNotice: Notice(noticeTitle: "2023년 하반기 울산광역시 대학생 학자금대출 이자지원사업 안내", noticeDate: Date(), noticeStaffName: "박은정", noticeDetail: "1. 사 업 명 : 2023년 하반기 울산광역시 대학생 학자금대출 이자지원 \n2. 지원대상 (아래 조건에 모두 해당하는 자) \n○ 2017년 이후 한국장학재단의 학자금대출을 받은 자 \n○ 공고일 기준 대학생 본인 혹은 직계존속(부모 또는 (외)조부모)의 주민등록상 주소가 울산이며, 전국 소재 대학교에 재학(휴학) 중인 자 【 주의사항 】 \n▪ 대학원생, 졸업생은 지원 대상이 아님 \n▪ 휴학생은 휴학기간(군복무로 인한 휴학기간은 제외)이 6학기 이하이어야 함 \n▪ 타 지자체, 기관 등과 중복지원 불가 \n▪ 한국장학재단 홈페이지를 통하여 본인의 대출 잔액 또는 이자 면제 여부 확인 후 신청 \n▪ 학자금 지원구간(소득분위)이 확인되지 않을 경우, 최근 학자금 지원구간으로 대체하여 심사할 수 있음 \n▪ 공고일 기준 대출금 전액 상환자는 지원제외 \n3. 지원내용 ○ 2017년 이후 한국장학재단으로부터 신규대출 받은 「취업 후 상환 학자금대출」 및 「일반 상환 학자금대출」의 2023년 하반기(2023. 7. 1.~ 12. 31.)에 발생한 본인 부담 이자액 ※ 신청접수 결과, 이자지원 대상액이 예산 초과 시 「울산광역시 대학생 학자금대출 이자지원에 관한 조례」 제4조의2(지원 우선순위)에 따라 지원할 수 있음. \n4. 신청기간 : 2024. 1. 11.(목) 09:00 ～ 2. 16.(금) 18:00 \n5. 접 수 처 : 시 홈페이지 (www.ulsan.go.kr) → 분야별정보 → 행정 → 인재교육 → 교육지원 → 대학생 학자금대출 이자지원 메뉴 \n6. 구비서류 (모든 제출서류는 주민등록번호 뒷자리(6자리) 가려서 발급 및 제출) \n① 신청서 : 홈페이지 신청 메뉴에서 작성 후 제출 - 이자지원용 신청서 및 개인정보 제공동의서 각 1부 \n② 증빙서류 : 스캔 또는 촬영본 첨부파일 등록 구 분 증빙서류 본인의 주민등록상 주소지가 울산인 경우 \n① 공고일(‘24.1.11.) 이후 발급한 본인 주민등록등본 또는 초본 1부 \n② 2023년 2학기 대학교 재학(휴학)증명서 1부 직계존속*의 주민등록상 주소지가 울산인 경우 (*부모 또는 (외)조부모) \n① 공고일(‘24.1.11.) 이후 발급한 직계존속 주민등록등본 또는 초본 1부 \n② 2023년 2학기 대학교 재학(휴학)증명서 1부 \n③ 가족관계증명서(본인 또는 부모 기준*) 1부 * 직계존속 관계 확인용 ※ 서류제출 시 주의사항 ★ 모든 제출서류의 주민등록번호 뒷자리는 가려서 발급 및 제출 ★ 주민등록등(초)본은 공고일(‘24.1.11.) 이후 발급분만 인정 ★ 구비서류는 지원자격 요건을 확인하기 위함이며, 신청서와 구비서류의 기재착오, 누락, 착오 제출, 내용식별 불가능 등으로 인한 불이익의 책임은 신청자 본인에게 있음 \n7. 이자지원 방법 \n○ 2023년 하반기분 발생이자 금액을 2024. 6월 내에 한국장학재단을 통해 각 대출계좌별 원리금에 상환 처리 \n※ 본인 대출에 상환처리 하는 것이 원칙(개인별 은행계좌로 입금 X), 타 지자체 이자지원과 중복 불가 \n8. 지원결과확인 \n○ 한국장학재단 홈페이지 → 로그인 → 학자금대출 → 학자금뱅킹 → 학자금대출 상환 → 대출내역 → 해당 대출계좌번호 클릭 확인(비고란에‘지자체 이자지원’으로 표기) 9. 참고사항 ○ 제출서류가 사실과 다르거나 지원금 지급이 불가능한 경우 최종 지원대상에서 제외되거나, 기타 법률상 환수 사유 발생 시 이미 지급된 지원금도 환수할 수 있음. \n10. 문의처 \n○ 이자지원 사업관련 : 울산시 콜센터(052-120), 대학청년지원단(052-229-7992) \n○ 학자금대출 관련 : 한국장학재단 콜센터(1599–2000)", noticeKeyword: "장학", noticeType: "대학공지"), homeDetailViewNavigationBarTitle: "대학공지", viewModel: NoticeViewModel(userSettings: UserSettings()))
}

