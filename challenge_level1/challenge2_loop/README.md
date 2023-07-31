# test was not ending because everytime check passes LOOP again starts and all the test scenarios provided is of pass, and there is a pointer t5 which mentions how many test scenarios are checked

I took one more register "t6" which will be increased everytime a test sceanrio is checked, and once test scenario exceeds the value 3, test ends