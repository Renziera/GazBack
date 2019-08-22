const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

exports.syncKendaraan = functions.firestore
    .document('pengguna/{user_id}/kendaraan/{id}')
    .onCreate(async (snap, context) => {
        const data = snap.data();
        await db.collection('kendaraan').doc(context.params.id).set({
            plat: data.plat,
            pengguna_id: context.params.user_id,
        });
    });

exports.deleteUser = functions.firestore
    .document('pengguna/{user_id}/kendaraan/{id}')
    .onDelete(async (snap, context) => {
        await db.collection('kendaraan').doc(context.params.id).delete();
    });

exports.syncTransaksi = functions.firestore
    .document('pengguna/{user_id}/kendaraan/{id}/pengisian/{transaksi_id}')
    .onCreate(async (snap, context) => {
        const data = snap.data();
        await db.collection('pengguna').doc(context.params.user_id)
            .collection('transaksi').doc(context.params.transaksi_id).set(data);
    });