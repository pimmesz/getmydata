var list = $('.deadline-date');
$.each(list , function(index, val) {
<<<<<<< HEAD
=======
  console.log(val.id);
>>>>>>> be2583c31250693f3d7662a2adfc0e163d16ba3f

var countDownDate = new Date(val.id).getTime(); // Set the date we're counting down to

var x = setInterval(function() { // Update the count down every 1 second

  var now = new Date().getTime(); // Get todays date and time
  var distance = countDownDate - now; // Find the distance between now an the count down date
<<<<<<< HEAD
=======
  // console.log(distance);
>>>>>>> be2583c31250693f3d7662a2adfc0e163d16ba3f

  var days = Math.floor(distance / (1000 * 60 * 60 * 24)); // Time calculations for days, hours, minutes and seconds
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);

  val.innerHTML = days + "d " + (hours+13) + "h " // Display the result in the element with id="demo"
  + (minutes+12) + "m " + seconds + "s ";
  if (distance <= 0) { // If the count down is finished, write some text
    val.innerHTML = "EXPIRED";
  }
}, 1000);
});
