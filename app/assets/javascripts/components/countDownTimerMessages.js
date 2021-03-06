const list = $('.deadline-date');
$.each(list , function(index, val) {
const countDownDate = new Date(val.id).getTime(); // Set the date we're counting down to

const x = setInterval(function() { // Update the count down every 1 second

  const now = new Date().getTime(); // Get todays date and time
  const distance = countDownDate - now; // Find the distance between now an the count down date

  const days = Math.floor(distance / (1000 * 60 * 60 * 24)); // Time calculations for days, hours, minutes and seconds
  const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  const seconds = Math.floor((distance % (1000 * 60)) / 1000);

  val.innerHTML = days + "d " + (hours+13) + "h " // Display the result in the element with id="demo"
  + (minutes+21) + "m " + seconds + "s ";
  if (distance <= 0) { // If the count down is finished, write some text
    val.innerHTML = "EXPIRED";
  }
}, 1000);
});
