import React from 'react'
import styles from '../../style'
import { arrowUp } from '../../assets'

export default function GetStarted() {
  return (
    <div className={`${styles.flexCenter} w-[140px] h-[140px] rounded-full bg-blue-gradient p-[2px] cursor-pointer`}>
      <div className={`${styles.flexCenter} flex-col bg-primary w-[100%] h-[100%] rounded-full`}>
        <div className={`${styles.flexStart} flex-row`}>
          <p className='font-poppins font-medium text-[18px] leading-[23px] mr-1'>
            <a href='/login' className='text-gradient'>Get</a>
          </p>
          <img src={arrowUp} className='w-[23px] h-[23px] object-contain' alt={arrowUp} />
        </div>
        <p className='font-poppins font-medium text-[18px] leading-[23px]'>
          <a href='/login' className='text-gradient'>Started</a>
        </p>
      </div>
    </div>
  )
}
