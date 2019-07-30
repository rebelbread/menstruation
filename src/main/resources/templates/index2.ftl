<html>
<head>
    <title>电力学习-by熬夜的面包</title>
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
</head>
<script type="text/javascript">var cnzz_protocol = (("http:" == document.location.protocol) ? "http://" : "http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1276279053'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s96.cnzz.com/z_stat.php%3Fid%3D1276279053%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));</script>
<body>

    <div>
        <select id="paper_type" name="paper_type">
<#--
            <option value ="">全部</option>
-->
            <option value ="1">单选</option>
            <option value = "2">是非</option>
            <option value="3">填空</option>
            <option value="4">多选</option>
            <option value="5">解答</option>
        </select>

    </div>

    <div id="title">
    </div>
    <br/>
    <div id="answer">

    </div>

    <br/>

    <div id="btn">

    </div>

    <br/>
    <div id="result"></div>
    <br/>

    <input type="button" value="下一题" onclick="nextPaper()" >

</body>


<script>


    var paper;

    function choose(){

        if(paper.type === 1){
            var val = $('input:radio[name="answer"]:checked').val();
            var result = "<span>你的答案：&nbsp; " + val +" &nbsp;</span><br/>";
            result += "<span>正确答案：&nbsp; " + paper.result +" &nbsp;</span></br>";
            if(paper.result == val){
                result += "<span style='color:#00FF00'>回答正确</span>";
            }else{
                result += "<span style='color:#FF0000'>回答错误</span>";
            }
            $("#result").html(result);
        }else if(paper.type === 2){
            var val = $('input:radio[name="answer"]:checked').val();
            var result = "<span>你的答案：&nbsp; " + val +" &nbsp;</span><br/>";
            result += "<span>正确答案：&nbsp; " + paper.result +" &nbsp;</span></br>";
            if(paper.result == val){
                result += "<span style='color:#00FF00'>回答正确</span>";
            }else{
                result += "<span style='color:#FF0000'>回答错误</span>";
            }
            $("#result").html(result);
        }else if(paper.type === 3 || paper.type === 5){
            $("#result").html(paper.result);
        }else if(paper.type === 4){
            var str = "";
            $("input:checkbox[name='answer']:checked").each(function(i) {
                var val = $(this).val();
                str += val;
            });
            var result = "<span>你的答案：&nbsp; " + str +" &nbsp;</span><br/>";
            result += "<span>正确答案：&nbsp; " + paper.result +" &nbsp;</span></br>";
            if(paper.result == str){
                result += "<span style='color:#00FF00'>回答正确</span>";
            }else{
                result += "<span style='color:#FF0000'>回答错误</span>";
            }
            $("#result").html(result);

        }

    }

    function nextPaper(){

        $("#title").html("");
        $("#answer").html("");
        $("#result").html("");
        var paper_type = $("#paper_type option:selected").val();
        console.log("paperType",paper_type);

        $.post("paper/random",{type:paper_type},function (data) {
            paper = data;
            console.log(data);
            $("#title").html("<pre>"+ data.no + "." + data.title + "</pre>");
            var inputHtml = "";

            if(paper.type === 1){

                $("#btn").html("<input type=\"button\" value=\"确定\" onclick=\"choose()\" >");

                inputHtml += "<input type='radio'  value='A'  name='answer' > "+ "A." + data.A +" </input>&nbsp;";
                inputHtml += "<input type='radio'  value='B'  name='answer' /> "+ "B." + data.B +" </input>&nbsp;";
                inputHtml += "<input type='radio'  value='C'  name='answer' />"+ "C." + data.C +" </input>&nbsp;";
                inputHtml += "<input type='radio'  value='D'  name='answer' />"+ "D." + data.D +" </input>&nbsp;";
                $("#answer").html(inputHtml);

            }else if(paper.type === 2){

                $("#btn").html("<input type=\"button\" value=\"确定\" onclick=\"choose()\" >");

                inputHtml += "<input type='radio'   value='是'  name='answer' > "+ "A." + data.A +" </input>&nbsp;";
                inputHtml += "<input type='radio'  value='非'  name='answer' /> "+ "B." + data.B +" </input>&nbsp;";
                $("#answer").html(inputHtml);
            }else if(paper.type === 3 || paper.type === 5) {
                $("#btn").html("<input type=\"button\" value=\"显示答案\" onclick=\"choose()\" >");
            }else if(paper.type === 4){
                $("#btn").html("<input type=\"button\" value=\"确定\" onclick=\"choose()\" >");

                inputHtml += "<input type='checkbox'  value='A'  name='answer' > "+ "A." + data.A +" </input>&nbsp;";
                inputHtml += "<input type='checkbox'  value='B'  name='answer' /> "+ "B." + data.B +" </input>&nbsp;";
                inputHtml += "<input type='checkbox'  value='C'  name='answer' />"+ "C." + data.C +" </input>&nbsp;";
                inputHtml += "<input type='checkbox'  value='D'  name='answer' />"+ "D." + data.D +" </input>&nbsp;";
                $("#answer").html(inputHtml);
            }


        });
    }



    $(function () {
        nextPaper();
    });
</script>


</html>