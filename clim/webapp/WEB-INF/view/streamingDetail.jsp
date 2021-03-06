<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>스트리밍 디테일</title>
<c:import url="/WEB-INF/template/link.jsp" />
<link rel="stylesheet"
	href="https://releases.flowplayer.org/5.4.6/skin/functional.css">
<link href="https://vjs.zencdn.net/7.6.0/video-js.css" rel="stylesheet" />
<script src='https://vjs.zencdn.net/7.6.0/video.js'></script>
<link rel="stylesheet" href="/css/streamingDetail.css" />
<style>

	.subscribe_on{
		color:red;
	}
	body{
	background-color: #424242;
	}

</style>
</head>


<body>


	<div id="streamingDetailVideoSection">
		<div id="streamingBg">
			<div id="streamingReportPopup">
				<div id="streamingReportName">${leader.nickname }신고하기</div>
				<button id="streamingCloseBtn">
					<i class="fas fa-times-circle"></i>
				</button>

				<div id="reportForm">

					<textarea id="streamingReportContent"></textarea>
					<button id="streamingReportBtn">신고</button>

				</div>
			</div>
		</div>
		<div id="streamingDetailSlideBar">
			<div>
				<ul id="streamingDetailTopTab">
					<li class="streamingDetail_tab on">
						<h3>정보</h3>
					</li>
					<li class="streamingDetail_tab">
						<h3>채팅</h3>
					</li>
					<li class="streamingDetail_tab">
						<h3>끌림들</h3>
					</li>
				</ul>

			</div>

			<div id="streamingDetailTopWarp">

				<div id="streamingDetailInfo"
					class="streamingDetail_tab_contents on">
					<div id="streamingDetailStreamerName">
					<a href="/user/${leader.no}">
						<i class="fas fa-crown"></i>${leader.nickname }</a></div>
					<button class="streamingDetail_info_btn ${loginMember!=null && subCheck==1 ? 'subscribe_on' : '' }"
						id="streamingDetailSubscribeBtn">
						<i class="far fa-lightbulb"></i>
					</button>
					<button class="streamingDetail_info_btn"
						id="streamingDetailReportBtn">
						<i class="fas fa-exclamation"></i>
					</button>
					<div class="streamingDetail_index"
						id="streamingDetailCumulativeIndex">누적 끌림 지수 :
						${leader.acccount }명</div>
					<div class="streamingDetail_index" id="streamingDetailCurrentIndex">현재
						끌림 지수 : ${leader.currcount }명</div>
					<div id="streamingDetailSubscribeContent">${leader.nickname }님을
						구독하셨습니다.</div>

					<div id="streamingDetailRoomTitle">${leader.title }</div>
					<c:if test="${leader.no == loginMember.no}">
						<input id="streamingDetailTitleSearch"
							placeholder="영화 검색">
					</c:if>
					<div id="streamingDetailTitleList">
						<ul>
							<!--  <li><img src="img/movie_image.jpg"> gggg</li>-->

						</ul>

					</div>

					<div id="streamingDetailMovieListContents">
						<ul id="streamingDetailMovieList">

							<c:forEach items="${movieLists}" var="climing_movie" varStatus="status">
							
								<li class="streamingDetail_movie<c:if test='${status.first}'> nowplay</c:if>">
									<div>
										<img src="/posters${climing_movie.poster}"> <span>${climing_movie.title}</span>
										<source type="video/mp4" src="/video/${climing_movie.src}" />
										<c:if test="${leader.no == loginMember.no}">
											<div class="garbage">
												<input hidden value="${climing_movie.no}"><i
													class="fas fa-trash-alt"></i>
											</div>
										</c:if>
									</div> <c:if test="${leader.no == loginMember.no}">
										<button
											class="streamingDetail_switch_btn streamingDetail_up_btn">
											<i class="fas fa-angle-up"></i>
										</button>
										<button
											class="streamingDetail_switch_btn streamingDetail_down_btn">
											<i class="fas fa-angle-down"></i>
										</button>
									</c:if>
								</li>
								
							</c:forEach>



						</ul>

					</div>

				</div>


				<div id="streamingDetailChat" class="streamingDetail_tab_contents">
					<div id="streamingDetailChatWrap">
						<div id="streamingDetailChatList">
							<ul>

							</ul>
						</div>
						<!--streamingDetailChatList -->
					</div>
					<!--streamingDetailChatWrap -->




					<div id="streamingDetailInputChatBox">
						<form id="msgForm">
							<fieldset>
								<div id="vote">
									<i class="fas fa-archive"></i>
								</div>
								<input id="msgInput" placeholder="내용을 입력해주세요">
								<div id="emotionBox">
									<i class="far fa-times-circle"></i>
								</div>
								<div id="emotion">
									<i class="far fa-grin"></i>
								</div>
								<button id="msgBtn">보내기</button>
							</fieldset>

						</form>

					</div>
					<!--streamingDetailInputChatBox -->


				</div>
				<!-- streamingDetailChat -->

				<div id="streamingDetailClim" class="streamingDetail_tab_contents">
					<div id="streamingDetailClimList">
						<ul>

						</ul>
					</div>
					<!--streamingDetailClimList -->
				</div>
				<!-- streamingDetailClim -->

			</div>



			<div class="inequality_btn" id="toggleCloseBtn">></div>
		</div>
		<div class="inequality_btn" id="toggleOpenBtn"><</div>

		<video id="my-player" class="video-js" autoplay muted
			poster="img/c_86iUd018svcu2mbqiag7a4k_fiodb6.jpg" width="1080"
			height="600"
			<c:if test="${leader.no == loginMember.no}">

        controls </c:if>
			 data-setup='{"example_option":true}'>
			<source src="/video/${movieLists[0].src}" type="video/mp4" />
