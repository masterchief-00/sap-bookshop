import cds from '@sap/cds'
import { INSERT, SELECT, UPDATE } from '@sap/cds/lib/ql/cds-ql.js'

export default cds.service.impl(async function () {
  const { Books, Orders } = this.entities

  this.before('CREATE', 'Orders', async req => {
    const order = req.data

    if (order) {
      const targetBookId = order.book_ID

      const bookExists = await SELECT.one
        .from(Books)
        .where({ ID: targetBookId, stock: { '>': order.amount } })

      if (!bookExists) {
        return req.reject(
          404,
          `Validation Failed: Book with ID ${targetBookId} is not available in the specified amounts.`
        )
      }
    }
  })

  this.on('CREATE', 'Orders', async req => {
    const order = req.data

    const newOrder = await INSERT.into(Orders).entries({
      amount: order.amount,
      book_ID: order.book_ID,
      name: order.name
    })

    console.log(newOrder)

    if (!newOrder) return req.reject(500, 'The order could not be created.')

    const updatedBook = await UPDATE(Books)
      .set`stock = stock - ${order.amount}`.where({ ID: order.book_ID })

    return updatedBook
  })
})
