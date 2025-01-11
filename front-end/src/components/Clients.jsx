import React from 'react'
import { clients } from '../constants'
import styles from '../style'

export default function Clients() {
  return (
    <section className={`${styles.flexCenter} my-4`}>
      <div className={`${styles.flexCenter} flex-wrap w-full`}>
        {
          clients.map((client, index) => (
            <div key={client.logo} className={`flex-1 ${styles.flexCenter} sm:min-w-[1000px] min-w-[120px] m-5`}>
              <img src={client.logo} alt={client.logo} className='sm:w-[400px] w-[100px] object-contain'/>
            </div>
          ))
        }
      </div>
    </section>
  )
}