<!-- ${movieLists[0].src} -->

		</video>

	</div>



	<script type="text/template" id="movieAddPlayListTmp">

     
							<li class="streamingDetail_movie">
                                <div><img src="/posters<@=img@>">
                                    <span><@=title@></span>
                                    <source type="video/mp4" src="/video/loop.mp4" />
    								<c:if test="${leader.no == loginMember.no}">
                                    <div class="garbage"><i class="fas fa-trash-alt"></i></div>
									</c:if>
                                </div>
    							<c:if test="${leader.no == loginMember.no}">
                                <button class="streamingDetail_switch_btn streamingDetail_up_btn"><i class="fas fa-angle-up"></i></button>
                                <button class="streamingDetail_switch_btn streamingDetail_down_btn"><i class="fas fa-angle-down"></i></button>
                           		</c:if>
							</li>

</script>

	<script type="text/template" id="streamingChatTmp">

    <li class="<@if(chat.nickname=="${loginMember.nickname}"){@>mine<@}@>">
        <div class="card_user <@if(chat.nickname!="${loginMember.nickname}"){@>user_mine<@}@>">
			<div><@=chat.nickname@></div>
        </div>
        <div class="box_chat">
            <div class="comments mine"><@=chat.msg@></div>
        </div>
    </li>

</script>

	<script type="text/template" id="banChatTmp">

            <li class="cmd">
        <span><@=name@>님 강퇴닼ㅋㅋㅋㅋ</span>

    </li>

</script>

	<script type="text/template" id="SearchListTmp">
    <@ _.each(json, function(data){ @>

    <li class="movie_title"><img src="/<@=data.poster@>"><span><@=data.title@></span>
	<input class="source" hidden value="<@=data.src@>">
	<input class="no" hidden value="<@=data.no@>">
	
</li>
    <@})@>


</script>

	<script type="text/template" id="climListTmp">
    <@ _.each(json, function(member){@>
    <li><span><@=member.nickname@><span> <c:if test="${leader.no == loginMember.no }">
<i class="fas fa-bomb climListDelete"></i></c:if>
	<input hidden class="memberNo" value="<@=member.no@>"></li>
    <@});@>
