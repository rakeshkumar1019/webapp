<!-- <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome to Jenkins </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
</head>
<body>
  <div class="jumbotron" style="background-color:white">
     <h1 class="text-center">Welcome to</h1>
      <img src="http://www.learntek.org/wp-content/uploads/2017/08/jenkins_image.png" alt="Spidertocat"
           class="img-responsive center-block" style="width:250px"/>
      <h1 class="text-center">My job is done with jenkins</h1>
      <h2 class="text-center">Now you are with Rakesh Kumar Singh</h2>
  </div>
</body>
</html> -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RAKESH KUMAR SINGH |Corona Tracker</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="jquery-jvectormap-2.0.5.css">
    <script src="jquery-jvectormap-2.0.5.min.js"></script>
     <script src="world.js"></script>
</head>
<body>
    <style>
        body{
            padding: 0%;
            margin: 0%;
            font-family: sans-serif;
        }


        /* width */
::-webkit-scrollbar {
  width: 10px;
}

/* Track */
::-webkit-scrollbar-track {
  background:rgb(29, 28, 28);
}

/* Handle */
::-webkit-scrollbar-thumb {
  background:black;
  border-radius: 10px ;
}


        .mapcontainer{
            position: absolute;
            width: 55%;
            left: 15%;
            height: 100%;
            overflow: hidden;
        }
         
        .stat{
            float: left;
            width: 100%;
            text-align: center;
            font-size: 30px;
            font-weight: bolder;
            color: white;
            text-align: center;
        }
        .data-table-container{
            position: absolute;
            width: 15%;
            height: 100%;
            overflow: hidden;
            background-color: #222222;
            color: white;
        }
        #total-cases-container{
            left: 0;
        }
        #death-cases-container{
            right: 15%;
        }
        #cured-cases-container{
            right: 0%;
        }
        .data-table-parent{
            position: absolute;
            top:10%;
            height: 90%;
            overflow: auto;
        }
        .data-table tr td{
            border-bottom: 1px solid white;
            padding: 2px;
        }
        #hov{
            position: absolute;
            left: 18%;
            top: 10px;
            font-size: 17px;
            z-index: 2;
            color: gray;
            
        }
        .waiting{
            position: absolute;
            top: 45%;
            left: 25%;
            
        }
    </style>
    
    <div class="waiting">
        <h1>Please wait while fetching data ...</h1>
    </div>
 
    <span id="hov">Hover on the map to know specific data</span>
    <!-- ====== -->

    <div class="data-table-container" id="total-cases-container">
        Total Cases:<br/>
        <div class="stat" id="totalCases" style="color: yellow;"></div>
        <div class="data-table-parent">
          <table class="data-table" id="total-cases-table" cellspacing='0'>
 
            </table>
               
        </div>

    </div>
    <!-- ========== -->



    <!-- ====== -->

    <div class="data-table-container" id="death-cases-container">
       Death Cases:<br/>
    <div class="stat" id="totalDeath" style="color: red;"></div>
    <div class="data-table-parent">
        <table class="data-table"id="death-cases-table" cellspacing='0'>

        </table>
    </div>

    </div>
    <!-- ========== -->


    <!-- ====== -->
 
    <div class="data-table-container" id="cured-cases-container">
    cured Cases:<br/>
    <div class="stat" id="totalCured" style="color: lightgreen;"></div>
    <div class="data-table-parent">
        <table class="data-table"id="cured-cases-table" cellspacing='0'>

        </table>
    </div>

   </div>
   <!-- ========== -->







    <!-- //calling world map -->
    <div class="mapcontainer" id="mapcontainer"></div>
    

    <script>
        function loadmap(){
            $.ajax({
                url:"https://corona.lmao.ninja/v2/countries",
                error:function(){
                    alert("Sorry, Problem with Featching data from API try Again after sometime");
                },
                success:function(data){
                     var infectedData={};
                     var countryWiseDeaths={};
                     var countryWiseCured={};

                     var worldCases=0;
                     var worldCured=0;
                     var worldDeaths=0;

                     var totalCasesHTML="";
                     var deathCasesHTML="";
                     var curedCasesHTML="";

                     for(var i=0;i<data.length;i++){
                         var elem=data[i];
                         var cases=elem.cases;
                         var country=elem.countryInfo.iso2;
                         infectedData[country]=cases;
                         countryWiseDeaths[country]=elem.deaths;
                         countryWiseCured[country]=elem.recovered;
                         worldCases+=cases;
                         worldCured+=elem.recovered;
                         worldDeaths+=elem.deaths;

                         totalCasesHTML += "<tr>";
                         totalCasesHTML += "<td>"+cases+ "<br/> <b> "+ elem.country+"</b> </td>";
                         totalCasesHTML += "</tr>";

                         deathCasesHTML += "<tr>";
                         deathCasesHTML += "<td>"+elem.deaths+ "<br/> <b> "+ elem.country+"</b> </td>";
                         deathCasesHTML += "</tr>";


                         curedCasesHTML += "<tr>";
                         curedCasesHTML += "<td>"+elem.recovered+ "<br/> <b> "+ elem.country+"</b> </td>";
                         curedCasesHTML += "</tr>";
                     }
                      
                     $("#total-cases-table").html(totalCasesHTML);
                     $("#death-cases-table").html(deathCasesHTML);
                     $("#cured-cases-table").html(curedCasesHTML);

                     var curedPercentage=parseFloat((worldCured/worldCases)*100).toFixed(2);
                     var deathPercentage=parseFloat((worldDeaths/worldCases)*100).toFixed(2);
                     $("#totalCases").html(worldCases);
                     $("#totalCured").html(worldCured+"<span style='font-size:10px'> ("+curedPercentage+"%)</span>");
                     $("#totalDeath").html(worldDeaths+"<span style='font-size:10px'>("+deathPercentage+"%)</span>");
                     
                $('#mapcontainer').vectorMap({
                     map: 'world_merc',
                     series: {
                     regions: [{
                     values: infectedData,
                     scale: ['#9c3030', '#FF4848'],
                     normalizeFunction: 'polynomial'
                     }]
                     },
                     backgroundColor:"#010f1a",
                     onRegionTipShow: function(e, el, code){
                         var html="";
                         html+="<br/>Cases : "+ infectedData[code];
                         html+="<br/>Deaths : "+countryWiseDeaths[code];
                         html+="<br/> Cured : "+countryWiseCured[code];
                        
                         var deathPercentage=parseFloat((countryWiseDeaths[code]/infectedData[code])*100).toFixed(2);
                         html+="<br/> DeathPercentage :"+deathPercentage+"%";
                           el.html(el.html()+ html);
                     }
                });

        
                }
            })
            // $('#mapcontainer').vectorMap({map: 'world_merc'});
        }
        loadmap();
        setInterval(function(){
            loadmap();
        },60000)
    </script>
</body>
</html>
