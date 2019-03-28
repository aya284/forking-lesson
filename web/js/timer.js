/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var timer_time;
function timer(){
                var time_left = 30;
                var space = document.getElementById('space');

                this.timer_time = setInterval(countdown, 1000);
                function countdown(){
                    if(time_left === -1){
                        clearTimeout(timer_time);
                        document.getElementById('optiontable').innerHTML = '';
                        var flag = true;
                        setInterval(function blink(){
                            if(flag === true){
                            document.getElementById('space').style.color = "#444";
                            flag = false;
                            }
                            else{
                            document.getElementById('space').style.color = "white";
                            flag = true;

                            }
                        } , 1000);
                    }
                    else{
                        space.innerHTML = "0:" + time_left + " sec left";
                        time_left--;
                    }
                }
            }