</script>



	<script src="/js/moment-with-locales.js"></script>
	<script src="/js/sockjs.min.js"></script>
	<script src="/js/stomp.min.js"></script>
	<script>
            moment.locale("ko");
            _.templateSettings = {
                interpolate: /\<\@\=(.+?)\@\>/gim,
                evaluate: /\<\@([\s\S]+?)\@\>/gim,
                escape: /\<\@\-(.+?)\@\>/gim
            };


            let $streamingDetailMovieList = $("#streamingDetailMovieList");
            let $streamingDetailTitleSearch = $("#streamingDetailTitleSearch");
            let movieAddPlayListTmp = _.template($("#movieAddPlayListTmp").html());
            let streamingChatTmp = _.template($("#streamingChatTmp").html());
            let banChatTmp = _.template($("#banChatTmp").html());
            let climListTmp = _.template($("#climListTmp").html());
            let SearchListTmp = _.template($("#SearchListTmp").html());

            let climeesCnt = 0;

            
            //    myPlayer.requestFullScreen();
            /*videojs("my-player").ready(function() {
                myPlayer.src({
                	
                    type: "video/mp4",
                    src: "/video/loop.mp4"
                });

            });*/

            let onPlay = function() {
//                 console.info("on Play");
                $(".vjs-big-play-button").hide();

            };
            //myPlayer.on("play", onPlay);

            //슬라이드 바 맨위에 정보 채팅 끌림들 클릭시 ____ 넣기
            $("#streamingDetailTopTab .streamingDetail_tab").click(function(e) {
                e.preventDefault();
                $(".on").removeClass("on");
                $(this).addClass("on");
                let index = $(this).index();
                $(".streamingDetail_tab_contents").eq(index).addClass("on");

            });

            // 슬라이드 옆에 > 토글 버튼 클릭시 슬라이드 none
            $("#toggleCloseBtn").click(function() {

                $("#streamingDetailSlideBar").fadeOut();
                $("#toggleOpenBtn").show();
                $("#my-player").css("width", 1080);

            });

            // < 토클 버튼 클릭시 슬라이드 show
            $("#toggleOpenBtn").click(function() {
                $("#streamingDetailSlideBar").fadeIn();
                $("#toggleOpenBtn").hide();
                $("#my-player").css("width", 780);
            });

          
            //신고 하기 버튼 클릭시 팝업
            $("#streamingDetailReportBtn").click(function() {

                $("#streamingBg").show();

            });
            //신고하기 X 버튼 클릭시 팝업창 ㅂㅂ
            $("#streamingCloseBtn").click(function() {
                $("#streamingBg").hide();
            });
            //신고하기 팝업 있을 때 BG 누르면 ㅃㅃ
            $("#streamingBg").click(function() {
                $("#streamingBg").hide();
            });
            //신고하기 팝업창 눌렀을때 popup창 안없어지게
            $("#streamingReportPopup").click(function(e) {

                return false;
            });

            $("#streamingReportBtn").click(function (e) {
            	
            	var content=$("#streamingReportContent").val()
            	$.ajax({
            		url:'/ajax/report/climer',
            		data:{roomNo:${roomNo},
            			userNo:${loginMember.no},
            			content:content},
            		error:function(){
            			
            		},
            		success:function(){
            			$("#streamingBg").hide();
            			alert("신고되었습니다.");
            		}

            	});
            	
                e.stopPropagation();
            });
            
            //var myPlayer = videojs('my-player_html5_api');
            
            $("#test").click(function() {
            	
            	playMovie("/video/SampleVideo_1280x720_10mb.mp4",10);
            	
            });

            function playMovie(src,time,title){
            	
//             	console.log("1) test");
//             	console.log(title)
            	
            	player.src({type: 'video/mp4', src: src});
            	$(".vjs-title-bar").text(title);
            	player.load();
            	
            	player.currentTime(time);
            	
            	player.play();
            	
            	
            	/*player.ready(function() {
            		console.log("2) test");
     			   // tech() will error with no argument
     			   //var tech = player.tech({IWillNotUseThisInPlugins: true});
     			   
     			  console.log("3) test");
     			  
     			  if(time)  {player.currentTime(time);}
     			   
     			  player.play();
     			});*/
            }


            //채팅 하기
          /*  let chatMsg = "";
            $("#msgForm").on("submit", function(e) {

               

            });*/
         
            
            //move 스클로 모르겠당
            function moveScroll() {
                let height = 10000000000;
                height += $("#streamingDetailChatList li").height();

                //height 증가된만큼 scroll 이동
                $("#streamingDetailChatList ul").scrollTop(height);
                

                }


            //영화 제목을 입력했을 때

            $("#streamingDetailTitleSearch").on("keyup", function() {
                let searchTitle = $streamingDetailTitleSearch.val().trim();
//                 console.log(searchTitle);

                if (searchTitle.length == 0) {
                    $("#streamingDetailTitleList").hide();
                    $("#streamingDetailTitleList ul").empty();
                    return false;
                }
                $("#streamingDetailTitleList").show();

                $.ajax({
                    url: "/ajax/climingSearch/"+searchTitle,
                    dataType: "json",
                    error: function() {
                        alert("movieList 서버 점검.")
                    },
                    success: function(json) {
//                         console.log(json);
//                         console.log(json[0].title);
                        
                       $("#streamingDetailTitleList ul").empty();

                        $("#streamingDetailTitleList ul").append(SearchListTmp({

                          "json":json

                        }));


                     /*   $.each(json, function() {
                            if (this.title.includes(searchTitle)) {
                                let $li = $("<li></li>").addClass("movie_title");
                                let $img = $("<img>");

                                $img.attr("src", "img/movie_image.jpg")
                                $li.text(this.title).prepend($img);
                                $("#streamingDetailTitleList ul").append($li);
                            }
                        });*/


                    }
                }) //ajax
            });

            //영화 제목을 검색 후 영화 제목을 클릭하면 리스트에 영화가 자동으로 뜸
            $("#streamingDetailTitleList ul").on("click", ".movie_title", function() {
            	
				const title=$(this).text();
				const img = $(this).find('img').attr("src");
				const source = $(this).find('.source').val();
				const movie_no=$(this).find('.no').val();
            $.ajax({
            	url:"/ajax/addClimingList",
            	data:{roomNo:${roomNo},movieNo:movie_no},
            	error:function(){
            		alert("서버점검중");
            	},
            	success:function(json){
            		
//             		console.log(json);
            		if(json.result){
            			$streamingDetailMovieList.append(movieAddPlayListTmp({
                            "title": title,
                            "img": img,
                            "source":source,
                            "no":movie_no
                        }));
            			 $("#streamingDetailTitleList").hide();
                         $("#streamingDetailTitleSearch").val(" ").focus();
                         
            		}
            		else{
            			alert("재생 목록에 이미 있습니다.");
            		}

                   
            	}
            });
                
            });
			let type;
            //구독을 눌렀을 때 구독 신청 팝업
            $("#streamingDetailSubscribeBtn").on("click", function() {
            	
            	const following = ${loginMember.no}
            	const follower = ${leader.no}
            	
            	if(!$("#streamingDetailSubscribeBtn").hasClass("subscribe_on")){
            		$("#streamingDetailSubscribeContent").fadeIn();
                    $("#streamingDetailSubscribeBtn").addClass("subscribe_on");
                    setTimeout(function() {
                        $("#streamingDetailSubscribeContent").fadeOut();
                    }, 1000);
                    type="POST";
            	}else{
            		$("#streamingDetailSubscribeBtn").removeClass("subscribe_on");
            		type="GET";
            	}
                
                $.ajax({
                	url:"/ajax/subscribe/follow",
                	type:type,
                	data:{
                		following:following,
                		follower:follower
                	},
                	error:function(){
                		alert("z");
                	},
                	succress:function(){
                		
                	}
                })//ajax() end

            });// #streamingDetailSubscribeBtn.click() end



            //채팅 입력창 옆에 이모티콘 아이콘 클릭했을 때
            $("#emotion").click(function() {

                $("#emotionBox").show();

            });

            $("#emotionBox i").click(function() {
                $("#emotionBox").hide();
            });
          //###############################비디오
            const Component = videojs.getComponent('Component');
 			                  const button = videojs.getComponent('Button');
 			                  //MoveButton
 			                 /* const MoveButton = videojs.extend(button,{
 			                      createEl: function() {
 			                          return videojs.createEl('button', {
 			                              className: 'vjs-move-btn',
 			                              innerText:"넘기기"
 			                          });
 			                      },
 			                      handleClick: function(){
 			                          this.player().currentTime(15);
 			                      }
 			                  });//MyButton() end*/

 			                  //TitleBar
 			                  const TitleBar = videojs.extend(Component, {
 			                      constructor: function(player, options) {
 			                          Component.apply(this, arguments);

 			                          if (options.text) {

 			                              if (typeof text !== 'string') {
 			                                  text = 'Title Unknown';
 			                              }//if end

 			                              videojs.appendContent(this.el(), options.text);
 			                          }//if end
 			                      },
 			                      createEl: function() {
 			                          return videojs.createEl('div', {
 			                              className: 'vjs-title-bar'
 			                          });
 			                      }
 			                  });//TitleBar end



 			                 /* const PrevBtn = videojs.extend(button, {
 			                      createEl: function() {
 			                          return videojs.createEl('button', {
 			                              className: 'vjs-control vjs-menu-button vjs-button',
 			                              innerHTML:"<i class='fas fa-undo-alt'></i>",
 			                          });
 			                      },
 			                      handleClick: function(){
 			                          const time = this.player().currentTime();
 			                          this.player().currentTime(time-10);
 			                      }
 			                  });
 			                  const NextBtn = videojs.extend(button, {
 			                      createEl: function() {
 			                          return videojs.createEl('button', {
 			                              className: 'vjs-control vjs-menu-button vjs-button',
 			                              innerHTML:"<i class=\"fas fa-redo-alt\"></i>",
 			                          });
 			                      },
 			                      handleClick: function(){
 			                          const time = this.player().currentTime();
 			                          this.player().currentTime(time+10);
 			                      }
 			                  });*/

 			                  //videojs에 컴포넌트 등록
 			                 // videojs.registerComponent('PrevBtn', PrevBtn);
 			                 // videojs.registerComponent('NextBtn', NextBtn);
 			                  videojs.registerComponent('TitleBar', TitleBar);
 			                 // videojs.registerComponent('MoveButton', MoveButton);

 			                 

 			                  //children: ['playToggle', 'volumePanel', 'currentTimeDisplay', 'timeDivider', 'durationDisplay', 'progressControl', 'liveDisplay', 'seekToLive', 'remainingTimeDisplay', 'customControlSpacer', 'playbackRateMenuButton', 'chaptersButton', 'descriptionsButton', 'subsCapsButton', 'audioTrackButton', 'pictureInPictureToggle', 'fullscreenToggle']



 			                  //실제 플레이어
 			                  const player = videojs('my-player');

 			                  //컴포넌트를 자식으로 추가
 			                  player.addChild('TitleBar', {text: ''});

 			                  //컴포넌트를 자식으로 추가
 			                //  const moveButton = player.addChild('MoveButton');
 			                   videojs.getComponent('ControlBar').prototype.options_ = {
 			                          loadEvent: 'play',
 			                          children: [
 			                              'muteToggle',
 			                              'volumeControl',
 			                              'progressControl',
 			                              'subsCapsButton',
 			                              'pictureInPictureToggle',
 			                              'fullscreenToggle'
 			                          ]
 			                      }
 			                   
 			                   
 			                   
 			                 

            //끌리미들 목록
            /*function climList() {
                $.ajax({
                    url: "/ajax/room/${roomNo}/climee",
                    dataType: "json",
                    error: function() {
                        alert("ㅇㅇㅇ 서버 점검.")
                    },
                    success: function(json) {
                        console.log(json);

                        $("#streamingDetailClimList ul").append(climListTmp({
                            json: json
                        }))
                    }
                });
            }
            climList();
            */
            
            $("#streamingReportBtn").submit(function(){
                alert("Test");
                
            });
            let stompClient = null;
            
    		function connect(callback) {
        	
        	let socket = new SockJS('/clim');
        	stompClient = Stomp.over(socket);
        	
        	// SockJS와 stomp client를 통해 연결을 시도.
        	stompClient.connect({},function() {
        		
//         		console.log("2) 연결!");
        	
        		//인자로 받은 함수를 여기서 호출
        		if(callback) callback();
        		
        	});
    		};
    		//connect선언에 이것만 두고

 							//const video = $("video").get(0); 	
 			            	connect(function() {
 			            		
 			            		//채팅
 			            		$("#msgForm").submit(function(e) {
 			            			e.preventDefault();
 			            			
 			            			const msg = $("#msgInput").val();
 			            			
 			            			const data = JSON.stringify({"msg":msg,"nickname":"${loginMember.nickname}"});
 			            			
 			            			stompClient.send("/app/room/${roomNo}/chat",{},data);
 			            			
 			            		});
 			            		
 			            		//채팅
 			            		stompClient.subscribe("/topic/room/${roomNo}/chat",function(protocol) {
 			            			
 			            			
 			                         

 			                         $("#streamingDetailChatList ul").append(streamingChatTmp({
 			                             "chat": JSON.parse(protocol.body)
 			                         }));

 			                         $("#msgInput").val(" ");
 			                         $("#msgInput").focus();
 			                         moveScroll();
 			            			
 			            		});
 			            		 
 			            		//클리미들 구독해서 리스트 가져오기!
 			            		stompClient.subscribe("/topic/room/${roomNo}/get/climee",function(protocol) {
			            				
			            				const json = JSON.parse(protocol.body);
			            				console.log("/topic/room/${roomNo}/get/climee");
			            				$("#streamingDetailClimList ul").html(climListTmp({
			                                json: json.climees
			                            }))
			            				
			            				climeesCnt = json.climeesCnt;
			            				const climeedCnt = json.climeedCnt;
			            				
			            				//console.log(json);
			            				
			            				$("#streamingDetailCumulativeIndex").text("누적 끌림 지수 :"+climeedCnt+"명");
			            				$("#streamingDetailCurrentIndex").text("현재 끌림 지수 : "+climeesCnt+"명");
			            				
			            			});
 			            		//방장이 나가라고 받았음
 			            		stompClient.subscribe("/topic/room/${roomNo}/ban/${loginMember.no}",function(protocol) {

		            				//console.log("/topic/room/${roomNo}/ban/${loginMember.no}");
		            				stompClient.send("/app/room/${roomNo}/baned/member/${loginMember.no}",{},"${loginMember.nickname}");
	 			            		
		            				alert("강퇴당하셨습니다.");
 			        				location.href="/index";
		            				
		            			});
 			            		//누가 강퇴당함 ㅋㅋㅋㅋ
 			            		stompClient.subscribe("/topic/room/${roomNo}/member/baned",function(protocol) {

		            				const nickname = protocol.body;
		            				 $("#streamingDetailChatList ul").append(banChatTmp({
		            	                    name:nickname
		            	                }));
		            	               
		            				 stompClient.send("/app/room/${roomNo}/get/climee",{});
		            				
		            			});
 			            		
 			            		

 								<c:choose>
 			            		<c:when test="${leader.no!= loginMember.no}">
 			            		
 			            			stompClient.subscribe("/topic/room/${roomNo}/close",function(protocol) {
 			        				//console.log(protocol.body);
 			        				stompClient.send("/app/room/${roomNo}/${loginMember.no}/close",{});
			        				
 			        				alert("방장이 방을 종료했습니다!");
 			        				location.href="/index";
 			        			});
 			            			//방장이 시간을 보내는 주소를 구독해야 함
 			            			stompClient.subscribe("/topic/room/${roomNo}/set/time",function(protocol) {
 			            				const json = JSON.parse(protocol.body);
 			            				//console.log("/topic/room/${roomNo}/set/time");
 			            				const time = json.audiAcc;
 			            				const src = json.src;
 			            				const title = json.title
 			            				//방장이 현재 보는 시간으로 동기화
 			            				playMovie(src,time,title);
 			            				//player.currentTime(time);
 			            				 stompClient.send("/app/room/${roomNo}/get/climee",{});
 			            			});
 			            			
 			            			//들어오자마자 현재 방장이 보고 있는 현재 시간을 요청해야 함
 			            			stompClient.send("/app/room/${roomNo}/get/time",{},${loginMember.no});
 			            			
 			            			
 			            			
 			            			//방장이 문을 닫을때 호출됨
					        			$(window).bind("beforeunload",function(e) {
					        				//내가 나갈때 로그찍어줘
					        				stompClient.send("/app/room/${roomNo}/${loginMember.no}/close",{});
					        				stompClient.send("/app/room/${roomNo}/get/climee",{});
					        			});
 			            			
 			                    </c:when>
 			                    <c:otherwise>
 			                   ////방장
 			                   
 			                   
 			                   
 			                   $("#streamingDetailClimList").on("click",".climListDelete",function(){
 			                	  
 			                	   let member_no = $(this).next().val();
 			                	   //let member_nickname = $(this).find("span").text();
 			                	    alert(member_no);
 			                	  stompClient.send("/app/room/${roomNo}/ban/"+member_no,{},member_no);
 			                	   
 			                   });
 			                   
 			                     $(".streamingDetail_movie .fa-trash-alt").click(function() {
					            	const movie_no=$(this).parent().find('input').val();
					            	
					            	$.ajax({
					            		url:"/ajax/delete/ClimingList",
					            		data:{roomNo:${roomNo},movieNo:movie_no},
					            		error:function(){
					            			alert("서버점검중");
					            		},
					            		success:function(){
					            			$li.remove();
					            		}
					            	});
					               
					            });//방장이 들어오자마자 클리미들 호출!
 			                  
 			                   
							
							            // 쓰레기통 클릭하면 영화 삭제
							            $streamingDetailMovieList.on("click", ".streamingDetail_movie .fa-trash-alt", function() {
							            	const movie_no=$(this).parent().find('input').val();
							            	
											const $li = $(this).parents("li");
											
							            	$.ajax({
							            		url:"/ajax/delete/ClimingList",
							            		data:{roomNo:${roomNo},movieNo:movie_no},
							            		error:function(){
							            			alert("서버점검중");
							            		},
							            		success:function(){
							            			$li.remove();
							            		}
							            	});
							            	return false;
							            });
							
							            // 영화 목록에 아래 버튼을 클릭시 스왑
							            $streamingDetailMovieList.on("click", ".streamingDetail_down_btn", function() {
							                // alert("down button");
							                let lastIndex = $streamingDetailMovieList[0].childElementCount - 1;
							                let temp = $(this).parents("li");
							                //console.log(temp);
							                let index = $(this).parents("li").index();
							                //console.log(index);
							                if (index == lastIndex) {
							                    return false;
							                }
							                $(this).parents("li").remove();
							                $streamingDetailMovieList.children("li").eq(index).after(temp);
							                //console.log($(this).parents("li").index());
							            });
							
							            // 영화 목록에서 윗 버튼을 클릭하면 스왑
							            $streamingDetailMovieList.on("click", ".streamingDetail_up_btn", function() {
							                // alert("up button");
							                let zeroIndex = 0;
							                let temp = $(this).parents("li");
							                let index = $(this).parents("li").index();
							
							                if (index == zeroIndex) {
							                    return false;
							                }
							
							                $(this).parents("li").remove();
							                $streamingDetailMovieList.children("li").eq(index - 1).before(temp);
// 							                console.log($(this).parents("li").index());
							
							            });
							            // 관리자가 스트리밍 무비 리스트를 클릭하면 
							            // 클릭 된 영화 재생
							            $("#streamingDetailMovieList").on("click"," .streamingDetail_movie div",function(){
							             	const src = $(this).find("source").attr('src');
// 							             	console.log(src);
// 							     			console.log();
							     			
							     			//player.currentTime(10);
							     			
							     			const time = player.currentTime();
							     			
// 							     			console.log("time:" + time);
							     			const title = $(this).find("span").text();
							     			
							     			const data = JSON.stringify({"src":src,"audiAcc":0,"title":title});
							     			$(".vjs-title-bar").text(title);
							     			stompClient.send("/app/room/${roomNo}/set/time",{},data);
							     			
							     			playMovie(src,0,title);
							     			
							     			//$('video source').attr("src",src);
							     			
							                //video.find('source').attr("src",$(this).find("#source").attr("src"));
							                //$("#my-player_html5_api").attr("src","/video/loop.mp4");
							                                                 
							             });
							            
							            
							          ///영화가 끝났을때 다음 영화 틀어주기
		 			            		 player.on("ended",function() {
		 	 			                	  
		 	 			                	  const endMovieNo=$(".nowplay .garbage input").val();
		 	 			                	  
		 	 			                	  $.ajax({
		 	 			                		  url:"/ajax/room/${roomNo}/ClimingMovie/"+endMovieNo,
		 	 			                		  type:"GET",
		 	 			                		  error:function(){
		 	 			                			  
		 	 			                		  },
		 	 			                		  success:function(){
		 	 			                			$now = $(".nowplay");
			 	 			                		$now.removeClass("nowplay");
			 	 			                		$next = $now.next();
			 	 			                		$next.addClass("nowplay");
			 	 			                		const title = $(".nowplay div span").text();
			 	 			                		const src = $(".nowplay div source").attr("src");
			 	 			                		
			 	 			                		const data = JSON.stringify({"src":src,"audiAcc":0,"title":title});
			 						     			$(".vjs-title-bar").text(title);
			 						     			stompClient.send("/app/room/${roomNo}/set/time",{},data);
			 						     			
			 						     			playMovie(src,0,title);
		 	 			                		  }
		 	 			                	  });

		 	 			                	 });
 					                 // 방장의 경우 들어왔을때 현재 세션으로 갱신해야 함
 					                 	
 					                 
 					                 	//Live check 함수
 					                 	function liveCheck() {
 					                 		const data = JSON.stringify({no:${roomNo},memberNo:${loginMember.no}});
 	 					        			stompClient.send("/app/clim/live", {},data);
										}
 					                 
 					        			stompClient.send("/app/room/${roomNo}/put/sessionId",{},${roomNo});
 					        			
 					        			// Live check 함수 호출
 					        			liveCheck();
 					        			
 					        			//ajax 실행될때 마다 Live check 함수 호출
 					                	stompClient.subscribe("/topic/clim/living",function(protocol){
 					                	liveCheck();
 					                 	});//subscribe end
 					                 
 					        			
 					        			
 					        			//방장의 경우 다른 유저들이 들어왔을때 현재 영화의 currentTime을
 					        			//넘겨줘야 하는 주소를 구독해놔야 함
 					        			stompClient.subscribe("/topic/room/${roomNo}/get/time",function(protocol) {
//  					        				console.log("/user/queue/room/${roomNo}/time");
 					        								
 					        				//alert(video.currentTime);
 					        				
 					        				//방장이 현재 보고 있는 시간을 다른 유저들에게 보냄
 					        				let src = $("video source").attr('src');
//  					        				console.log(src);
 					        				const title = $('.vjs-title-bar').text();
 					        				const data = JSON.stringify({src:src,audiAcc:player.currentTime(),title:title});
 					        				stompClient.send("/app/room/${roomNo}/set/time",{},data);
 					        			});
 					        			
 					        			//방장이 문을 닫을때 호출됨
 					        			$(window).bind("beforeunload",function(e) {
 					        				//방장이 문을 닫을때 
 					        				stompClient.send("/app/room/${roomNo}/close",{});
 					        				//방에 있지 않은 다른 유저들에게도 리스트 갱신
 					        				stompClient.send("/app/clim/list",{});
 					        				
 					        				const data = JSON.stringify({memberNo:${loginMember.no}});
 					        				
 					        				stompClient.send("/app/clim/live/close", {},data);
 					        			});
 					        			
 					        			//0809 손영준 구독 추가
 					        			stompClient.subscribe("/topic/climing/set/feature",function(protocol) {
 					        				
 					        				console.log("/topic/climing/set/feature");
 					        				
 					        				//방장이 현재 보고 있는 시간을 다른 유저들에게 보냄
 					        				let src = $("video source").attr('src');
 					        				
 					        				const title = $('#streamingDetailRoomTitle').text();
 					        				console.log("타이틀입니다!!@#!@#")
 					        				console.log(title);
 					        				const data = JSON.stringify({
 					        					src :src,
 					        					currentTime :player.currentTime(),
 					        					no:${no },
 					        					viewerCount:climeesCnt,
 					        					title : title
 					        				});
 					        				
 					        				stompClient.send("/app/climing/info",{},data);
 					        				
 					        				//영화번호, 현재 시간, 현재 방번호를 서버로 
 					        			});
 			                    </c:otherwise>
 			                    </c:choose>
 			                  
 			           	});
            //##########################웹소켓################################
            
   
            	
            		
            	
        </script>


</body>
</html>