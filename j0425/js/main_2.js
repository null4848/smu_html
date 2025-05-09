$(function(){

    $("#dataOpen2").click(function(){
        alert("게시글 정보를 가져옵니다.")
        $.ajax({
            url:"js/students.json",
            type:"get",
            data:{"kor":100,"eng":100},
            datatype:"json",
            success:function(data){
                // alert("성공")
                let hdata = ``;
                for(i=0;i<data.length;i++){
                    hdata += `<tr id="${data[i].sno}">`;
                    hdata += `<td>${data[i].sno}</td>`;
                    hdata += `<td>${data[i].sname}</td>`;
                    hdata += `<td>${data[i].kor}</td>`;
                    hdata += `<td>${data[i].eng}</td>`;
                    hdata += `<td>${data[i].math}</td>`;
                    hdata += `<td>${data[i].kor+data[i].eng+data[i].math}</td>`;
                    hdata += `<td>${((data[i].kor+data[i].eng+data[i].math)/3).toFixed(2)}</td>`;
                    hdata += `<td>${data[i].sdate}</td>`;
                    hdata += `<td>`;
                    hdata += `<button type="button" class="uBtn">수정</button>`;
                    hdata += `<button type="button" class="dBtn">삭제</button>`;
                    hdata += `</td>`;
                    hdata += `</tr>`;
                }
                $("#tbody").html(hdata);
            },
            error:function(){
                alert("실패")
            }
        })

    })
})