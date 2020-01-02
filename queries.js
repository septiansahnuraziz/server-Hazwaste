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

const allPengelola = (request, response) => {
    pool.query (
        'SELECT * FROM PENGELOLA ORDER BY id', (error, results) => {
            if(error) {
                throw error
            }
            response.status(200).json(results.rows)
        }
    )
}

const createKendaraan = (request, response) => {
    const {plat, jenis, no_klh} = request.body

    pool.query (
        'INSERT INTO kendaraan(plat, jenis, no_klh) VALUES ($1, $2, $3)',
        [plat, jenis, no_klh], (error, results) => {
            if (error) {
                throw error
            }
            response.status(201).json({
                status: 'success',
                message: 'Berhasil menambahkan Kendaraan',
                data: request.body
            })
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
            response.status(201).json({
                status: 'success',
                message: 'Berhasil menambahkan Pengemudi',
                data: request.body
            })
        }
    )
}

const createPenghasil = (request, response) => {
    const {nama, lokasi, latitude, longitude} = request.body

    pool.query (
        'INSERT INTO penghasil(nama, alamat, latitude, longitude) VALUES ($1, $2, $3, $4)',
        [nama, lokasi, latitude, longitude], (error, results) => {
            if (error) {
                throw error
            }
            response.status(201).json({
                status: 'success',
                message: 'Berhasil menambahkan Penghasil',
                data: request.body
            })
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
            response.status(201).json({
                status: 'success',
                message: 'Berhasil menambahkan Ijin',
                data: request.body
            })
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
            response.status(201).json({
                status: 'success',
                message: 'Berhasil menambahkan transport',
                data: request.body
            })
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
            response.status(201).json({
                status: 'success',
                message: 'Berhasil menambahkan Manifest',
                data: request.body
            })
        }
    )
}

const updateLastManifest = (request, response) => {
    const {id_perjalanan, tanggal} = request.body
    pool.query (
        'UPDATE limbah SET id_perjalanan = $1, tanggal = $2 where manifest_no = (SELECT max(manifest_no) FROM limbah)',
        [id_perjalanan, tanggal], (error, results) => {
            if (error) {
                throw error
            }
            response.status(201).json({
                status: 'success',
                message: 'Berhasil mengupdate id_perjalanan dan tanggal pada Manifest terakhir',
                data: request.body
            })
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
            response.status(201).json({
                status: 'success',
                message: 'Berhasil membuat History perjalanan',
                data: request.body
            })
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

const getPenghasilById = (request, response) => {
    const id = request.params.id
    pool.query (
        'SELECT * FROM PENGHASIL WHERE id = $1', [id], (error, results) => {
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
        }
    )
}

const getKemasanById = (request, response) => {
    const id = request.params.id
    pool.query (
        'SELECT * FROM KEMASAN WHERE id = $1', [id], (error, results) =>{
            if (error) {
                throw error
            }
            response.status(200).json(results.rows)
        }
    )
}

const getUnitById = (request, response) => {
    const id = request.params.id
    pool.query(
        'SELECT * FROM UNIT WHERE id = $1', [id], (error, results) => {
            if(error) {
                throw error
            }
            response.status(200).json(results.rows)
        } 
    )
}

const getLimbahByKode = (request, response) => {
    const kode_limbah = request.params.kode_limbah
    pool.query (
        'SELECT * FROM JENIS_LIMBAH WHERE kode_limbah = $1', [kode_limbah], (error, results) => {
            if(error) {
                throw error
            }
            response.status(200).json(results.rows)
        }
    )
}

const getManifestByNomor = (request, response) => {
    const manifest_no = request.params.manifest_no
    pool.query (
        'SELECT * FROM limbah order by manifest_no desc limit 1', (error, results) => {
            if(error) {
                throw error
            }
            response.status(200).json(results.rows)
        }
    )
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
    allKemasan, allJenisLimbah, allUnit, allPengelola,createIjin, createKendaraan, createPengemudi,
    createPenghasil, createTransport, createManifest, createTracking, getActiveTransport,
    getActiveVehicle, getActiveVehiclebyPenghasil, getManifestbyPenghasil, getPenghasilById, getManifestbyTruck,
    getAvailableDriver, getAvailableVehicle, getLimbahByKode, getKemasanById, getUnitById, getManifestByNomor,updateLastManifest, updateStatusPerjalanan
  }
