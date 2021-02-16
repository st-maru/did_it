function workingTimeCount() {
  const workingTimeCount = document.getElementsByClassName("working_time_count");

  let summary = 0;

  for ( let i = 0; i <= workingTimeCount.length - 1; i++ ) {
    let countNumber = Number(workingTimeCount[i].textContent)
    summary += countNumber
  };

  const workingTime = document.getElementById("working_time")

  workingTime.innerHTML = "作業時間：" + summary + "分"
}

window.addEventListener('turbolinks:load', workingTimeCount)