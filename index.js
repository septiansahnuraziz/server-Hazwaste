var express = require('express');
const bodyParser = require('body-parser');
var app = express();
const db = require('./queries');

app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

app.get('/', function (req, res) {
  res.send('Hello World!');
// response.json({ info: 'Node.js, Express, and Postgres API' })
});

app.get('/kendaraan', db.allKendaraan);
app.get('/availableVehicle', db.getAvailableVehicle);
app.get('/pengemudi', db.allPengemudi);
app.get('/availableDriver', db.getAvailableDriver);
app.get('/penghasil', db.allPenghasil);
app.get('/kemasan', db.allKemasan);
app.get('/jenis', db.allJenisLimbah);
app.get('/unit', db.allUnit);
app.get('/activeTransport/:plat', db.getActiveTransport);
app.get('/activeVehicle/:penghasil', db.getActiveVehiclebyPenghasil);
app.get('/activeVehicle', db.getActiveVehicle);
app.get('/manifest/:id_penghasil&:plat', db.getManifestbyPenghasil);
app.get('/manifest/:plat', db.getManifestbyTruck);
app.get('/kendaraan/:plat', db.detailKendaraan);
app.post('/kendaraan', db.createKendaraan);
app.post('/pengemudi', db.createPengemudi);
app.post('/penghasil', db.createPenghasil);
app.post('/ijin', db.createIjin);
app.post('/perjalanan', db.createTransport);
app.post('/manifest', db.createManifest);
app.post('/posisi', db.createTracking);
app.put('/transport/:id', db.updateStatusPerjalanan);
//app.delete('/users/:id', db.deleteUser)

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});