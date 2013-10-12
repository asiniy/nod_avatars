$ ->
  $('#container').imagesLoaded ->
    $("#container").isotope
      itemSelector: ".item"
      layoutMode: "masonry"
