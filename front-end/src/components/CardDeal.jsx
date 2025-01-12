import React from 'react'
import styles,{layout}  from '../style'
import { card } from '../assets'
import Button from './Button'

export default function CarDeal() {
  return (
    <section className={layout.section}>
      <div className="layout.sectionInfo">
        <h2 className={styles.heading2}> Find a better card deal <br className='sm:block hidden' /> in few easy steps.</h2>
        <p className={`${styles.paragraph} max-w-[480px] mt-5`}>By understanding your options and asking the right questions, you can find the card that's the best fit for your spending habits and credit situation.</p>
        <Button styles='mt-10'/>
      </div>
      <div className={layout.sectionImg}>
        <img src={card} alt={card} className="w-[100%] h-[100%]"/>
      </div>
    </section>
  )
}
