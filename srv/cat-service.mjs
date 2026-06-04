import cds from '@sap/cds'

export default cds.service.impl(async function () {
  this.on('submitOrder', async req => {
    const { name, quantity, bookId } = req.data

    const adminSrv = await cds.connect.to('AdminService')

    await adminSrv.create('Orders').entries({
      amount: quantity,
      book_ID: bookId,
      name: name
    })

    return 'Book ordered placed'
  })
})
