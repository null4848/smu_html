function chBtn(){
    alert("색상을 빨간색으로 변경합니다.")
    // id 찾는 방법
    //let color1 = document.getElementById("color1");

    // class 찾는 방법
    /*
    let color2 = document.querySelector("#color3")
    console.log(color2);
    console.log(color2[0])
    color2[0].style.color = "red";
    color2[0].innerText = "회원수정";
    */

    // querySelector - id-1개만 검색됨
    /*
    let color3 = document.querySelector("#color3");
    console.log(color3);
    color3.style.color = "red";
    color3.innerText = "회원수정";
    */

    // querySelector - class 1개만 검색
    // querySelectorAll()
    // document.querySelectorAll() // 복수 검색
    let color4 = document.querySelector(".color4");
    console.log(color4);
    color4.style.color = "red";
    color4.innerText = "회원수정";

    let color5 = document.querySelectorAll(".color4")
    console.log(color5);

}