package org.example.travelapp.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.travelapp.model.TravelDAO;
import org.example.travelapp.model.TravelListTO;
import org.example.travelapp.model.TravelTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Service
public class TravelService {

    @Value("${kakao.rest.api.key}")
    private String apiKey;

    @Autowired
    private TravelDAO dao;

    public double[] getCoordinatesFromAddress(String address) {
        try {
            if (address == null || address.trim().isEmpty()) {
                return null; // 주소가 비었으면 좌표 계산하지 않음!
            }

            String encoded = URLEncoder.encode(address, "UTF-8");
            URL url = new URL("https://dapi.kakao.com/v2/local/search/address.json?query=" + encoded);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "KakaoAK " + apiKey);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(sb.toString());
            JsonNode doc = root.path("documents");
            if (doc.isArray() && doc.size() > 0) {
                double lat = doc.get(0).path("y").asDouble();
                double lng = doc.get(0).path("x").asDouble();
                return new double[]{lat, lng};
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<TravelTO> getNearbyPlacesSortedByDistance(TravelTO centerPlace, List<TravelTO> allPlaces) {
        try {
            double[] centerCoords = getCoordinatesFromAddress(centerPlace.getAddress());
            if (centerCoords != null) {
                centerPlace.setLatitude(centerCoords[0]);
                centerPlace.setLongitude(centerCoords[1]);
            }

            List<TravelTO> nearbyPlaces = new ArrayList<>();
            for (TravelTO place : allPlaces) {
                if (place.getNo() == centerPlace.getNo()) continue;

                double[] coords = getCoordinatesFromAddress(place.getAddress());
                if (coords != null) {
                    place.setLatitude(coords[0]);
                    place.setLongitude(coords[1]);
                    double distance = calculateDistance(
                            centerPlace.getLatitude(), centerPlace.getLongitude(),
                            place.getLatitude(), place.getLongitude()
                    );
                    if (distance <= 20.0) {
                        place.setDescription(place.getDescription() + " | " + String.format("%.2f km", distance));
                        nearbyPlaces.add(place);
                    }
                }
            }

            nearbyPlaces.sort(Comparator.comparingDouble(p ->
                    calculateDistance(centerPlace.getLatitude(), centerPlace.getLongitude(), p.getLatitude(), p.getLongitude())
            ));

            return nearbyPlaces;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    private double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        double R = 6371; // 지구 반지름 (km)
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c;
    }

    public List<TravelTO> mainListByTitle() {
        return dao.mainListByTitle();
    }

    public List<TravelTO> mainListByDistrict() {
        return dao.mainListByDistrict();
    }

    public List<TravelTO> getTopSlides() {
        return dao.getTopSlides();
    }

    public List<TravelTO> searchDistrict(String strDistrict) {
        return dao.travelSearchDistrict(strDistrict);
    }

    public List<TravelTO> searchByTitle(String title) {
        return dao.searchByTitle(title);
    }

    public List<TravelTO> searchDescription(String description) {
        return dao.searchDescription(description);
    }

    public TravelTO getDetail(int no) {
        return dao.travelDetails(no);
    }

    public List<TravelTO> getAllPlaces() {
        return dao.getAllPlaces();
    }

    public List<TravelTO> getNearbyByDistrict(String district, int excludeNo) {
        return dao.getNearbyByDistrict(district, excludeNo);
    }

    public TravelListTO searchAllFields(String keyword, int cpage) {
        int totalRecord = dao.getTotalRecordByAll(keyword);
        TravelListTO listTO = new TravelListTO();
        listTO.setCpage(cpage);
        listTO.setTotalRecord(totalRecord);
        int startRow = (cpage - 1) * listTO.getRecordPerPage();

        listTO.setBoardLists(dao.searchAllFields(keyword, startRow, listTO.getRecordPerPage()));
        return listTO;
    }
}