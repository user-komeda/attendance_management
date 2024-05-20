const startButton = document.getElementById('startTime')
const endButton = document.getElementById('endTime')
const csvExportbutton = document.getElementById('csvExport')
const excellExportButton = document.getElementById('xlsxExport')
const leftIconArrow = document.getElementById("left-icon-arrow")
const rightIconArrow = document.getElementById("right-icon-arrow")
const id = Number(document.getElementById("currentDateId").textContent) + new Date().getDate() - 1
const userId = document.getElementById("userId").textContent.trim()
console.log(userId)
console.log(new Date().getDate())
// const endDefaultTime=document.getElementById()
startButton.onclick = () => {
    const date = new Date()
    const startTime = createStartTime(date)
    date.getHours()
    const data = {
        id: id,
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
    const startTime = document.querySelectorAll('.start-time')
    const test = startTime[startTime.length - 1].textContent

    const date = new Date()
    const endTime = createEndTime(date)

    const data = {
        id: id,
        // attendances_time: '8:00',
        // date: createDate(date),
        // start_time: test,
        end_time: endTime,
        // end_default_time: '19:00',
        // rest_time: '01:00',
        actual_time: diffTime(test, endTime)
        // actual_time: '08:00'
        // over_time: '02:00',
        // attendances_flag: true
    }
    const token = document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute('content')
    const headers = {
        'X-CSRF-Token': token
    }

    axios
        .put(`http://localhost:3000/users/${userId}/attendances/${id}`, data, {
            headers: headers
        })

        .then(() => {
            location.reload()
        })

        .catch(err => {
            console.log('err:', err)
        })
}

csvExportbutton.onclick = () => {
    axios
        .get(`http://localhost:3000/users/${userId}/exportCsv`, {responseType: 'blob'})

        .then(res => {
            console.log(res)
            const name = res.headers['content-disposition']
            const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/ // 正規表現でfilenameを抜き出す
            const matches = filenameRegex.exec(name)
            console.log(matches[1].trim().slice(1).slice(0, -1))

            const blob = new Blob([res.data], {type: res.data.type})
            saveAs(blob, matches[1].trim().slice(1).slice(0, -1))
            // location.reload()
        })

        .catch(err => {
            console.log('err:', err)
        })
}

excellExportButton.onclick = () => {
    axios
        .get(`http://localhost:3000/users/1/exportXlsx`, {responseType: 'blob'})

        .then(res => {
            console.log(res)
            const name = res.headers['content-disposition']
            const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/ // 正規表現でfilenameを抜き出す
            const matches = filenameRegex.exec(name)
            console.log(matches[1].trim().slice(1).slice(0, -1))

            const blob = new Blob([res.data], {type: res.data.type})
            saveAs(blob, matches[1].trim().slice(1).slice(0, -1))
            // location.reload()
        })

        .catch(err => {
            console.log('err:', err)
        })
}

leftIconArrow.onclick = () => {
    const dateString = document.getElementById("today").textContent
    const newDate = new Date(dateString)
    newDate.setMonth(newDate.getMonth() - 1)

    const formatedDate = newDate.toLocaleDateString("ja-JP", {
        year: "numeric", month: "2-digit"
    })
    location.href = `http://localhost:3000/users/${userId}/attendances?date=${formatedDate}`
}

if (rightIconArrow) {
    rightIconArrow.onclick = () => {
        const dateString = document.getElementById("today").textContent
        const newDate = new Date(dateString)
        newDate.setMonth(newDate.getMonth() + 1)

        const formatedDate = newDate.toLocaleDateString("ja-JP", {
            year: "numeric", month: "2-digit"
        })
        location.href = `http://localhost:3000/users/${userId}/attendances?date=${formatedDate}`
    }
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
        const actualTime =
            (endHour + endMinute - (startHour + startMinute)) / 60 + 1.35

        console.log(actualTime)
        const text = actualTime.toString().split('.')[1]
        return (
            Math.trunc(Math.floor((actualTime * 100) / 100))
                .toString()
                .padStart(2, 0) +
            ':' +
            text
        )
    }
}

const isUpdate = () => {
}
