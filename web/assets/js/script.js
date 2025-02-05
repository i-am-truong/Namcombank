(function($){
	'use script';
    $(window).on('load', function(event) {
        $('#preloader').delay(500).fadeOut(500);
    });

	// WOW JS
	new WOW().init();

	// Scroll Area
	$(document).ready(function(){
	    $('.scroll-area').click(function(){
	      	$('html').animate({
	        	'scrollTop' : 0,
	      	},700);
	      	return false;
	    });
	    $(window).on('scroll',function(){
	      	var a = $(window).scrollTop();
	      	if(a>400){
	            $('.scroll-area').slideDown(300);
	        }else{
	            $('.scroll-area').slideUp(200);
	        }
	    });
	});



	/*---slider activation---*/
    var $slider = $('.hero-area-full');
    if($slider.length > 0){
        $slider.owlCarousel({
            // animateOut: 'fadeOut',
            loop: true,
            nav: false,
            autoplay: false,
            autoplayTimeout: 8000,
            items: 1,
            autoplay: true,
            nav:true,
            navText:['<span class="hero-slider-nav"><i class="fa fa-angle-left"></i></span>','<span class="hero-slider-nav"><i class="fa fa-angle-right"></i></span>'],
           dots:true
        });
    }


     /*---Latest Product---*/
    var $latestProduct = $('.latest-product-full');
        if($latestProduct.length > 0){
        $('.latest-product-full').owlCarousel({
            autoplay: true,
            loop: true,
            nav: true,
            autoplay: false,
            autoplayTimeout: 8000,
            items: 4,
            dots:false,
            navText:['<span class="latestProduct-slider-nav"><i class="fa fa-angle-left"></i></span>','<span class="latestProduct-slider-nav"><i class="fa fa-angle-right"></i></span>'],
            responsiveClass:true,
            responsive:{
                    0:{
                    items:1,
                },
                400:{
                    items:2,
                },
                767:{
                    items:3,
                },
                991:{
                    items:4,
                },

            }
        });
     } 



     /*---Tab Slider Product---*/
    var $TabSliderProduct = $('.product-tab-slider-full');
        if($TabSliderProduct.length > 0){
        $('.product-tab-slider-full').owlCarousel({
            autoplay: true,
            loop: true,
            nav: true,
            autoplay: false,
            autoplayTimeout: 8000,
            items: 4,
            dots:false,
            navText:['<span class="tabslider-slider-nav"><i class="fa fa-angle-left"></i></span>','<span class="tabslider-slider-nav"><i class="fa fa-angle-right"></i></span>'],
            responsiveClass:true,
            responsive:{
                    0:{
                    items:1,
                },
                400:{
                    items:2,
                },
                767:{
                    items:3,
                },
                991:{
                    items:4,
                },

            }
        });
     } 


     /*---Instagram Feed---*/
    var $InstagramFeed = $('.instagram-feed-full');
        if($InstagramFeed.length > 0){
        $('.instagram-feed-full').owlCarousel({
            autoplay: true,
            loop: true,
            nav: false,
            autoplay: false,
            autoplayTimeout: 8000,
            items: 5,
            dots:false,
            responsiveClass:true,
            responsive:{
                    0:{
                    items:2,
                },
                400:{
                    items:3,
                },
                767:{
                    items:4,
                },
                991:{
                    items:5,
                },

            }
        });
     } 


     /*---Testimonial---*/
    var $testimonial = $('.testimonial-area');
        if($testimonial.length > 0){
        $('.testimonial-area').owlCarousel({
            autoplay: true,
            loop: true,
            nav: true,
            autoplay: false,
            autoplayTimeout: 8000,
            items: 2,
            dots:false,
            responsiveClass:true,
            navText:['<span class="testimonial-slider-nav"><i class="fa fa-angle-left"></i></span>','<span class="testimonial-slider-nav"><i class="fa fa-angle-right"></i></span>'],
            responsive:{
                    0:{
                    items:1,
                },
                400:{
                    items:1,
                },
                767:{
                    items:2,
                },
                991:{
                    items:2,
                },

            }
        });
     } 

     /*---product navactive activation---*/
    var $productNavactive = $('.product_navactive');
        if($productNavactive.length > 0){
        $('.product_navactive').owlCarousel({
            autoplay: true,
            loop: false,
            nav: true,
            autoplay: false,
            autoplayTimeout: 8000,
            items: 4,
            dots:false,
            navText:['<span class="quickview-slider-nav"><i class="fa fa-angle-left"></i></span>','<span class="quickview-slider-nav"><i class="fa fa-angle-right"></i></span>'],
            responsiveClass:true,
            responsive:{
                    0:{
                    items:1,
                },
                250:{
                    items:2,
                },
                480:{
                    items:3,
                },
                768:{
                    items:4,
                },

            }
        });
     } 
    
     $('.modal').on('shown.bs.modal', function (e) {
        $('.product_navactive').resize();
    })

    $('.product_navactive a').on('click',function(e){
      e.preventDefault();

      var $href = $(this).attr('href');

      $('.product_navactive a').removeClass('active');
      $(this).addClass('active');

      $('.product-details-large .tab-pane').removeClass('active show');
      $('.product-details-large '+ $href ).addClass('active show');

    })


         /**
   * Countdown timer
   */
   var eShopCountdown = $('#eShopCountdown');
    if(eShopCountdown.length > 0){

	  let eShopCountdown = document.getElementById('eShopCountdown');
	  const output = eShopCountdown.innerHTML;

	  const countDownDate = function() {
	    let timeleft = new Date(eShopCountdown.getAttribute('data-countdown-codepopular')).getTime() - new Date().getTime();

	    let days = Math.floor(timeleft / (1000 * 60 * 60 * 24));
	    let hours = Math.floor((timeleft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	    let minutes = Math.floor((timeleft % (1000 * 60 * 60)) / (1000 * 60));
	    let seconds = Math.floor((timeleft % (1000 * 60)) / 1000);

	    eShopCountdown.innerHTML = output.replace('%d', days).replace('%h', hours).replace('%m', minutes).replace('%s', seconds);
	  }
	  countDownDate();
	  setInterval(countDownDate, 1000);
	}


    function basicmap() {
        // Basic options for a simple Google Map
        // For more options see: https://developers.google.com/maps/documentation/javascript/reference#MapOptions
        var mapOptions = {
            // How zoomed in you want the map to start at (always required)
            zoom: 11,
            scrollwheel: false,
            // The latitude and longitude to center the map (always required)
            center: new google.maps.LatLng(40.6700, -73.9400), // New York
            // This is where you would paste any style found on Snazzy Maps.
            styles: [{ "featureType": "water", "elementType": "geometry", "stylers": [{ "color": "#e9e9e9" }, { "lightness": 17 }] }, { "featureType": "landscape", "elementType": "geometry", "stylers": [{ "color": "#f5f5f5" }, { "lightness": 20 }] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [{ "color": "#ffffff" }, { "lightness": 17 }] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [{ "color": "#ffffff" }, { "lightness": 29 }, { "weight": .2 }] }, { "featureType": "road.arterial", "elementType": "geometry", "stylers": [{ "color": "#ffffff" }, { "lightness": 18 }] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [{ "color": "#ffffff" }, { "lightness": 16 }] }, { "featureType": "poi", "elementType": "geometry", "stylers": [{ "color": "#f5f5f5" }, { "lightness": 21 }] }, { "featureType": "poi.park", "elementType": "geometry", "stylers": [{ "color": "#dedede" }, { "lightness": 21 }] }, { "elementType": "labels.text.stroke", "stylers": [{ "visibility": "on" }, { "color": "#ffffff" }, { "lightness": 16 }] }, { "elementType": "labels.text.fill", "stylers": [{ "saturation": 36 }, { "color": "#333333" }, { "lightness": 40 }] }, { "elementType": "labels.icon", "stylers": [{ "visibility": "off" }] }, { "featureType": "transit", "elementType": "geometry", "stylers": [{ "color": "#f2f2f2" }, { "lightness": 19 }] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [{ "color": "#fefefe" }, { "lightness": 20 }] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [{ "color": "#fefefe" }, { "lightness": 17 }, { "weight": 1.2 }] }]
        };
        // Get the HTML DOM element that will contain your map 
        // We are using a div with id="map" seen below in the <body>
        var mapElement = document.getElementById('contact-map');

        // Create the Google Map using our element and options defined above
        var map = new google.maps.Map(mapElement, mapOptions);

        // Let's also add a marker while we're at it
        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(40.6700, -73.9400),
            map: map,
            title: 'Cryptox'
        });
    }
    if ($('#contact-map').length != 0) {
        google.maps.event.addDomListener(window, 'load', basicmap);
    }


    jQuery('<div class="quantity-nav"><div class="quantity-button quantity-up">+</div><div class="quantity-button quantity-down">-</div></div>').insertAfter('.quantity input');
    jQuery('.quantity').each(function() {
      var spinner = jQuery(this),
        input = spinner.find('input[type="number"]'),
        btnUp = spinner.find('.quantity-up'),
        btnDown = spinner.find('.quantity-down'),
        min = input.attr('min'),
        max = input.attr('max');

      btnUp.click(function() {
        var oldValue = parseFloat(input.val());
        if (oldValue >= max) {
          var newVal = oldValue;
        } else {
          var newVal = oldValue + 1;
        }
        spinner.find("input").val(newVal);
        spinner.find("input").trigger("change");
      });

      btnDown.click(function() {
        var oldValue = parseFloat(input.val());
        if (oldValue <= min) {
          var newVal = oldValue;
        } else {
          var newVal = oldValue - 1;
        }
        spinner.find("input").val(newVal);
        spinner.find("input").trigger("change");
      });

    });
    

}(jQuery));