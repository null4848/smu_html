// 제이쿼리 선언
$(function(){
    $("#dataOpen3").click(function(){
        // alert("확인");
        $.ajax({
            url:"https://apis.data.go.kr/B551011/PhotoGalleryService1/galleryList1?serviceKey=ccbwa2a%2Fgupb23PWffSQbJTaeZ%2B3NjEPrf%2F4WVV%2FwsouzGFTlHT%2BN85izwlRyCvGa12etsaGXs55YTiSvdJiVg%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&_type=json",
            type:"get",
            data:{},
            datatype:"json",

            success:function(data){
                alert("성공")
                console.log(data.response.body.items.item);
                console.log(data.response.body.items.item[0].galWebImageUrl);
                $("#txt").text();
                let imgData = data.response.body.items.item[0].galWebImageUrl;
                let hdata = `<img id="img" src="${imgData}">`;
                $("#txt").html(hdata);
                /*
                let hdata =``;
                for(i=0;i<10;i++){
                    hdata += `<tr id="${i}">`;
                    hdata += `<td>${data.response.body.items.item[i].galContentId}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galCreatedtime}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galPhotographer}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galPhotographyLocation}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galSearchKeyword}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galTitle}</td>`;
                    hdata += `<td>${data.response.body.items.item[i].galWebImageUrl}</td>`;
                    hdata += `<td>`;
                    hdata += `<button type="button" class="uBtn">수정</button>`;
                    hdata += `<button type="button" class="dBtn">삭제</button>`;
                    hdata += `</td>`;
                    hdata += `</tr>`;
                    
                }
                
                $("#tbody").html(hdata)
                
                */
            },
            error:function(){
                alert("실패");
            }
        });

    });
})