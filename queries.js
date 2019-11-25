const Pool = require('pg').Pool
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'hazwate',
  password: 'admin',
  port: 5432,
})

const detailKendaraan = (request, response) => {
    const plat= request.params.plat
    pool.query ('SELECT * FROM KENDARAAN WHERE PLAT LIKE $1',[plat], (error, results)=>{
    if (error){
        throw error
    }
    response.status(200).json(results.rows)
    })
}

const allPengemudi = (request, response) => {
    pool.query (
        'SELECT * FROM pengemudi ORDER BY NAMA',(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const allKendaraan = (request, response) => {
    pool.query (
        'SELECT * FROM Kendaraan ORDER BY Plat',(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const allPenghasil = (request, response) => {
    pool.query (
        'SELECT * FROM PENGHASIL ORDER BY NAMA',(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const allJenisLimbah = (request, response) => {
    pool.query (
        'SELECT * FROM jenis_limbah ORDER BY jenis',(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const allKemasan = (request, response) => {
    pool.query (
        'SELECT * FROM kemasan ORDER BY kemasan',(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const allUnit = (request, response) => {
    pool.query (
        'SELECT * FROM unit ORDER BY unit',(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const createKendaraan = (request, response) => {
    const {plat, jenis, no_klh} = request.body

    pool.query (
        'INSERT INTO kendaraan(plat, jenis, no_klh) VALUES ($1, $2, $3)',
        [plat, jenis, no_klh], (error, results) => {
            if (error) {
                throw error
            }
            response.status(201).send('Vehicle added with ID:${result.plat}')
        }
    )
}

const createPengemudi = (request, response) => {
    const {sim, nama, telepon} = request.body

    pool.query (
        'INSERT INTO pengemudi(sim, nama, telepon) VALUES ($1, $2, $3)',
        [sim, nama, telepon], (error, results) => {
            if (error) {
                throw error
            }
            response.status(201).send('Driver added with ID:${result.insertId}')
        }
    )
}

const createPenghasil = (request, response) => {
    const {nama, lokasi} = request.body

    pool.query (
        'INSERT INTO penghasil(nama, alamat) VALUES ($1, $2)',
        [nama, lokasi], (error, results) => {
            if (error) {
                throw error
            }
            response.status(201).send('Client added with ID:${result.insertedId}')
        }
    )
}

const createIjin = (request, response) => {
    const {nomor, mulai, selesai} = request.body

    pool.query (
        'INSERT INTO ijin(no_ijin, berlaku_mulai, berlaku_sampai) VALUES ($1, $2, $3)',
        [nomor, mulai, selesai], (error, results) => {
            if (error) {
                throw error
            }
            response.status(201).send('License added with ID:${result.insertedId}')
        }
    )
}

const createTransport = (request, response) => {
    const {plat, sim, status, tanggal} = request.body

    pool.query (
        'INSERT INTO perjalanan(plat, sim, status, tanggal) VALUES ($1, $2, $3, $4)',
        [plat, sim, status, tanggal], (error, results) => {
            if (error) {
                throw error
            }
            response.status(201).send('License added with ID:${result.insertedId}')
        }
    )
}

const createManifest= (request, response) => {
    const {id_perjalanan, id_penghasil, jumlah, bobot, id_unit, id_kemasan, id_limbah, id_tujuan} = request.body

    pool.query (
        'INSERT INTO limbah(id_perjalanan, id_penghasil, jumlah, bobot, id_unit, id_kemasan, id_limbah, id_tujuan) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)',
        [id_perjalanan, id_penghasil, jumlah, bobot, id_unit, id_kemasan, id_limbah, id_tujuan], (error, results) => {
            if (error) {
                throw error
            }
            response.status(201).send('Manifest added with ID:${result.insertedId}')
        }
    )
}

const createTracking= (request, response) => {
    const {id_perjalanan, waktu, posisi_lintang, posisi_bujur} = request.body

    pool.query (
        'INSERT INTO histori_perjalanan(id_perjalanan, waktu, posisi_lintang, posisi_bujur) VALUES ($1, $2, $3, $4)',
        [id_perjalanan, waktu, posisi_lintang, posisi_bujur], (error, results) => {
            if (error) {
                throw error
            }
            response.status(201).send('Position added with ID:${result.insertedId}')
        }
    )
}

const getActiveTransport = (request, response) => {
    const plat= request.params.plat
    pool.query (
        'SELECT ID FROM perjalanan where plat LIKE $1 and status = 1', [plat],(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const getActiveVehicle = (request, response) => {
    pool.query (
        'SELECT PLAT FROM perjalanan WHERE STATUS = 1',(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const getActiveVehiclebyPenghasil = (request, response) => {
    const id_penghasil= request.params.penghasil
    pool.query (
        'SELECT plat FROM limbah,perjalanan WHERE id_penghasil = $1 AND id_perjalanan = perjalanan.id AND status = 1',[id_penghasil],(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const getManifestbyPenghasil = (request, response) => {
    const id_penghasil = request.params.id_penghasil
    const plat= request.params.plat
    
    pool.query (
        'SELECT limbah.* FROM limbah,perjalanan WHERE id_penghasil = $1 AND id_perjalanan = perjalanan.id AND status = 1 and plat=$2',[id_penghasil, plat],(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const getManifestbyTruck = (request, response) => {
    const plat= request.params.plat
    
    pool.query (
        'SELECT limbah.* FROM limbah,perjalanan WHERE id_perjalanan = perjalanan.id AND status = 1 and plat=$1',[plat],(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const getAvailableDriver = (request, response) => {
    
    pool.query (
        'SELECT * FROM pengemudi WHERE sim not in (select sim from perjalanan where status = 1)',(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const getAvailableVehicle = (request, response) => {
    
    pool.query (
        'SELECT * FROM kendaraan WHERE plat not in (select plat from perjalanan where status = 1)',(error, results)=> {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
    })
}

const updateStatusPerjalanan = (request, response) =>{
    const id = parseInt(request.params.id)
    const {status} = request.body

    pool.query(
        'UPDATE PERJALANAN SET STATUS=$1 WHERE ID=$2', [status, id], (error, results) =>{
            if(error){
                throw error
            }
            response.status(200).send('Perjalanan modified with ID: ${id}')
        }
    )
}

module.exports = { detailKendaraan, allPengemudi, allPenghasil, allKendaraan,
    allKemasan, allJenisLimbah, allUnit, createIjin, createKendaraan, createPengemudi,
    createPenghasil, createTransport, createManifest, createTracking, getActiveTransport,
    getActiveVehicle, getActiveVehiclebyPenghasil, getManifestbyPenghasil, getManifestbyTruck,
    getAvailableDriver, getAvailableVehicle, updateStatusPerjalanan
  }
