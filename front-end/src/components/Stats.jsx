import React from 'react'
import { stats } from '../constants'
import styles from '../style'

export default function Stats() {
  return (
    <>
      <section className={`${styles.flexCenter} flex-row flex-wrap sm:mb-20 mb-6`}>
        {stats.map((stat, index) => (
          <div className='flex items-center' key={stat.id}>
            <div className={` flex-1 flex justify-start items-center flex-row m-3`} >
              <h4 className='font-poppins font-semibold xs:text-[40px] text-[30px] xs:leading-[53px] leading-[43px] text-white'>{stat.value}</h4>
              <p className='font-poppins font-norma xs:text-[20px] text-[15px] xs:leading-[26px] leading-[21px] text-gradient uppercase ml-3'>{stat.title}</p>
            </div>
            <div >
              {index === stats.length - 1 ? "" : <div className={`mx-16 w-[14px] h-[2px] border border-[1] border-white transform rotate-90`} />}
            </div>
          </div>
        ))}
      </section>

    </>
  )
}
