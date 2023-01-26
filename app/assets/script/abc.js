const startButton = document.getElementById('startTime')
const endButton = document.getElementById('endTime')
const startTime = document.querySelectorAll('.start-time')
const test = startTime[startTime.length - 1].textContent
// const endDefaultTime=document.getElementById()
startButton.onclick = () => {
  const date = new Date()
  const startTime = createStartTime(date)
  date.getHours()
  const data = {
    attendances_time: '8:00',
    date: createDate(date),
    start_time: startTime,
    end_time: null,
    end_default_time: '19:00',
    rest_time: '01:00',
    actual_time: null,
    over_time: '02:00',
    attendances_flag: true
  }
  sendRequest(data)
}
endButton.onclick = () => {
  const date = new Date()
  const endTime = createEndTime(date)
  console.log(startTime)
  const data = {
    attendances_time: '8:00',
    date: createDate(date),
    start_time: test,
    end_time: endTime,
    end_default_time: '19:00',
    rest_time: '01:00',
    actual_time: diffTime(test, endTime),
    over_time: '02:00',
    attendances_flag: true
  }
  console.log(diffTime(test, endTime))
  sendRequest(data)
}

const sendRequest = data => {
  const token = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute('content')
  const headers = {
    'X-CSRF-Token': token
  }
  axios
    .post('http://localhost:3000/users/4/attendances', data, {
      headers: headers
    })

    .then(() => {
      location.reload()
    })

    .catch(err => {
      console.log('err:', err)
    })
}

const createDate = date => {
  const createdDate = `${date.getFullYear()}/${(date.getMonth() + 1)
    .toString()
    .padStart(2, '0')}/${date.getDate().toString().padStart(2, '0')}`
  console.log(createdDate)
  return createdDate
}

const createStartTime = date => {
  const createdTime = `${date.getHours().toString().padStart(2, '0')}:${date
    .getMinutes()
    .toString()
    .padStart(2, '0')}`
  console.log(createdTime)
  return createdTime
}

const createEndTime = date => {
  const createdTime = `${date.getHours().toString().padStart(2, '0')}:${date
    .getMinutes()
    .toString()
    .padStart(2, '0')}`
  console.log(createdTime)
  return createdTime
}

const diffTime = (start_time, end_time) => {
  if (start_time && end_time) {
    console.log(start_time.trim().substr(1, 1))
    const startHour = Number(start_time.trim().substr(1, 1)) * 60
    const startMinute = Number(start_time.trim().substr(3, 2))
    const endHour = Number(end_time.trim().substr(1, 1)) * 60
    const endMinute = Number(end_time.trim().substr(3, 2))
    return (endHour + endMinute - (startHour + startMinute)) / 60
  }
}

const isUpdate = () => {}
