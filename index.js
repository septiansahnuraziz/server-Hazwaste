var express = require('express');
const bodyParser = require('body-parser');
var app = express();
var cors = require('cors');
const db = require('./queries');
app.options('*', cors());

app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)
app.use(cors());

app.get('/', cors(), function (req, res) {
  res.send('Hello World!');
  res.json({
    msg: 'This is CORS-enabled for localhost:3000 domain'
  })
// response.json({ info: 'Node.js, Express, and Postgres API' })
});
app.listen(80, function () {
  console.log('CORS-enabled web server listening on port 80')
});

app.get('/kendaraan', cors(), db.allKendaraan);

app.get('/availableVehicle', db.getAvailableVehicle);
app.get('/pengemudi', db.allPengemudi);
app.get('/availableDriver', db.getAvailableDriver);
app.get('/penghasil', db.allPenghasil);
app.get('/penghasil/:id', db.getPenghasilById);
app.get('/kemasan', db.allKemasan);
app.get('/kemasan/:id', db.getKemasanById);
app.get('/jenis', db.allJenisLimbah);
app.get('/jenis/:kode_limbah', db.getLimbahByKode)
app.get('/unit', db.allUnit);
app.get('/unit/:id', db.getUnitById);
app.get('/activeTransport/:plat', db.getActiveTransport);
app.get('/activeVehicle/:penghasil', db.getActiveVehiclebyPenghasil);
app.get('/activeVehicle', db.getActiveVehicle);
app.get('/manifest/:id_penghasil&:plat', db.getManifestbyPenghasil);
app.get('/manifest/:plat', db.getManifestbyTruck);
app.get('/kendaraan/:plat', db.detailKendaraan);
app.get('/pengelola', db.allPengelola)

app.options('/kendaraan', cors());
app.post('/kendaraan', cors(), db.createKendaraan);
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